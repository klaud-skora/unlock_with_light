import 'package:flutter/material.dart';
import 'dart:async';
import 'package:light/light.dart';
import '../logic/unlocker.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static int pin = 1524;
  Unlocker unlocker = Unlocker(pin);
  final StreamController<int> _luxController = StreamController<int>.broadcast();
  final StreamController _contentController = StreamController();

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
    _luxController.sink.add(luxValue);
    _contentController.sink.add(unlocker.state);
  }

   void stopListening() {
    _subscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    try {
      stopListening();
       _luxController.close();
       _contentController.close();
    } catch (exception) {
      print(exception.toString());
    } finally {
      super.dispose();
    }
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
          child: StreamBuilder(
            stream: _contentController.stream,
            initialData: UnlockingStatus,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return  snapshot.data is UnlockingStatus ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50.0),
                  Text('Use lux value to tap the pin code.'),
                  SizedBox(height: 10.0),
                  Text('Touch each of four cards to set it with a running value.'),
                  SizedBox(height: 150.0),
                  Row(    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 50.0,
                        height: 66.0,
                        child: StreamBuilder( 
                          stream: _luxController.stream,
                          initialData: null,
                          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                            return RaisedButton(
                              color: Colors.purple.withOpacity(.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.purple.shade900)
                              ),
                              onPressed: () => { unlocker.setCard(Cards.one, snapshot.data) },
                              child: Text(unlocker.values[3] == Value.blank ? '?' : '*'),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        width: 50.0,
                        height: 66.0,
                        child: StreamBuilder( 
                          stream: _luxController.stream,
                          initialData: null,
                          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                            return RaisedButton(
                              color: Colors.purple.withOpacity(.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.purple.shade900)
                              ),
                              onPressed: () => { unlocker.setCard(Cards.two, snapshot.data) },
                              child: Text(unlocker.values[3] == Value.blank ? '?' : '*'),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        width: 50.0,
                        height: 66.0,
                        child: StreamBuilder( 
                          stream: _luxController.stream,
                          initialData: null,
                          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                            return RaisedButton(
                              color: Colors.purple.withOpacity(.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.purple.shade900)
                              ),
                              onPressed: () => { unlocker.setCard(Cards.three, snapshot.data) },
                              child: Text(unlocker.values[3] == Value.blank ? '?' : '*'),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        width: 50.0,
                        height: 66.0,
                        child: StreamBuilder( 
                          stream: _luxController.stream,
                          initialData: null,
                          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                            return RaisedButton(
                              color: Colors.purple.withOpacity(.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.purple.shade900)
                              ),
                              onPressed: () => { unlocker.setCard(Cards.four, snapshot.data) },
                              child: Text(unlocker.values[3] == Value.blank ? '?' : '*'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.0),
                  Text('Present value:', style: TextStyle( fontSize: 22.0 )),
                  SizedBox(height: 10.0),
                  StreamBuilder(
                    stream: _luxController.stream,
                    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                      return Text( snapshot.data == null ? '(no value was found)' : '${snapshot.data}', 
                        style: TextStyle( fontSize: 22.0 ),
                      );
                    }
                  ),
                  SizedBox(height: 70.0),
                ],
              ) : unlocker.verifier == Verifier.correct ? 
              /* PIN IS CORRECT */
              Text('You successfully unlocked the app!') 
              /* PIN IS INCORRECT */
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('The pin is WRONG', style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(height: 20.0),
                  FlatButton(
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12.0) ),
                    color: Colors.purple,
                    onPressed: () => unlocker.reset(),
                    child: Text('Try again', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ); 
            }
          ),
        ),
      ),
    );
  }
}
