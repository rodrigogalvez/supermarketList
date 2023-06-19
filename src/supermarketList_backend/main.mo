import Array "mo:base/Array";
import List "mo:base/List";
import Types "types";
import Text "mo:base/Text";

actor {

  var tasks : Types.List<Types.task> = List.nil();

  public query func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };

  public query func enumerateStatus() : async [Text] {
    return ["Pending", "Found", "Not found", "Delete"];
  };

  public func createTask(id : Text, description : Text) {

    let newTask : Types.task = {
      id : Text = id;
      description : Text = description;
      status : Nat = 0;
    };

    tasks := List.push(newTask, tasks);
  };

  public func deleteTaskById(id : Text) {
    tasks := List.filter(tasks, func(x : Types.task) : Bool { return id != x.id });
  };

  public func deleteTaskByStatus(status : Nat) {
    tasks := List.filter(tasks, func(x : Types.task) : Bool { return status != x.status });
  };

  public query func countTasksByStatus(status : Nat) : async Nat {

    var count = 0;
    List.iterate(
      tasks,
      func(x : Types.task) {
        if (status == x.status) count += 1;
      },
    );
    return count;

    //return List.size<Types.task>(tasks);
  };

  public query func selectTastksByStatus(status : Nat) : async [Types.task] {
    return List.toArray(List.filter(tasks, func(x : Types.task) : Bool { return status == x.status }));
  };

};
