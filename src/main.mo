import Result "mo:base/Result";


shared actor class DAO{ //determine why shared?

    public func submit_proposal() : async {

    }

    public func get_proposal() : async {

    }

    public func get_all_proposals() : async {

    }

    public func vote() : async {

    }

    //create neuron by 
    public func stake(amount : Nat, time : Nat) : async {

    }

    public func modify_parameters() : async {

    }

    public func quadratic_voting() : async {

    }

    public func createNeuron() : async {

    }

    public func dissolveNeuron() : async {
        
    }
    //implement locked, dissolving, dissolved, 
    //neuron voting power -> dissolve delay bonus scale lineraly -> age bonus 
    // proposal modify min MB token to vote (by default 1)
    // &amount of voting power to pass 
    // quadratic voting -> voting power = sqrt of MB token balance 
}
