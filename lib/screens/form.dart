import 'package:flutter/material.dart';
import 'package:flutter_beacon/screens/host_beacon.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter_beacon/common.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _nameController = TextEditingController();

  final _passKeyController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String name = '';
  String passKey = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Beacon'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: myGradient,
        ),
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        width: 420,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        style: TextStyle(color: myTextColor),
                        decoration: InputDecoration(
                          labelText: 'Your name',
                          labelStyle: TextStyle(),
                          border: OutlineInputBorder(),
                        ),
                        controller: _nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your name!';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 6.0),
                      TextFormField(
                        style: TextStyle(color: myTextColor),
                        decoration: InputDecoration(
                          labelText: 'Your Pass Key',
                          border: OutlineInputBorder(),
                        ),
                        controller: _passKeyController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your Pass Key!';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              FlatButton(
                child: Text('Auto generate Pass key'),
                onPressed: () {
                  _passKeyController.text = randomAlpha(5);
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: myBoxColor,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      name = _nameController.text;
                      passKey = _passKeyController.text;
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            HostBeacon(name, passKey),
                      ),
                    );
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: myTextColor,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
