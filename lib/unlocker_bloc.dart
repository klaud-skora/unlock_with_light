import 'dart:async';
import 'package:tictactoe/logic/unlocker.dart';

class UnlockerBloc {
  
  static int pin = 1524;
  static Unlocker unlocker = Unlocker(pin);

  StreamController _controller = StreamController.broadcast();
  StreamSink get _inUnlocker => _controller.sink;
  Stream get outUnlocker => _controller.stream;


  StreamController _actionController = StreamController();
  StreamSink get action => _actionController.sink;

  UnlockerBloc() {
   _actionController.stream.listen(onData);
  }

   void dispose() {
    _actionController.close();
    _controller.close();
  }

  void onData(data) {
    
    if(data['lux'] != null ) {
      print(data['card']);
      unlocker.setCard(data['card'], data['lux']);
    }
    _inUnlocker.add({ 'state': unlocker.state, 'values': unlocker.values });
  }

}