import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Beacon'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Card(
                color: Colors.lightBlueAccent,
                elevation: 10,
                child: RaisedButton(
                  color: Colors.lightBlueAccent,
                  child: Text(
                    'Host a\nbeacon',
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/host'),
                ),
              ),
              Card(
                color: Colors.lightBlueAccent,
                elevation: 10,
                child: RaisedButton(
                  color: Colors.lightBlueAccent,
                  child: Text(
                    'Follow a\nbeacon',
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/follow'),
                ),
              ),
            ],
          ),
          RaisedButton(
            color: Colors.lightBlueAccent,
            child: Text('Lookup for Pass Key in repository', style: TextStyle(fontSize: 18),),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
        ],
      ),
    );
  }
}
