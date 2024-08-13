import 'package:avilatek_bloc/avilatek_bloc.dart';

class ExampleSendDataBloc extends SendDataBloc {
  ExampleSendDataBloc() : super();

  @override
  Future sendData(SendDataState oldState, DataSent event) async {
    // Simulate a network request
    // Here, you would normally call the function that sends the data to the
    // server.
    await Future<void>.delayed(const Duration(seconds: 2));

    /// This function must return the data sent in order to make it available
    /// in the [SendDataLoading], [SendDataSuccess] state.
    return event.data;
  }
}
