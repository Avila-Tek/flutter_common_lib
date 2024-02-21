import 'package:flutter/material.dart';
import 'package:avilatek_ui/avilatek_ui.dart';

class CustomLoadingIndicatorExample extends StatelessWidget {
  const CustomLoadingIndicatorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Loading Indicator Example'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Custom Loading Indicator with child'),
              subtitle: Text('This is a custom loading indicator with a child'),
              trailing: CustomLoadingIndicator(
                child: Text('Loading...'),
              ),
            ),
            ListTile(
              title: Text('Custom Loading Indicator without child'),
              subtitle: Text('This is a custom loading indicator without a child'),
              trailing: CustomLoadingIndicator(),
            ),
            ListTile(
              title: Text('Custom Loading Indicator without child and modified values'),
              subtitle: Text('This is a custom loading indicator without a child and modified values'),
              trailing: CustomLoadingIndicator(
                style: CustomLoadinIndicatorStyle(
                  color: Colors.greenAccent,
                  strokeWidth: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
