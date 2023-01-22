import Result "mo:base/Result";
import Trie "mo:base/Trie";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import List "mo:base/List";
import Principal "mo:base/Principal";

module {
    public type Result<T, E> = Result.Result<T, E>; // used to return either #ok or #err 
    public type Account = {
        owner : Principal;
        subaccount : ?[Nat8];
      };
    
    public type Proposal = {
        id : Nat;       //Proposal ID
        votes_no : Tokens; // votes for NO
        voters : List.List<Principal>; // list of voters 
        state : ProposalState; //Proposal status 
        proposer : Principal;  //caller
        votes_yes : Tokens;    // votes no
        payload : Text;  //text
    };

    public type Tokens = {amount : Nat};
    public let zeroToken = {amount = 0};


    // Proposal Status 
    public type ProposalState = {
        #open;
        #rejected;
        #passed;
    };


    public type Vote = {#no; #yes};
    public type Vote_id = {vote: Vote; proposal_id : Nat};

    public type DaoStableStorage = {
        accounts: [Account];
        proposals: [Proposal];
    };



    //account to array set hashmapdata to array 
    //preupgrade
    //postupgrade -> write array to the hashmap 

    //proposals to array 
};  
