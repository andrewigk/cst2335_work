import 'package:cst2335_summer24/todoDB.dart';
import 'package:cst2335_summer24/todoItem.dart';
import 'package:cst2335_summer24/todoItemDAO.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dataRepository.dart';
import 'profilePage.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: { '/profilePage': (context) => ProfilePage(),
        '/': (context) => MyHomePage(title: 'My To-Do List'),
      },
      initialRoute: '/',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late ToDoDAO todoDao;
  late TextEditingController _controller;
  late TextEditingController _controller2;
  List<ToDoItem> words =  [] ;

  @override
  void initState()  {
    super.initState();
    _controller = TextEditingController();
    _controller2 = TextEditingController();
    $FloorAppDatabase.databaseBuilder('app_database.db').build().then((database){
      todoDao = database.dao;   // should initialize DAO object
      todoDao.selectAllToDo().then(  (listOfAllItems) {
        setState(() {
          words.addAll(listOfAllItems);
        });

      });
    });
  }



  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child:
        Column(
            children:[
        Padding(padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children:[
          Expanded(
              child:TextField(controller: _controller,
            decoration: InputDecoration(labelText: "Enter a to-do item..."))
          ),
          ElevatedButton( child:Text("Add item"), onPressed:() {
            setState(() {
              var text = _controller.value.text;
              var newItem = ToDoItem(ToDoItem.ID++, text);
              todoDao.insertToDo(newItem);
              words.add(newItem);
              _controller.text = "";
            });
          }),
        ]),
      ),

        Builder(
        builder: (BuildContext context){
      if(words.isEmpty){
        return  Padding(padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("To-Do List is currently empty.")
            ]));
      }
      else{
        return
        Expanded(child: Padding(padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
            child:
            ListView.builder(
                itemCount: words.length,
                itemBuilder: (context, rowNum) {
                  return Padding(padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
                      child: Container(
                          padding: const EdgeInsets.all(10.0),
                          color: Colors.deepPurple[100],
                          child:
                          Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Task Number: ${rowNum + 1} "),
                                GestureDetector(
                                    child:  Text(words[rowNum].itemName),
                                    onLongPress: () {
                                      showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) => AlertDialog(
                                              title: const Text('Delete?'),
                                              content: const Text('Are you sure you want to delete this item?'),
                                              actions: <Widget>[
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: <Widget>[
                                                      OutlinedButton(onPressed: () {
                                                        setState(() {
                                                          todoDao.deleteToDo(words[rowNum]);
                                                          words.removeAt(rowNum);
                                                          Navigator.pop(context);
                                                        });

                                                      },
                                                          child: Text("Yes")),
                                                      OutlinedButton(onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                          child: Text("No"))

                                                    ]
                                                )

                                              ]));
                                    }
                                ),

                              ])));
                }
            ))
        );
      }
      }),
    ])));
  }
}
