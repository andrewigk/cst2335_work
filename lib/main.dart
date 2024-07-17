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
  ToDoItem? selectedItem;
  int selectedRow = 0;


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

  Widget responsiveLayout(){
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    // If in landscape orientation
    if((width>height) && (width>720)){
      return Row(children: [
        Expanded( flex:2, child: ToDoList()),
        Expanded( flex:1, child: DetailsPage()),
      ]);
    }
    // Portrait orientation
    else {
      if (selectedItem == null) {
        return ToDoList();
      }
      else {
        return DetailsPage();
      }
    }
  }

  Widget DetailsPage() {
    if(selectedItem == null){
      return Text("");
    }
    else{
      return Padding(padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Container(
          padding: const EdgeInsets.all(10.0),
          color: Colors.deepPurple[100],
          child:
              Column( mainAxisAlignment: MainAxisAlignment.start,

              children: [
               Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(16, 64, 16, 0),
                          child: Text("Task selected is:",
                          style: TextStyle(fontSize: 16))
                      )]),
                Row( mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
                          child:
                          Text(selectedItem!.itemName,
                              style: TextStyle(fontSize: 18)))
                        ]),
                Row( mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
                          child: Text("Task ID is: ${selectedItem!.id}",
                          style: TextStyle(fontSize: 12))),
                          ]),

              Padding(padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
                  child:
            ElevatedButton( child:Text("Delete Task"), onPressed:() {
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
                                  todoDao.deleteToDo(selectedItem!);
                                  words.removeAt(selectedRow);
                                  selectedItem = null;
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
            )),
          ])),




            );}
  }


  Widget ToDoList() {
    return Column(
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
                  if(text != ""){
                    var newItem = ToDoItem(ToDoItem.ID++, text);
                    todoDao.insertToDo(newItem);
                    words.add(newItem);
                    _controller.text = "";
                  }

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
                                                onTap: () {
                                                  setState(() {
                                                    selectedItem = words[rowNum];
                                                    selectedRow = rowNum;
                                                  });
                                                },
                                                /* onLongPress: () {
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
                                                } */
                                            ),

                                          ])));
                            }
                        ))
                    );
                }
              }),
        ]);


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: [
            ElevatedButton( child:Text("Back to List"), onPressed:() {
              setState(() {
                selectedItem = null;
              });
            }),
          ],
        ),
        body: responsiveLayout());
  }}


      /* Center(
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
} */
