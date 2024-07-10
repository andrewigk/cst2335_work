import 'package:floor/floor.dart';

@entity // this is the table name in Floor
class ToDoItem{
  static int ID = 1;

  @primaryKey
  final int id;
  final String itemName;

  ToDoItem(this.id, this.itemName){ // shortcut where you can pass parameter and set this reference in one step
    if(id >= ID) {
      ID = id + 1;
    }
  }

}