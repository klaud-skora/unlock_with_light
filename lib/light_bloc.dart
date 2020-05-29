import 'dart:async';
import 'package:light/light.dart';

class LightBloc {
  
  Light _light;
  StreamController _controller = StreamController.broadcast();
  StreamSink get _newLight => _controller.sink;
  Stream get light => _controller.stream;

  StreamSubscription _subscription;

  LightBloc() {
    _light = new Light();
   _subscription = _light.lightSensorStream.listen(getLight);
  }

   void dispose() {
    _subscription.cancel();
    _controller.close();
  }

  void getLight(int luxValue) {
    print(luxValue);  
    _newLight.add(luxValue);
  }

}