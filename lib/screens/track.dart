import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';

class TrackUser extends StatefulWidget {
  final String docId;
  TrackUser(this.docId);
  @override
  _TrackUserState createState() => _TrackUserState();
}

class _TrackUserState extends State<TrackUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Beacon'),
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('locations')
              .document(widget.docId)
              .snapshots(),
          builder: (context, snapshot) {
            return Container(
              padding: EdgeInsets.all(50),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.width * 0.8,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: new FlutterMap(
                        options: new MapOptions(
                          minZoom: 15.0,
                          center: new LatLng(
                              snapshot.data['Lati'], snapshot.data['Long']),
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
                                  snapshot.data['Lati'], snapshot.data['Long']),
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
                    SizedBox(height: 20),
                    Text(
                      'Name:         ${snapshot.data['Name']}\nLatitude :    ${snapshot.data['Lati']}\nLongitude :\t${snapshot.data['Long']}',
                      style: TextStyle(fontSize: 22),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
