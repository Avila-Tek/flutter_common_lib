import 'package:avilatek_ui/avilatek_ui.dart';
import 'package:flutter/material.dart';

class AvilaSnackbarExamplePage extends StatelessWidget {
  const AvilaSnackbarExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Avila Snackbar Example'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 16,
          ),
          children: [
            ElevatedButton(
              onPressed: () {
                const snackBar = AvilaSnackBarContent(
                  title: 'Epa',
                  message: 'mano',
                  contentType: AvilaSnackBarContentType.success,
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: snackBar));
              },
              child: const Text('Show Snackbar'),
            ),
          ],
        ));
  }
}
