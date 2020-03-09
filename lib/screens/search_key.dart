import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class SearchKey extends StatefulWidget {
  @override
  _SearchKeyState createState() => _SearchKeyState();
}

class _SearchKeyState extends State<SearchKey> {
  Future getPassKeys() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('locations').getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Beacon'),
      ),
      body: Container(
        child: FutureBuilder(
            future: getPassKeys(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text('Loading...'),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        leading: Icon(Icons.vpn_key),
                        title: Text(snapshot.data[index].documentID),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.content_copy,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Clipboard.setData(new ClipboardData(
                                text: snapshot.data[index].documentID));
                          },
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}
