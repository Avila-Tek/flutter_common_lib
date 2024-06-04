import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'pokefinder_event.dart';
part 'pokefinder_state.dart';

class PokefinderBloc extends Bloc<PokefinderEvent, PokefinderState> {
  PokefinderBloc() : super(const PokefinderState()) {
  }
}
