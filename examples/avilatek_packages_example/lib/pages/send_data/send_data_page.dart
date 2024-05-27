// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:avilatek_ui/avilatek_ui.dart';
import 'package:example/pages/file_uploader/file_uploader_bloc.dart';
import 'package:example/pages/send_data/send_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormTextInput extends StatelessWidget {
  const FormTextInput({
    super.key,
    this.enabled = true,
    required this.title,
    required this.controller,
  });

  final String title;
  final bool enabled;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          enabled: enabled,
        ),
      ],
    );
  }
}

class FormModel {
  FormModel({
    required this.name,
    required this.email,
    required this.phone,
  });

  final String name;
  final String email;
  final String phone;

  @override
  String toString() => 'Name: $name\nEmail: $email\nPhone: $phone';
}

class SendDataPage extends StatelessWidget {
  const SendDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExampleSendDataBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Send Data Bloc Example'),
        ),
        body: SendDataView(),
      ),
    );
  }
}

class SendDataView extends StatelessWidget {
  SendDataView({super.key});

  final controllers = (List.generate(3, (index) => TextEditingController()));

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExampleSendDataBloc, SendDataState>(
      listener: (context, state) {
        if (state.isLoading) {
          AvilaSnackBar.info(
            context: context,
            content: const Text('Sending data...'),
          ).show(context);
        }
        if (state.isFailure) {
          state as SendDataFailure;

          AvilaSnackBar.failure(
            context: context,
            content: Text('Failed to send data: ${state.error}'),
          ).show(context);
        }
        if (state.isSuccess) {
          state as SendDataSuccess;
          AvilaSnackBar.success(
            context: context,
            content: Column(
              children: [
                const Text('Data sent successfully!'),
                const SizedBox(height: 4),
                Text(state.data.toString()),
              ],
            ),
          ).show(context);
        }
      },
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            FormTextInput(
              title: 'Name',
              enabled: !state.isLoading,
              controller: controllers[0],
            ),
            const SizedBox(height: 24),
            FormTextInput(
              title: 'Email',
              enabled: !state.isLoading,
              controller: controllers[1],
            ),
            const SizedBox(height: 24),
            FormTextInput(
              title: 'Phone',
              enabled: !state.isLoading,
              controller: controllers[2],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: state.isLoading
                  ? null
                  : () {
                      context.read<ExampleSendDataBloc>().add(
                            DataSent(
                              FormModel(
                                name: controllers[0].text,
                                email: controllers[1].text,
                                phone: controllers[2].text,
                              ),
                            ),
                          );
                    },
              child: const Text('Send Data'),
            ),
          ],
        );
      },
    );
  }
}
