import Text "mo:base/Text"

module {
    public type task = {
        id : Text;
        description : Text;
        status : Nat;
    };

    public type List<task> = ?(task, List<task>);
};
