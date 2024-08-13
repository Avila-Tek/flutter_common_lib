import 'package:avilatek_bloc/src/send_data/send_data_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

class SendDataBlocImpl extends SendDataBloc<int> {
  @override
  Future<int> sendData(SendDataState oldState, DataSent<int> event) async {
    return event.data;
  }
}

void main() {
  late SendDataBlocImpl bloc;

  setUp(() {
    bloc = SendDataBlocImpl();
  });

  blocTest<SendDataBlocImpl, SendDataState>(
    'should emit SendDataFailure state on error',
    build: () => bloc,
    act: (bloc) => bloc.add(const DataSent(1, simulateError: true)),
    expect: () => [
      SendDataLoading(),
      isA<SendDataFailure<int>>(),
      isA<SendDataReady>(),
    ],
  );
  blocTest<SendDataBlocImpl, SendDataState>(
    'should emit SendDataSuccess state on success',
    build: () => bloc,
    act: (bloc) => bloc.add(const DataSent(1)),
    expect: () => [
      SendDataLoading(),
      const SendDataSuccess(1),
      isA<SendDataReady>(),
    ],
  );
}
