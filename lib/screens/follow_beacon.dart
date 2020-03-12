import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_beacon/common.dart';
import 'package:flutter_beacon/screens/popup_dialog.dart';

class FollowBeacon extends StatefulWidget {
  @override
  _FollowBeaconState createState() => _FollowBeaconState();
}

class _FollowBeaconState extends State<FollowBeacon> {
  Widget buildUserList(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        padding: EdgeInsets.all(5),
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) {
          DocumentSnapshot user = snapshot.data.documents[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.account_circle,
                  color: Colors.black,
                ),
                title: Text(
                  user.data['Name'],
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    color: myBoxColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        color: myTextColor,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => Validate(user.data['Name'],
                                user.data['Key'], user.documentID));
                      }),
                ),
              ),
            ),
          );
        },
      );
    } else if (snapshot.connectionState == ConnectionState.done &&
        !snapshot.hasData) {
      return Center(
        child: Text("No users found."),
      );
    } else {
      return Center(
          child: Container(
              width: 100, height: 100, child: CircularProgressIndicator()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Beacon'),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: myGradient),
        child: StreamBuilder(
          stream: Firestore.instance.collection('users').snapshots(),
          builder: buildUserList,
        ),
      ),
    );
  }
}
