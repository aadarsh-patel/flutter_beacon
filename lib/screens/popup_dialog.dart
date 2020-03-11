import 'package:flutter/material.dart';

import 'package:flutter_beacon/screens/track.dart';

class Validate extends StatefulWidget {
  final String name;
  final String passKey;
  final String documentId;
  Validate(this.name, this.passKey, this.documentId);
  @override
  _ValidateState createState() => _ValidateState();
}


class _ValidateState extends State<Validate> {
  String output = '';
  final _passKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      child: Container(

        width: MediaQuery.of(context).size.width*0.75,
        height: MediaQuery.of(context).size.width*0.75,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Enter the Pass Key for ${widget.name}\'s Beacon'),
              TextField(
                controller: _passKeyController,
                decoration: InputDecoration(
                  icon: Icon(Icons.vpn_key),
                  labelText: 'Pass Key',
                  border: OutlineInputBorder(),
                ),
              ),
              RaisedButton(child: Text('ENTER'),onPressed: (){
                if(_passKeyController.text.toString() == widget.passKey){
                  output = 'Pass Key Accepted';
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TrackUser(widget.documentId)));
                }
                else{
                  output = 'Wrong Pass Key';
                }
              },),
              Text(output),
            ],
          ),
        ),
      ),
    ));
  }
}
