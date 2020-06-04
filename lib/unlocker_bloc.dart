import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tictactoe/logic/unlocker.dart';

enum UnlockerEvent { SetPinEvent, VerifyEvent, ResetEvent }

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
      case UnlockerEvent.SetPinEvent:
        if( state is EmptyForm && unlocker.values.every((element) => element == Value.blank) ) {
          unlocker.setCard(Cards.one, lightValue);
          yield UnlockerWithFilledFields(1);
        } else if(state is UnlockerWithFilledFields) {          
          if( state.props.contains(3) ) {
            unlocker.setCard(Cards.four, lightValue);
            yield UnlockerWithFilledFields(4);
          }

          if( state.props.contains(2) ) {
            unlocker.setCard(Cards.three, lightValue);
            yield UnlockerWithFilledFields(3);
          }
          if( state.props.contains(1)) {
            unlocker.setCard(Cards.two, lightValue);
            yield UnlockerWithFilledFields(2);
          }

        }
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