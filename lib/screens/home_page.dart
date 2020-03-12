import 'package:flutter/material.dart';
import 'package:flutter_beacon/common.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.wifi),
        title: Text('Flutter Beacon'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: myGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.4,
                child: Card(
                  color: myBoxColor,
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 5,color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: RaisedButton(
                      color: myBoxColor,
                      child: Text(
                        'Host a\nbeacon',
                        style: TextStyle(fontSize: 30, color: myTextColor),
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/form'),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.4,
                child: Card(
                  color: myBoxColor,
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 5,color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: RaisedButton(
                      color: myBoxColor,
                      child: Text(
                        'Follow \nbeacon',
                        style: TextStyle(fontSize: 30, color: myTextColor),
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/follow'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
