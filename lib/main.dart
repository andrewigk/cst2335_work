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
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
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

  @override
  void initState()  {
    super.initState();
    _controller = TextEditingController();
    _controller2 = TextEditingController();

  }




  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  late TextEditingController _controller;
  late TextEditingController _controller2;
  List<String> words =  [] ;

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
              words.add( _controller.value.text );
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
                                Text("Task Number: $rowNum"),
                                GestureDetector(
                                    child:  Text(words[rowNum]),
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
