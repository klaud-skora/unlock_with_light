import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/unlocker_bloc.dart';
import 'package:tictactoe/light_bloc.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  

  @override
  Widget build(BuildContext context) {
    final bloc = LightBloc();
    // final UnlockerBloc unlockerBloc = BlocProvider.of<UnlockerBloc>(context);
    return Scaffold(
      appBar: AppBar( title: Text(title) ),
      body: BlocBuilder<UnlockerBloc, UnlockerState>(
        builder: (context, state) {
          return Container(
            color: Colors.purple.withOpacity(.2),
            child: Center(
              child: state is EmptyForm || state is UnlockerWithFilledFields ? Column( 
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
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(.1),
                          border: Border.all(
                            color: Colors.purple.shade900,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Center(child: Text( state is EmptyForm ? '?' : '*')), 
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        width: 50.0,
                        height: 66.0,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(.1),
                          border: Border.all(
                            color: Colors.purple.shade900,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Center(child: Text( state is EmptyForm || (state is UnlockerWithFilledFields && state.filledFields == 1) ? '?' : '*')), 
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        width: 50.0,
                        height: 66.0,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(.1),
                          border: Border.all(
                            color: Colors.purple.shade900,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Center(child: Text( state is UnlockerWithFilledFields && (state.filledFields == 3 || state.filledFields == 4 )? '*' : '?')), 
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        width: 50.0,
                        height: 66.0,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(.1),
                          border: Border.all(
                            color: Colors.purple.shade900,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Center(child: Text( state is UnlockerWithFilledFields && state.filledFields == 4 ?  '*' : '?' )),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.0),
                  state is UnlockerWithFilledFields && state.filledFields == 4 ? RaisedButton(
                    color: Colors.purple.withOpacity(.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.purple.shade900)
                    ),
                    onPressed: () => BlocProvider.of<UnlockerBloc>(context).add(UnlockerEvent.VerifyEvent),
                    child: Text( 'Submit' ),
                  ) : RaisedButton(
                    color: Colors.purple.withOpacity(.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.purple.shade900)
                    ),
                    onPressed: () => BlocProvider.of<UnlockerBloc>(context).add(UnlockerEvent.SetPinEvent),
                    child: Text( 'Set value' ),
                  ),
                  SizedBox(height: 50.0),
                  Text('Present value:', style: TextStyle( fontSize: 22.0 )),
                  SizedBox(height: 10.0),
                  StreamBuilder(
                    stream: bloc.light,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      BlocProvider.of<UnlockerBloc>(context).setLight(snapshot.data);
                      return Text(snapshot.data == null ? '(no value was found)' : '${snapshot.data}', 
                        style: TextStyle( fontSize: 22.0 ),
                      );
                    }
                  ),
                  SizedBox(height: 70.0),
                ],
              ) : state is UnlockerSuccess ? 
              /* PIN IS CORRECT */
              Text('You successfully unlocked the app!') 
              /* PIN IS INCORRECT */
              : state is UnlockerFailure ? 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('The pin is WRONG', style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(height: 20.0),
                  FlatButton(
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12.0) ),
                    color: Colors.purple,
                    onPressed: () => BlocProvider.of<UnlockerBloc>(context).add(UnlockerEvent.ResetEvent),
                    child: Text('Try again', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ) : Text('Loading...'),
            ),
          );
        },
      )
    );
  }
}
