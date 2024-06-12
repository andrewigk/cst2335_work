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
    loadData();

  }

  void loadData() async{
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    var login = await prefs.getString("Username");
    var passWord = await prefs.getString("Password");
    _controller.text = login;
    _controller2.text = passWord;
    if(login != "" || passWord != "") {
      final snackBar = SnackBar(content: Text('Your previously used Username and Login have been loaded.'),
          action: SnackBarAction(label: 'Clear Saved Data', onPressed: () {
            EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
            prefs.remove("Username");
            prefs.remove("Password");
            _controller.text = "";
            _controller2.text = "";
          },));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    }


  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  var isChecked = false;
  var imageSource = "images/question.png";
  late TextEditingController _controller;
  late TextEditingController _controller2;

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
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(controller: _controller, decoration: InputDecoration(
                hintText: "Username", border: OutlineInputBorder(), labelText: "Log-In"
            )), SizedBox(height: 10),
            TextField(controller :_controller2, decoration: InputDecoration(
                hintText: "Password", border: OutlineInputBorder(), labelText: "Password"
            ), obscureText:true),
            ElevatedButton( onPressed: () {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                      title: const Text('Save credentials?'),
                      content: const Text('Click "Yes" to save Username/Password.'),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            OutlinedButton(onPressed: () {
                              var userName = _controller.value.text;
                              EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
                              prefs.setString("Username", userName);
                              var password = _controller2.value.text;
                              prefs.setString("Password", password);
                              Navigator.pop(context);
                            },
                                child: Text("Yes")),
                            OutlinedButton(onPressed: () {
                              EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
                              prefs.remove("Username");
                              prefs.remove("Password");
                              Navigator.pop(context);
                            },
                                child: Text("No"))

                          ]
                        )

                      ]));
              var pword = _controller2.value.text;
              setState(() {
                if (pword  == "QWERTY123"){
                  imageSource = "images/lightbulb.png";
                  Navigator.pushNamed(context, '/profilePage');
                }
                else {
                  imageSource = "images/stop.png";
                }
              });
            }, child:  Text("Log In"),),
            Image.asset(imageSource, width:300, height:300),

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
