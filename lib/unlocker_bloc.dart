import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tictactoe/light_bloc.dart';
import 'package:tictactoe/logic/unlocker.dart';

enum UnlockerEvent { SetPinOneEvent, SetPinTwoEvent, SetPinThreeEvent, SetPinFourEvent, ResetEvent }

abstract class UnlockerState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmptyForm extends UnlockerState {}
class UnlockerWithFilledFieldOne extends UnlockerState {}
class UnlockerWithFilledFieldsTwo extends UnlockerState {}
class UnlockerWithFilledFieldsThree extends UnlockerState {}
class UnlockerWithFilledFieldsFour extends UnlockerState {}
class UnlockerSuccess extends UnlockerState {}
class UnlockerFailure extends UnlockerState {}

class UnlockerBloc extends Bloc<UnlockerEvent, UnlockerState> {

  @override
  UnlockerState get initialState => EmptyForm();

  static int pin = 1524;
  
  final unlocker = Unlocker(pin);
  static final LightBloc bloc = LightBloc(); 
  var light = bloc.light.runtimeType;

  int lightValue;

  @override
  Stream<UnlockerState> mapEventToState(UnlockerEvent event) async* {
    print(light);
    switch (event) {
      case UnlockerEvent.SetPinOneEvent:
        unlocker.setCard(Cards.one, lightValue);
        yield UnlockerWithFilledFieldOne();
        break;
      case UnlockerEvent.SetPinTwoEvent:
        unlocker.setCard(Cards.two, lightValue);
        yield UnlockerWithFilledFieldsTwo();
        break;
      case UnlockerEvent.SetPinThreeEvent:
        unlocker.setCard(Cards.three, lightValue);
        yield UnlockerWithFilledFieldsThree();
        break;
      case UnlockerEvent.SetPinFourEvent:
        unlocker.setCard(Cards.four, lightValue);
        if(unlocker.verifier == Verifier.correct) yield UnlockerSuccess();
        else yield UnlockerFailure();
        break;
      case UnlockerEvent.ResetEvent:
        unlocker.reset();
        yield EmptyForm();
        break;
    }
  }
}