import Types "types";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import List "mo:base/List";
import Iter "mo:base/Iter";


actor {
    
    stable var s_account = [];
    stable var s_proposals = [];
    stable var next_proposal_id : Nat = 0;

    // token canister for mb token
    let token_can : actor {icrc1_balance_of : Types.Account -> async Nat} = actor ("db3eq-6iaaa-aaaah-abz6a-cai");

    // grab token balance of principal 
    public func balance(acc: Types.Account) : async Nat {
        let token_bal = await token_can.icrc1_balance_of(acc);
        return token_bal;
    };

    //hashmap to hold principle & text -> principal is key 
    var accounts = HashMap.HashMap<Principal, Types.Tokens>(0, Principal.equal, Principal.hash);

    //hash compares keys, nat is key 
    var proposals = HashMap.HashMap<Nat, Types.Proposal>(0, Nat.equal, Hash.hash);

    func proposal_add(id : Nat, proposal : Types.Proposal) {
        proposals.put(id, proposal);
    };

    func proposal_get(id: Nat) : ?Types.Proposal {
        proposals.get(id);
    };

    public shared({caller}) func submit_proposal(this_payload : Types.ProposalPayload) : async {#Ok : Types.Proposal; #Err : Text} {

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
        return #Ok(proposal);
    };

    public shared({caller}) func vote(proposal_id : Int, yes_or_no : Bool) : async {#Ok : (Nat, Nat); #Err : Text} {
        return #Err("Not implemented yet");
    };

    public query func get_proposal(id : Nat) : async ?Types.Proposal {
        return proposal_get(id);
    };
    
    public query func get_all_proposals() : async [(Nat, Types.Proposal)] {
        return Iter.toArray<(Nat, Types.Proposal)>(proposals.entries());
    };
};