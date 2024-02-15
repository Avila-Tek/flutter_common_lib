import 'dart:developer';

import 'package:avilatek_ui/avilatek_ui.dart';
import 'package:flutter/material.dart';

class AdaptiveDialogExample extends StatelessWidget {
  const AdaptiveDialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adaptive Dialog Example'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AdaptiveAlertDialog(
                    title: const Text('Adaptive Dialog'),
                    content: const Text('This is an adaptive dialog'),
                    actions: [
                      AdaptiveDialogAction(
                        style: const AdaptiveDialogActionStyle(
                          textColor: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        child: const Text('Cancel (style modified)'),
                        onPressed: () {
                          log('Cancelled 😎');
                        },
                      ),
                      AdaptiveDialogAction(
                        child: const Text('OK (no modified)'),
                        onPressed: () {
                          log('OK 🤗');
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('This is an adaptive dialog'),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AdaptiveInputDialog(
                    title: const Text('Adaptive Input Dialog'),
                    placeholder: 'Text on me please...',
                    actions: [
                      AdaptiveDialogAction(
                        child: const Text('Cancel'),
                        onPressed: () {
                          log('Cancelled 😎');
                        },
                      ),
                      AdaptiveDialogAction(
                        child: const Text('OK'),
                        onPressed: () {
                          const Duration(microseconds: 750);
                          log('OK 🤗');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'This is your message ${_controller.text} 🎉🎉🎉',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                    controller: _controller,
                  );
                },
              );
            },
            child: const Text('This is an adaptive input Dialog'),
          )
        ],
      ),
    );
  }
}
