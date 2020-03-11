import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';

class HostBeacon extends StatefulWidget {
  final String userName;
  final String passKey;
  HostBeacon(this.userName, this.passKey);

  @override
  _HostBeaconState createState() => _HostBeaconState();
}

class _HostBeaconState extends State<HostBeacon> {
  CollectionReference collectionRef;
  DocumentReference docRef;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    collectionRef = Firestore.instance.collection('locations').reference();
    _initializeLocation();
  }

  void _initializeLocation() async {
    docRef = await collectionRef.add({
      'Name': widget.userName,
      'Key': widget.passKey,
      'Lati': 'Loading..',
      'Long': 'Loading..',
    });
    setState(() {});
  }

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
        collectionRef.document(docRef.documentID).updateData({
          'Name': widget.userName,
          'Key': widget.passKey,
          'Lati': _location.latitude,
          'Long': _location.longitude,
        });
      });
    });
  }

  _stopListen() async {
    _locationSubscription.cancel();
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
        ? WillPopScope(
            onWillPop: _stopListen(),
            child: Scaffold(
              appBar: AppBar(
                title: Text('Flutter Beacon'),
              ),
              body: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withOpacity(0.4),
                        Colors.white,
                        Colors.blue.withOpacity(0.2)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 5,
                              ),
                            ),
                            height: MediaQuery.of(context).size.width * 0.8,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: new FlutterMap(
                              options: new MapOptions(
                                minZoom: 15.0,
                                center: new LatLng(
                                    _location.latitude, _location.longitude),
                              ),
                              layers: [
                                new TileLayerOptions(
                                    urlTemplate:
                                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                    subdomains: ['a', 'b', 'c']),
                                new MarkerLayerOptions(markers: [
                                  new Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: LatLng(_location.latitude,
                                        _location.longitude),
                                    builder: (ctx) => new Container(
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ])
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Your live location\nLatitude:    ${_location.latitude}\nLongitude:   ${_location.longitude}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Hello! ${widget.userName},\nYour Pass key is\t${widget.passKey}\n\nShare this Pass Key with your friends so that they can follow your beacon and know about your live location.',
                          style: TextStyle(fontSize: 16),
                        ),
                        RaisedButton(
                          child: Text('Tap here to copy Pass Key to clipboard'),
                          onPressed: () {
                            Clipboard.setData(
                                new ClipboardData(text: widget.passKey));
                          },
                        ),
                      ],
                    ),
                  ),
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
                height: 100,
                width: 100,
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text(docRef.toString()),
                  ],
                ),
              ),
            ),
          );
  }
}
