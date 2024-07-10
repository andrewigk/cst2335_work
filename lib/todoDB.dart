// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:cst2335_summer24/todoItem.dart';
import 'package:cst2335_summer24/todoItemDAO.dart';

part 'todoDB.g.dart';

@Database(version: 1, entities: [ToDoItem])
abstract class AppDatabase extends FloorDatabase {
  ToDoDAO get dao;
}