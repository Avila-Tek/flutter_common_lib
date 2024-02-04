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
                const AvilaSnackBar(
                  content: Text('This is a default snackbar'),
                ).show(context);
              },
              child: const Text('Show Default Snackbar'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                AvilaSnackBar.success(
                  context: context,
                  content: const Text('This is a success snackbar'),
                ).show(context);
              },
              child: const Text('Show Success Snackbar'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                AvilaSnackBar.failure(
                  context: context,
                  content: const Text('This is a failure snackbar'),
                ).show(context);
              },
              child: const Text('Show Failure Snackbar'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                AvilaSnackBar.warning(
                  context: context,
                  content: const Text('This is a waning snackbar'),
                ).show(context);
              },
              child: const Text('Show Warning Snackbar'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                AvilaSnackBar.info(
                  context: context,
                  content: const Text('This is a info snackbar'),
                ).show(context);
              },
              child: const Text('Show Info Snackbar'),
            ),
          ],
        ));
  }
}
