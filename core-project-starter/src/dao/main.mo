import Types "types";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";

actor {
    //My discord is: iri#1598
    //Feel free to DM me any question.

    // token canister for mb token
    let token_can : actor {icrc1_balance_of : Account -> async Nat} = actor ("db3eq-6iaaa-aaaah-abz6a-cai");


    //hashmap to hold principle & text -> principal is key 
    var accounts = HashMap.HashMap<Principal, Types.Tokens>(0, Principal.equal, Principal.hash);

    //hash compares keys, nat is key 
    var proposals = HashMap.HashMap<Nat, Types.Proposal>(0, Nat.equal, Hash.hash);

    stable var s_account = [];
    stable var s_proposals = [];

    //need to implement tokens 
    type Account = {
        owner : Principal;
        subaccount : ?[Nat8];
      };


    public func balance(p: Principal) : async Nat {
        let account : Account = {
          owner = p;
          subaccount : Null = null;
        };

        let token_bal = await token_can.icrc1_balance_of(account);
        return token_bal;
    };


    public shared({caller}) func submit_proposal(this_payload : Text) : async {#Ok : Types.Proposal; #Err : Text} {
        
        

        return #Err("Not implemented yet");
    };

    public shared({caller}) func vote(proposal_id : Int, yes_or_no : Bool) : async {#Ok : (Nat, Nat); #Err : Text} {
        return #Err("Not implemented yet");
    };

    public query func get_proposal(id : Int) : async ?Types.Proposal {
        return null
    };
    
    public query func get_all_proposals() : async [(Int, Types.Proposal)] {
        return []
    };
};