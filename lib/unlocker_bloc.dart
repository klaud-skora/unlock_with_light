import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tictactoe/logic/unlocker.dart';

enum UnlockerEvent { SetPinOneEvent, SetPinTwoEvent, SetPinThreeEvent, SetPinFourEvent, VerifyEvent, ResetEvent }

abstract class UnlockerState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmptyForm extends UnlockerState {}
class UnlockerWithFilledFields extends UnlockerState {
  final int filledFields;
  UnlockerWithFilledFields(this.filledFields);

  @override
  List<Object> get props => [filledFields];
}
class PinIsSet extends UnlockerState {}
class UnlockerSuccess extends UnlockerState {}
class UnlockerFailure extends UnlockerState {}

class UnlockerBloc extends Bloc<UnlockerEvent, UnlockerState> {

  @override
  UnlockerState get initialState => EmptyForm();

  static int pin = 1111;
  
  final unlocker = Unlocker(pin);  
  int _lightValue;
  int get lightValue => _lightValue;

  setLight(int light) {
    _lightValue = light;
  }

  @override
  Stream<UnlockerState> mapEventToState(UnlockerEvent event) async* {
    switch (event) {
      case UnlockerEvent.SetPinOneEvent:
        unlocker.setCard(Cards.one, lightValue);
        yield UnlockerWithFilledFields(1);
        break;
      case UnlockerEvent.SetPinTwoEvent:
        unlocker.setCard(Cards.two, lightValue);
        if(unlocker.values[0] != Value.blank) yield UnlockerWithFilledFields(2);
        break;
      case UnlockerEvent.SetPinThreeEvent:
        unlocker.setCard(Cards.three, lightValue);
        if(unlocker.values[1] != Value.blank) yield UnlockerWithFilledFields(3);
        break;
      case UnlockerEvent.SetPinFourEvent:
        unlocker.setCard(Cards.four, lightValue);
        if(unlocker.values[2] != Value.blank) yield UnlockerWithFilledFields(4);
        break;
      case UnlockerEvent.VerifyEvent:
        
        if(unlocker.state is SetCodeStatus && unlocker.verifier == Verifier.correct) yield UnlockerSuccess();
        else yield UnlockerFailure();
        break;
      case UnlockerEvent.ResetEvent:
        unlocker.reset();
        yield EmptyForm();
        break;
    }
  }
}