// ignore_for_file: depend_on_referenced_packages

import 'package:example/pages/selector_sheet/models/country.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'select_country_state.dart';

class SelectCountryCubit extends Cubit<SelectCountryState> {
  SelectCountryCubit() : super(const SelectCountryState());

  void selectCountry(Country country) {
    emit(state.copyWith(selectedCountry: country));
  }
}
