import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MaterialApp(

    title: "MQTT",
    debugShowCheckedModeBanner: false,
    home: Home()

));

_handleButtons(String text) async{

  _sendToDB(text);

}

void _sendToDB(String text){

  Firestore.instance.collection("FanCommands").add(
      {
        "sender": "Paulo",
        "timestamp": DateTime.now(),
        "command": text
      }
  );

}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _lastTemperature = "10";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("MQTT - Controller"), centerTitle: true),

      body: Column(

        children: <Widget> [
          Expanded(
            child: Row(

                children: <Widget> [
                  Expanded(child: Image.asset("images/termometro.png", fit: BoxFit.cover,)),

                  Expanded(child: Text(_lastTemperature + " °C", style: TextStyle(fontSize: 50.0), textAlign: TextAlign.center)),
                ]
            ),
          ),
          Divider(height: 2.0),
          Expanded(
              child: Image.asset("images/ventilador.jpg", fit: BoxFit.cover)
          ),

          Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: IconButton(icon: Icon(Icons.flash_on),iconSize: 50.0, onPressed: (){
                        _handleButtons("liga");
                      })
                  ),
                  Expanded(
                      child: IconButton(icon: Icon(Icons.flash_off), iconSize: 50.0, onPressed: (){
                        _handleButtons("desliga");
                      })
                  )
                ],
              )
          )

        ],

      ),

    );
  }
}


