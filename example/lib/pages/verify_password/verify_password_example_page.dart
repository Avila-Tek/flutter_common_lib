// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:avilatek_ui/avilatek_ui.dart';
import 'package:example/pages/verify_password/bloc/send_password_code_bloc.dart';
import 'package:example/pages/verify_password/bloc/verify_password_code_bloc.dart';
import 'package:example/pages/verify_password/cubit/cubit.dart';
import 'package:example/pages/verify_password/success_verification_example_page.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerifyPasswordExamplePage extends StatelessWidget {
  const VerifyPasswordExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SendPasswordCodeBloc(
              sendCodeDurationInSeconds: 60,
            ),
          ),
          BlocProvider(
            create: (context) => VerifyPasswordCodeBloc(),
          ),
          BlocProvider(
            create: (context) => VerifyCubit(),
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Send and Verify Bloc Example'),
          ),
          body: const VerifyPasswordExampleView(),
        ));
  }
}

class VerifyPasswordExampleView extends StatelessWidget {
  const VerifyPasswordExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SendPasswordCodeBloc, SendCodeState>(
          listener: (context, state) {
            if (state.isSuccess) {
              AvilaSnackBar(
                content: const Text('Code is 123456',
                    style: TextStyle(fontSize: 14)),
                backgroundColor: Colors.green,
                dismissDirection: DismissDirection.up,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height - 150,
                    left: 10,
                    right: 10),
              ).show(context);
            }

            if (state.isError) {
              AvilaSnackBar.failure(
                context: context,
                content: const Text('Error sending code'),
              ).show(context);
            }
          },
        ),
        BlocListener<VerifyPasswordCodeBloc, VerifyCodeState>(
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SuccessVerificationExamplePage(),
                ),
              );
            }
            if (state.isError) {
              AvilaSnackBar.failure(
                context: context,
                content: const Text('Error verifying code'),
              ).show(context);
            }
          },
        ),
      ],
      child: const VerifyPasswordExampleBody(),
    );
  }
}

class VerifyPasswordExampleBody extends StatelessWidget {
  const VerifyPasswordExampleBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 8),
                Text(
                  'Enter verification code',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                CodeInput(),
                SizedBox(height: 16),
                ResendTimer(),
              ],
            ),
          ),
          VerifyCodeButton(),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}

class CodeInput extends StatelessWidget {
  const CodeInput({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.purple),
      borderRadius: BorderRadius.circular(20),
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      // border: Border.all(color: Consts.primary),
      color: Colors.purple.withOpacity(0.1),
      borderRadius: BorderRadius.circular(10),
    );

    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      // border: Border.all(color: Consts.errorColor),
      color: Colors.red.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
    );

    return BlocBuilder<VerifyPasswordCodeBloc, VerifyCodeState>(
      builder: (context, state) {
        return Pinput(
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: !state.isError ? submittedPinTheme : errorPinTheme,
          length: 6,
          autofocus: true,
          onChanged: (value) => context.read<VerifyCubit>().setCode(value),
        );
      },
    );
  }
}

class ResendTimer extends StatelessWidget {
  const ResendTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendPasswordCodeBloc, SendCodeState>(
      builder: (context, state) {
        final enabled = state.isInitialized;
        final minutesStr =
            ((state is SendCodeOnHoldTime ? state.durationInSeconds : 0) / 60)
                .floor()
                .toString()
                .padLeft(2, '0');
        final secondsStr =
            ((state is SendCodeOnHoldTime ? state.durationInSeconds : 60) % 60)
                .toString()
                .padLeft(2, '0');
        return Column(
          children: [
            Text(
              '$minutesStr:$secondsStr',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            TextButton(
              onPressed: enabled
                  ? () => context
                      .read<SendPasswordCodeBloc>()
                      .add(const SendCodePressedEvent())
                  : null,
              child: const Center(
                child: Text(
                  'Send code',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class VerifyCodeButton extends StatelessWidget {
  const VerifyCodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyPasswordCodeBloc, VerifyCodeState>(
      builder: (context, state) {
        final loading = state.isLoading;
        return BlocBuilder<VerifyCubit, VerifyState>(
          buildWhen: (previous, current) => previous.code != current.code,
          builder: (__, state2) {
            final code = state2.code;
            final enabled = code.length == 6;
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: enabled && !loading
                    ? () => context
                        .read<VerifyPasswordCodeBloc>()
                        .add(VerifyCodePressedEvent(code))
                    : null,
                child: Center(
                  child: loading
                      ? const ButtonLoadingIndicator()
                      : const Text(
                          'Verify code',
                        ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ButtonLoadingIndicator extends StatelessWidget {
  const ButtonLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Cargando'),
        SizedBox(width: 8),
        SizedBox.square(
          dimension: 14,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ],
    );
  }
}
