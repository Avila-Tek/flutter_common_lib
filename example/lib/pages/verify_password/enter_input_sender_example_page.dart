import 'package:avilatek_bloc/avilatek_bloc.dart';
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
    return const EnterInputSenderExampleBody();
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VerifyPasswordExamplePage(),
                  ),
                );
              },
              child: const Text('Send code'),
            ),
          ],
        ),
      ),
    );
  }
}
