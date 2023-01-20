import Principal "mo:base/Principal";
import Nat "mo:base/Nat";


//call token canister here and query token of principal holder 
actor {

    // Token canister db3eq-6iaaa-aaaah-abz6a-cai

    let token_can : actor {icrc1_balance_of : (Principal) -> async Nat} = actor ("db3eq-6iaaa-aaaah-abz6a-cai");


};