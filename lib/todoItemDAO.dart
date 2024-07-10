// Mark as abstract because Floor library will generate method bodies for us, so we don't need to implement them in our DAO's

import 'package:cst2335_summer24/todoItem.dart';
import 'package:floor/floor.dart';

@dao
abstract class ToDoDAO{

  // Insert statements:
  @insert
  Future<void> insertToDo(ToDoItem t);   // This passes an entire entity and the SQL will be taken care of

  // Delete statements
  @delete
  Future<int> deleteToDo(ToDoItem t);    // passses an entire entity item, and Future>int> will delete an entity where id int = the entity item passed

  // Query statements
  @Query('SELECT * FROM ToDoItem')         // @Query takes a string param, where you write an actual SQL query
  Future<List<ToDoItem>> selectAllToDo();   // remember Future = asynchronous, value is not initialized until runtime

  // Update statements
  @update
  Future<int> updateToDo(ToDoItem t); // same logic as delete, pass in an updated item that matches the id int of the item being passed


}