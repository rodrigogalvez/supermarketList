import Array "mo:base/Array";
import List "mo:base/List";
import Types "types";
import Text "mo:base/Text";

actor {

  var tasks : Types.List<Types.task> = List.nil();

  public query func enumerateStatus() : async [Text] {
    return ["Buscando...", "¡Lo encontré!", "No hay"];
  };

  public func createTask(id : Text, description : Text) {

    let newTask : Types.task = {
      id : Text = id;
      description : Text = description;
      status : Nat8 = 0;
    };

    tasks := List.push(newTask, tasks);
  };

  public func deleteTaskById(id : Text) {
    tasks := List.filter(tasks, func(x : Types.task) : Bool { return id != x.id });
  };

  public func deleteTaskByStatus(status : Nat8) {
    tasks := List.filter(tasks, func(x : Types.task) : Bool { return status != x.status });
  };

  public func changeTaskStatus(id : Text, status : Nat8) {
    tasks := List.map(
      tasks,
      func(x : Types.task) : Types.task {
        if (x.id == id) {
          let newTask : Types.task = {
            id : Text = x.id;
            description : Text = x.description;
            status : Nat8 = status;
          };
          return newTask;
        } else {
          return x;
        };
      },
    );
  };

  public query func countTasksByStatus(status : Nat8) : async Nat {

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

  public query func filterTastksByStatus(status : Nat8) : async [Types.task] {
    return List.toArray(List.filter(tasks, func(x : Types.task) : Bool { return status == x.status }));
  };

  public query func getAllTastks() : async [Types.task] {
    return List.toArray(List.filter(tasks, func(x : Types.task) : Bool { return x.status != 3 }));
  };

};
