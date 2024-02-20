// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:example/constants.dart';
import 'package:flutter/material.dart';

class ConstantsShowcasePage extends StatelessWidget {
  const ConstantsShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Constants Showcase'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: Consts.margin),
            const Text('App name: ${Consts.appName}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('Padding: ${Consts.padding}',
                style: TextStyle(fontSize: 16)),
            const Text('Margin: ${Consts.margin}',
                style: TextStyle(fontSize: 16)),
            const Text('Default radius: ${Consts.defaultRadius}',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: Consts.padding),
            const Text('Primary color:', style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: Consts.padding,
            ),
            ColorPalette(color: Consts.primaryOne),
            const SizedBox(
              height: Consts.padding,
            ),
            const Text('Secondary color:', style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: Consts.padding,
            ),
            ColorPalette(color: Consts.secondaryOne),
            const SizedBox(
              height: Consts.padding,
            ),
            const Text('Error color:', style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: Consts.padding,
            ),
            ColorPalette(color: Consts.error),
            const SizedBox(
              height: Consts.padding,
            ),
            const Text('Warning color:', style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: Consts.padding,
            ),
            ColorPalette(color: Consts.warning),
            const SizedBox(
              height: Consts.padding,
            ),
            const Text('Success color:', style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: Consts.padding,
            ),
            ColorPalette(color: Consts.success),
          ],
        ),
      ),
    );
  }
}

class ColorPalette extends StatelessWidget {
  const ColorPalette({
    Key? key,
    required this.color,
  }) : super(key: key);

  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Consts.defaultRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50,
            width: 20,
            color: color.shade50,
          ),
          Container(
            height: 50,
            width: 20,
            color: color.shade100,
          ),
          Container(
            width: 20,
            height: 50,
            color: color.shade200,
          ),
          Container(
            width: 20,
            height: 50,
            color: color.shade300,
          ),
          Container(
            width: 20,
            height: 50,
            color: color.shade400,
          ),
          Container(
            width: 20,
            height: 50,
            color: color.shade500,
          ),
          Container(
            width: 20,
            height: 50,
            color: color.shade600,
          ),
          Container(
            width: 20,
            height: 50,
            color: color.shade700,
          ),
          Container(
            width: 20,
            height: 50,
            color: color.shade800,
          ),
          Container(
            width: 20,
            height: 50,
            color: color.shade900,
          ),
        ],
      ),
    );
  }
}
