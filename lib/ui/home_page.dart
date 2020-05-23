import 'package:flutter/material.dart';
import 'dart:async';
import 'package:light/light.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _luxString = 'Unknown';
  Light _light = new Light();
  StreamSubscription _subscription;

  void startListening() {
    _light = new Light();
    try {
      _subscription = _light.lightSensorStream.listen(onData);
      print(_light.lightSensorStream);
    }
    on LightException catch (exception) {
      print(exception);
    }
  }

  void onData(int luxValue) async {
    print("Lux value: $luxValue");
    setState(() {
      _luxString = "$luxValue";
    });
  }

   void stopListening() {
    _subscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    startListening();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.purple.withOpacity(.2),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50.0),
              Text('Use lux value to tap the pin code.'),
              SizedBox(height: 10.0),
              Text('Touch each card to set it with a running value.'),
              SizedBox(height: 150.0),
              Row(    
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 50.0,
                    height: 66.0,
                    child: RaisedButton(
                      color: Colors.purple.withOpacity(.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.purple.shade900)
                      ),
                      onPressed: () => {print(_luxString)},
                      child: Text('?'),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    width: 50.0,
                    height: 66.0,
                    child: RaisedButton(
                      color: Colors.purple.withOpacity(.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.purple.shade900)
                      ),
                      onPressed: () => {print(_luxString)},
                      child: Text('?'),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    width: 50.0,
                    height: 66.0,
                    child: RaisedButton(
                      color: Colors.purple.withOpacity(.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.purple.shade900)
                      ),
                      onPressed: () => {print(_luxString)},
                      child: Text('?'),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    width: 50.0,
                    height: 66.0,
                    child: RaisedButton(
                      color: Colors.purple.withOpacity(.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.purple.shade900)
                      ),
                      onPressed: () => {print(_luxString)},
                      child: Text('?'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              Text('Present value:',
                style: TextStyle(
                  fontSize: 22.0
                )
              ),
              Text(_luxString,
                style: TextStyle(
                  fontSize: 22.0
                )
              ),
              SizedBox(height: 70.0),
            ],
          ), 
        ),
      ),
    );
  }
}
