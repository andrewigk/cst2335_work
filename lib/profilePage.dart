import 'package:flutter/material.dart';
import 'dataRepository.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>{

  late TextEditingController _controller;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();

    DataRepository.loadData();
    _controller.text = DataRepository.firstName;
    _controller2.text = DataRepository.lastName;
    _controller3.text = DataRepository.phoneNum;
    _controller4.text = DataRepository.emailAddress;

  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _controller, decoration: InputDecoration(
                hintText: "First Name", border: OutlineInputBorder(), labelText: "First Name"

            )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: TextField(
                  controller: _controller2, decoration: InputDecoration(
                  hintText: "Last Name", border: OutlineInputBorder(), labelText: "Last Name"

              ))),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Flexible(
                      child: TextField(
                          controller: _controller3, decoration: InputDecoration(
                          hintText: "Phone Number", border: OutlineInputBorder(), labelText: "Phone Number"
                      )
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: ElevatedButton(
                          onPressed: () {
                            var phoneNum = _controller3.text;
                            canLaunch("tel:$phoneNum").then((itCan) {
                              if (itCan) {
                                launch("tel:$phoneNum");
                              } else {
                                final snacc =  SnackBar (content: Text("You can't make phone calls from this device"));
                                    ScaffoldMessenger.of(context).showSnackBar(snacc);
                              }
                            });
                          },
                      child: Icon(Icons.phone),
                  )),
                  ElevatedButton(
                      onPressed: () {
                        var phoneNum = _controller3.text;
                        canLaunch("sms:$phoneNum").then((itCan) {
                          if (itCan) {
                            launch("sms:$phoneNum");
                          } else {
                            final snacc2 =  SnackBar (content: Text("You can't use SMS from this device"));
                            ScaffoldMessenger.of(context).showSnackBar(snacc2);
                          }
                        });
                      },
                    child: Icon(Icons.textsms),
                  ),
                ]
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Flexible(
                      child: TextField(
                          controller: _controller4, decoration: InputDecoration(
                          hintText: "Email Address", border: OutlineInputBorder(), labelText: "Email Address"
                      )
                      )
                  ),
                  Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: ElevatedButton(
                  onPressed: () {
                  var email = _controller4.text;
                  canLaunch("mailto:$email").then((itCan) {
                  if (itCan) {
                  launch("mailto:$email");
                  } else {
                  final snacc3 =  SnackBar (content: Text("You can't e-mail from this device."));
                  ScaffoldMessenger.of(context).showSnackBar(snacc3);
                  }
                  });
                  },
                  child: Icon(Icons.mail))),

                  ],
            )
            ),
            Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: TextButton(
            onPressed: () {
              DataRepository. firstName = _controller.value.text;
              DataRepository.lastName  = _controller2.value.text;
              DataRepository.phoneNum = _controller3.value.text;
              DataRepository.emailAddress = _controller4.value.text;
              DataRepository.saveData();
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profilePage');
              },
                child: Text("Save Details")
            ))],
        )
      )
    )
    );


  }
}