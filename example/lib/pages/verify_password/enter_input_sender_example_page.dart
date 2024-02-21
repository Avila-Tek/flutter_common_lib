// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:avilatek_ui/avilatek_ui.dart';
import 'package:example/pages/verify_password/bloc/send_password_code_bloc.dart';
import 'package:example/pages/verify_password/verify_password_example_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterInputSenderExamplePage extends StatelessWidget {
  const EnterInputSenderExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SendPasswordCodeBloc(
              sendCodeDurationInSeconds: 60,
            ),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Send and Verify Bloc Example'),
          ),
          body: const EnterInputSenderExampleView(),
        ));
  }
}

class EnterInputSenderExampleView extends StatelessWidget {
  const EnterInputSenderExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendPasswordCodeBloc, SendCodeState>(
      listener: (context, state) async {
        if (state.isSuccess) {
          await AvilaSnackBar(
            content:
                const Text('Code is 123456', style: TextStyle(fontSize: 14)),
            backgroundColor: Colors.green,
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 150,
                left: 10,
                right: 10),
          ).show(context);

          unawaited(Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyPasswordExamplePage(
                sendTo: state.input,
              ),
            ),
          ));
        }

        if (state.isError) {
          AvilaSnackBar.failure(
            context: context,
            content: const Text('Error sending code'),
          ).show(context);
        }
      },
      child: const EnterInputSenderExampleBody(),
    );
  }
}

class EnterInputSenderExampleBody extends StatelessWidget {
  const EnterInputSenderExampleBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Enter your email or phone number to receive the code',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email or phone number',
                ),
                onChanged: (value) => context
                    .read<SendPasswordCodeBloc>()
                    .add(SendCodeInputChangedEvent(value)),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context
                  .read<SendPasswordCodeBloc>()
                  .add(const SendCodePressedEvent()),
              child: const Text('Send code'),
            ),
          ],
        ),
      ),
    );
  }
}
