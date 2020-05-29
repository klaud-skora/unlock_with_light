import 'package:flutter/material.dart';
import 'package:tictactoe/light_bloc.dart';
import 'package:tictactoe/unlocker_bloc.dart';
import '../logic/unlocker.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final bloc = LightBloc();
  final unlockerBloc = UnlockerBloc();

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
          // child: StreamBuilder(
          //   stream: unlockerBloc.outUnlocker,
          //   initialData: UnlockingStatus,
          //   builder: (BuildContext context, AsyncSnapshot snapshot) {
          //     // return  snapshot.data is UnlockingStatus ? Column(
          //     return Column(
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
                          stream: bloc.light,
                          builder: (BuildContext context, AsyncSnapshot lightshot) {
                            return RaisedButton(
                              color: Colors.purple.withOpacity(.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.purple.shade900)
                              ),
                              onPressed: () => { unlockerBloc.action.add({ 'card': Cards.one, 'lux': lightshot.data})},
                              child: StreamBuilder(
                                stream: unlockerBloc.outUnlocker,
                                builder: (BuildContext context, AsyncSnapshot snapshot) { 
                                  return Text( snapshot.data == null || snapshot.data[0] == Value.blank ? '?' :'*');
                              }
                              ),
                            );
                          }
                        ),
                      ),
                      // SizedBox(width: 10.0),
                      // Container(
                      //   width: 50.0,
                      //   height: 66.0,
                      //   child: StreamBuilder( 
                      //     stream: bloc.light,
                      //     initialData: null,
                      //     builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                      //       return RaisedButton(
                      //         color: Colors.purple.withOpacity(.1),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(18.0),
                      //           side: BorderSide(color: Colors.purple.shade900)
                      //         ),
                      //         onPressed: () => { unlocker.setCard(Cards.two, snapshot.data), _contentController.sink.add(unlocker) },
                      //         child: Text(unlocker.values[1] == Value.blank ? '?' : '*')
                      //       );
                      //     },
                      //   ),
                      // ),
                      // SizedBox(width: 10.0),
                      // Container(
                      //   width: 50.0,
                      //   height: 66.0,
                      //   child: StreamBuilder( 
                      //     stream: bloc.light,
                      //     initialData: null,
                      //     builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                      //       return RaisedButton(
                      //         color: Colors.purple.withOpacity(.1),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(18.0),
                      //           side: BorderSide(color: Colors.purple.shade900)
                      //         ),
                      //         onPressed: () => { unlocker.setCard(Cards.three, snapshot.data), _contentController.sink.add(unlocker) },
                      //         child: Text(unlocker.values[2] == Value.blank ? '?' : '*')
                      //       );
                      //     },
                      //   ),
                      // ),
                      // SizedBox(width: 10.0),
                      // Container(
                      //   width: 50.0,
                      //   height: 66.0,
                      //   child: StreamBuilder( 
                      //     stream: bloc.light,
                      //     initialData: null,
                      //     builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                      //       return RaisedButton(
                      //         color: Colors.purple.withOpacity(.1),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(18.0),
                      //           side: BorderSide(color: Colors.purple.shade900)
                      //         ),
                      //         onPressed: () => { unlocker.setCard(Cards.four, snapshot.data), _contentController.sink.add(unlocker) },
                      //         child: Text(unlocker.values[3] == Value.blank ? '?' : '*'),
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 50.0),
                  Text('Present value:', style: TextStyle( fontSize: 22.0 )),
                  SizedBox(height: 10.0),
                  StreamBuilder(
                    stream: bloc.light,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Text( snapshot.data == null ? '(no value was found)' : '${snapshot.data}', 
                        style: TextStyle( fontSize: 22.0 ),
                      );
                    }
                  ),
                  SizedBox(height: 70.0),
                ],
              // );
              // ) : unlocker.verifier == Verifier.correct ? 
              /* PIN IS CORRECT */
              // Text('You successfully unlocked the app!') 
              /* PIN IS INCORRECT */
              // : 
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Text('The pin is WRONG', style: TextStyle(fontWeight: FontWeight.w500)),
              //     SizedBox(height: 20.0),
              //     FlatButton(
              //       shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12.0) ),
              //       color: Colors.purple,
              //       onPressed: () { unlocker.reset(); _contentController.sink.add(unlocker); },
              //       child: Text('Try again', style: TextStyle(color: Colors.white)),
              //     ),
              //   ],
              // ); 
      //       }
          ),
        ),
      ),
    );
  }
}
