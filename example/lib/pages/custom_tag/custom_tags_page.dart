import 'package:avilatek_ui/avilatek_ui.dart';
import 'package:flutter/material.dart';

class CustomTagsPage extends StatelessWidget {
  const CustomTagsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Tags'),
      ),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomTag.primaryOne(
                context,
                child: const Text('Primary color tag'),
              ),
              const SizedBox(height: 16),
              CustomTag.green(
                context,
                child: const Text('Green tag'),
              ),
              const SizedBox(height: 16),
              CustomTag.yellow(
                context,
                child: const Text('Yellow tag'),
              ),
              const SizedBox(height: 16),
              CustomTag.red(
                context,
                child: const Text('Red tag'),
              ),
              const SizedBox(height: 16),
              CustomTag.grey(
                context,
                child: const Text('Neutral tag'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
