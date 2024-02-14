import 'package:avilatek_ui/avilatek_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';

class DevelopedByLogoExample extends StatelessWidget {
  const DevelopedByLogoExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developed By Logo Example'),
      ),
      body: PageView(
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Flat style'),
              Spacer(),
              DevelopedChangeLogoColor(),
              Spacer(),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Primary White (Modified Size)'),
              const Spacer(),
              DevelopedByLogo(size: 20).primaryWhite(),
              const Spacer(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Outlined'),
              const Spacer(),
              DevelopedByLogo().outlined(),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}

class DevelopedChangeLogoColor extends StatefulWidget {
  const DevelopedChangeLogoColor({super.key});

  @override
  State<DevelopedChangeLogoColor> createState() => _DevelopedChangeLogoColorState();
}

class _DevelopedChangeLogoColorState extends State<DevelopedChangeLogoColor> {
  Color currentColor = Colors.blue;

  void changeColor(Color color) {
    setState(() => currentColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      DevelopedByLogo().flat(color: currentColor),
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
                          color: currentColor,
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
