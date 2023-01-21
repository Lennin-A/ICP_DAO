import Types "types";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import List "mo:base/List";
import Iter "mo:base/Iter";

actor {
    //use camel case 

    stable var stable_proposals : [(Nat, Types.Proposal)] = [];
    stable var next_proposal_id : Nat = 0;

    // token canister for mb token
    let tokenCan : actor {icrc1BalanceOf : Types.Account -> async Nat} = actor ("db3eq-6iaaa-aaaah-abz6a-cai");
    let webpageCan : actor {update_page : Text -> async () } = actor("v7jdt-niaaa-aaaak-ad75q-cai");

    // grab token balance of principal 
    private func balance(acc: Types.Account) : async Nat {
        let token_bal = await tokenCan.icrc1BalanceOf(acc);
        return token_bal;
    };

    //Proposal hashmap & funcs 
    var proposals = HashMap.HashMap<Nat, Types.Proposal>(0, Nat.equal, Hash.hash);
    func proposal_add(id : Nat, proposal : Types.Proposal) {
        proposals.put(id, proposal);
    };
    func proposal_get(id: Nat) : ?Types.Proposal {
        proposals.get(id);
    };

    public shared({caller}) func submit_proposal(this_payload : Types.ProposalPayload) : async  Types.Result<Types.Proposal, Text> {

        let proposal_id = next_proposal_id;
        next_proposal_id += 1;

        let proposal : Types.Proposal = {
            id = proposal_id;
            proposer = caller;
            payload = this_payload;
            state = #open;
            votes_yes = Types.zeroToken;
            votes_no = Types.zeroToken;
            voters = List.nil();

        };
        proposal_add(proposal_id, proposal);
        return #ok(proposal);
    };

    //connect to http (webpage canister)
    public shared({caller}) func vote(proposal_id : Nat, yes_or_no : Bool) : async Types.Result<Text,Text> {
        let acc : Types.Account  = {owner = caller; subaccount = null;};
        //await to get ride of async Nat
        let acc_tokens = await balance(acc);

        // if yes, update proposal status 
        switch(proposal_get(proposal_id)) {
            case null {return #err("Does not exist silly!")};
            //if not null then it grabs the var, in this case the assoicated proposal 
            case(?proposal) {
                var state = proposal.state;
                if (state != #open ){return #err("Not available to vote on");};
                if(0 == acc_tokens){return #err("Grab a token dumbass");};
                if(List.some(proposal.voters,func (e : Principal) : Bool = e == caller)){
                  return #err("You already voted!");};
                var votes_yes = proposal.votes_yes.amount;
                var votes_no = proposal.votes_no.amount;
                if(yes_or_no){
                  votes_yes := votes_yes + 1;
                } else{
                  votes_no := votes_no + 1;
                };
              
                let voters = List.push(caller, proposal.voters);

                if(votes_yes >= 1){
                    state := #passed;
                    await webpageCan.update_page(proposal.payload.message);
                };
                if(votes_no >= 100){state := #rejected};

                let updated_proposal : Types.Proposal = {
                  id = proposal_id;
                  proposer = proposal.proposer;
                  payload = proposal.payload;
                  state;
                  votes_yes = {amount = votes_yes};
                  votes_no = {amount = votes_no};
                  voters;
                };
                proposal_add(proposal_id, updated_proposal);
            };
        };
        return #ok("Proposal updated!");
    };

    public query func get_proposal(id : Nat) : async ?Types.Proposal {
        return proposal_get(id);
    };
    
    public query func get_all_proposals() : async [(Nat, Types.Proposal)] {
        return Iter.toArray<(Nat, Types.Proposal)>(proposals.entries());
    };


    public func update_proposal(id : Nat, p : Types.Proposal) : async Types.Result<Text,Text> {
        let proposal_data : ?Types.Proposal = proposal_get(id);

        switch(proposal_data) {
          case(null){
            return #err("Proposal does not exist silly!");
          };
          case(?currProposal){

          };
        };
        return #err("Updated Proposal!"); 
    };

    system func preupgrade(){
        stable_proposals := Iter.toArray<(Nat, Types.Proposal)>(proposals.entries());
    };

    system func postupgrade() {
        stable_proposals := [];
    };

};