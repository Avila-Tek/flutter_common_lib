import 'package:avilatek_ui/avilatek_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';

class DevelopedByLogoExample extends StatelessWidget {
  const DevelopedByLogoExample({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Color> colorNotifier = ValueNotifier(Colors.blue);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Developed By Logo Example'),
      ),
      body: PageView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Flat style'),
              const Spacer(),
              DevelopedChangeLogoColor(
                colorNotifier: colorNotifier,
                child: ValueListenableBuilder<Color>(
                  valueListenable: colorNotifier,
                  builder: (context, color, child) {
                    return DevelopedByLogo().flat(color: color);
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Primary Green'),
              const Spacer(),
              DevelopedByLogo().primaryGreen(),
              const Spacer(),
            ],
          ),
          ColoredBox(
            color: const Color(0xFF1d1d1d),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Primary White (Modified Size)',
                  style: TextStyle(color: Colors.white),
                ),
                const Spacer(),
                DevelopedByLogo(size: 20).primaryWhite(),
                const Spacer(),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Outlined'),
              const Spacer(),
                  DevelopedChangeLogoColor(
                colorNotifier: colorNotifier,
                child: ValueListenableBuilder<Color>(
                  valueListenable: colorNotifier,
                  builder: (context, color, child) {
                    return DevelopedByLogo().outlined(color: color);
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}

class DevelopedChangeLogoColor extends StatefulWidget {
  final Widget child;
  final ValueNotifier<Color> colorNotifier;

  const DevelopedChangeLogoColor({
    required this.child,
    required this.colorNotifier,
    Key? key,
  }) : super(key: key);

  @override
  State<DevelopedChangeLogoColor> createState() => _DevelopedChangeLogoColorState();
}

class _DevelopedChangeLogoColorState extends State<DevelopedChangeLogoColor> {
  void changeColor(Color color) {
    widget.colorNotifier.value = color;
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      widget.child,
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: const EdgeInsets.all(0.0),
                contentPadding: const EdgeInsets.all(0.0),
                content: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                         Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ColorPicker(
                          color: widget.colorNotifier.value,
                          onChanged: (value) {
                            changeColor(value);
                          },
                          initialPicker: Picker.paletteHue,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Listo'),
                      ),
                      const Spacer()
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Text('Cambiemos el color'),
      ),
    ]);
  }
}