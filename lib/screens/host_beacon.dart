import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool initialized = false;
DocumentReference docRef;

_intializeLocation() async {
  docRef = await Firestore.instance.collection('locations').add({});
  initialized = true;
}

class HostBeacon extends StatefulWidget {
  @override
  _HostBeaconState createState() => _HostBeaconState();
}

class _HostBeaconState extends State<HostBeacon> {
  final Location location = new Location();

  LocationData _location;
  StreamSubscription<LocationData> _locationSubscription;
  String _error;

  _listenLocation() async {
    _locationSubscription = location.onLocationChanged().handleError((err) {
      setState(() {
        _error = err.code;
      });
    }).listen((LocationData currentLocation) {
      setState(() {
        _error = null;

        _location = currentLocation;
        _updateLocation();
      });
    });
  }

  // _stopListen() async {
  //   _locationSubscription.cancel();
  // }

  _updateLocation() async {
    if (initialized == false) {
      _intializeLocation();
    } else {
      docRef.updateData({
        'Key': docRef.documentID,
        'Lati': _location.latitude.toString(),
        'Long': _location.longitude.toString(),
      });
    }
  }

  bool _checkProgress() {
    if (_location == null || docRef == null) {
      return false;
    } else
      return true;
  }

  @override
  Widget build(BuildContext context) {
    _listenLocation();

    return _checkProgress()
        ? Scaffold(
            appBar: AppBar(
              title: Text('Flutter Beacon'),
            ),
            body: Container(
              color: Colors.white,
              padding: EdgeInsets.all(50),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'You are currently hosting a beacon!',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Your live location\n\nLatitude:    ${_location.latitude}\nLongitude:   ${_location.longitude}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Your Pass key is\n\n${docRef.documentID}\n\nShare this Pass Key with your friends so that they can follow your beacon and know about your live location.',
                      style: TextStyle(fontSize: 16),
                    ),
                    RaisedButton(
                      child: Text('Tap here to copy Pass Key to clipboard'),
                      onPressed: () {
                        Clipboard.setData(
                            new ClipboardData(text: docRef.documentID));
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Flutter Beacon'),
            ),
            body: Center(
              child: Container(
                height: 150,
                width: 150,
                child: CircularProgressIndicator(),
              ),
            ),
          );
  }
}
