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
  HostBeacon(this.userName,this.passKey);

  @override
  _HostBeaconState createState() => _HostBeaconState();
}

class _HostBeaconState extends State<HostBeacon> {
  bool initialized = false;
  DocumentReference docRef;

  final Location location = new Location();


  _intializeLocation() async {
    docRef = await Firestore.instance.collection('locations').add({
      'Name': widget.userName,
      'Key': widget.passKey,
    });
    initialized = true;
  }

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

  _stopListen() async {
    _locationSubscription.cancel();
  }

  _updateLocation() async {
    if (initialized == false) {
      _intializeLocation();
    } else {
      docRef.updateData({
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
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(50),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
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
                                point: LatLng(
                                    _location.latitude, _location.longitude),
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
                        'Your Pass key is\t${widget.passKey}\n\nShare this Pass Key with your friends so that they can follow your beacon and know about your live location.',
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
