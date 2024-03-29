// ignore_for_file: use_build_context_synchronously

import 'package:avilatek_ui/avilatek_ui.dart';
import 'package:example/pages/selector_sheet/bloc/select_country_cubit.dart';
import 'package:example/pages/selector_sheet/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final countriesList = <SelectorSheetItem<Country>>[
  const SelectorSheetItem(
    title: Text('Argentina'),
    value: Country(name: 'Argentina', code: 'AR'),
  ),
  const SelectorSheetItem(
    title: Text('Brazil'),
    value: Country(name: 'Brazil', code: 'BR'),
  ),
  const SelectorSheetItem(
    title: Text('Canada'),
    value: Country(name: 'Canada', code: 'CA'),
  ),
  const SelectorSheetItem(
    title: Text('China'),
    value: Country(name: 'China', code: 'CN'),
  ),
  const SelectorSheetItem(
    title: Text('France'),
    value: Country(name: 'France', code: 'FR'),
  ),
  const SelectorSheetItem(
    title: Text('Germany'),
    value: Country(name: 'Germany', code: 'DE'),
  ),
  const SelectorSheetItem(
    title: Text('India'),
    value: Country(name: 'India', code: 'IN'),
  ),
  const SelectorSheetItem(
    title: Text('Italy'),
    value: Country(name: 'Italy', code: 'IT'),
  ),
  const SelectorSheetItem(
    title: Text('Japan'),
    value: Country(name: 'Japan', code: 'JP'),
  ),
  const SelectorSheetItem(
    title: Text('Mexico'),
    value: Country(name: 'Mexico', code: 'MX'),
  ),
  const SelectorSheetItem(
    title: Text('Russia'),
    value: Country(name: 'Russia', code: 'RU'),
  ),
  const SelectorSheetItem(
    title: Text('South Korea'),
    value: Country(name: 'South Korea', code: 'KR'),
  ),
  const SelectorSheetItem(
    title: Text('Spain'),
    value: Country(name: 'Spain', code: 'ES'),
  ),
  const SelectorSheetItem(
    title: Text('United Kingdom'),
    value: Country(name: 'United Kingdom', code: 'UK'),
  ),
  const SelectorSheetItem(
    title: Text('United States'),
    value: Country(name: 'United States', code: 'US'),
  ),
];

class SelectorSheetExamplePage extends StatelessWidget {
  const SelectorSheetExamplePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectCountryCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Selector Sheet Example'),
        ),
        body: const SelectorSheetExampleBody(),
      ),
    );
  }
}

class SelectorSheetExampleBody extends StatelessWidget {
  const SelectorSheetExampleBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectCountryCubit, SelectCountryState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 16,
          ),
          children: [
            const Text(
              'Click the buttons below to select a country',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            const Text('Default selector sheet:'),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () async {
                  final selectedCountryIndex = await SelectorSheet.show(
                      context,
                      SelectorSheet<Country>(
                          appBar: AppBar(
                            title: const Text('Select a country'),
                          ),
                          child: ListView.builder(
                            itemCount: countriesList.length,
                            itemBuilder: (context, i) {
                              return ListTile(
                                title: countriesList[i].title,
                                onTap: () {
                                  Navigator.of(context).pop(i);
                                },
                              );
                            },
                          )));

                  if (selectedCountryIndex != null) {
                    context.read<SelectCountryCubit>().selectCountry(
                        countriesList[selectedCountryIndex].value);
                  }
                },
                child: const Text('Select a country')),
            const SizedBox(height: 24),
            const Text('Selector sheet with builder:'),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () async {
                  final selectedCountryIndex = await SelectorSheet.show(
                      context,
                      SelectorSheet<Country>.builder(
                        itemCount: countriesList.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            title: countriesList[i].title,
                          );
                        },
                        style: SelectorSheetTheme(
                          selectorSheetThemeData: const SelectorSheetThemeData(
                            padding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 16,
                            ),
                          ),
                          selectorSheetItemThemeData:
                              SelectorSheetItemThemeData(
                            backgroundColor: Colors.purple.shade100,
                          ),
                        ),
                        separator: const SizedBox(height: 16),
                        appBar: AppBar(
                          title: const Text('Select a country'),
                          backgroundColor: Colors.green.shade100,
                          centerTitle: true,
                        ),
                      ));

                  if (selectedCountryIndex != null) {
                    context.read<SelectCountryCubit>().selectCountry(
                        countriesList[selectedCountryIndex].value);
                  }
                },
                child: const Text('Select a country')),
            const SizedBox(height: 30),
            if (state.selectedCountry == Country.empty) ...[
              const Center(child: Text('No country selected'))
            ] else ...[
              Center(
                child: Text(
                    'Selected country: ${state.selectedCountry.name} - ${state.selectedCountry.code}'),
              )
            ]
          ],
        );
      },
    );
  }
}
