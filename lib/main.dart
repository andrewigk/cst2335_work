import 'package:flutter/material.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Browse Categories", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50,),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Text("Not sure what you're looking for? Do a search, or dive into our most popular categories", style: TextStyle(fontSize: 35,),)
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("By Meat", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50,),)
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:AssetImage("images/beef.jpg"),
                          radius: 125,
                        ),
                        Text("BEEF", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.white))
                      ]
                  ),
                  Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:AssetImage("images/chicken.jpg"),
                          radius: 125,
                        ),
                        Text("CHICKEN", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.white))
                      ]
                  ),
                  Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:AssetImage("images/pork.jpg"),
                          radius: 125,
                        ),
                        Text("PORK", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.white))
                      ]
                  ),
                  Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:AssetImage("images/seafood.jpg"),
                          radius: 125,
                        ),
                        Text("SEAFOOD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.white))
                      ]
                  ),
                ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("By Course", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50,),)
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:AssetImage("images/main.jpg"),
                          radius: 125,
                        ),
                        Positioned(
                            bottom: 15,
                            child: Text("Main Dishes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.black87))
                        )

                      ]
                  ),
                  Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:AssetImage("images/salad.jpg"),
                          radius: 125,
                        ),
                        Positioned(
                            bottom: 20,
                            child:Text("Salad Recipes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.black87))
                        ),
                      ]
                  ),
                  Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:AssetImage("images/side.jpg"),
                          radius: 125,
                        ),
                        Positioned(
                            bottom: 17,
                            child:Text("Side Dishes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.black87))
                        ),
                      ]
                  ),
                  Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:AssetImage("images/crockpot.jpg"),
                          radius: 125,
                        ),
                        Positioned(
                            bottom: 20,
                            child: Text("Crockpot", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.black87))
                        ),
                      ]
                  ),
                ]
            ),
          ],

        ),
      ),
    );
  }
}


