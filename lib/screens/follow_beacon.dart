import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FollowBeacon extends StatefulWidget {
  @override
  _FollowBeaconState createState() => _FollowBeaconState();
}

class _FollowBeaconState extends State<FollowBeacon> {
  String output = '';
  String passKey = '';
  final _passKeyController = TextEditingController();

  void _updatePassKey() {
    setState(() {
      passKey = _passKeyController.text;
    });
  }

  getSnapShot(String key) {
    return Firestore.instance
        .collection('locations')
        .where('Key', isEqualTo: key)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Beacon'),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            Text(
              'Enter the Pass Key below',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: _passKeyController,
            ),
            SizedBox(height: 8,),
            RaisedButton(
              color: Colors.lightBlueAccent,
              child: Text('ENTER'),
              onPressed: _updatePassKey,
            ),
            SizedBox(height: 70,),
            StreamBuilder(
                stream: getSnapShot(passKey),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text('Please wait connecting to database');
                  } else if (snapshot.data.documents.length == 0) {
                    return Text(
                      'No match found with the Pass Key above.',
                      style: TextStyle(fontSize: 20),
                    );
                  } else {
                    return Text(
                      'Match Found!😃\n\n Showing live location of the beacon\nLatitude: ${snapshot.data.documents[0]['Lati']}\nLongitude: ${snapshot.data.documents[0]['Long']}',
                      style: TextStyle(fontSize: 20),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
