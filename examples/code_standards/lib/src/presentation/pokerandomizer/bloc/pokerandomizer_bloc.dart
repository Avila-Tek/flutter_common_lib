import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'pokerandomizer_event.dart';
part 'pokerandomizer_state.dart';

class PokerandomizerBloc extends Bloc<PokerandomizerEvent, PokerandomizerState> {
  PokerandomizerBloc() : super(const PokerandomizerState()) {
  }
}
