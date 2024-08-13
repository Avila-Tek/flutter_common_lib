part of 'select_country_cubit.dart';

class SelectCountryState extends Equatable {
  final Country selectedCountry;

  const SelectCountryState({
    this.selectedCountry = Country.empty,
  });

  @override
  List<Object> get props => [selectedCountry];

  SelectCountryState copyWith({
    Country? selectedCountry,
  }) {
    return SelectCountryState(
      selectedCountry: selectedCountry ?? this.selectedCountry,
    );
  }
}
