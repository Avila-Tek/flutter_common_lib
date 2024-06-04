import 'package:avilatek_ui/avilatek_ui.dart';
import 'package:flutter/material.dart';

class TitleWrapperExample extends StatelessWidget {
  const TitleWrapperExample({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Field With Title Example'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        children: [
          TitleWrapper(
            title: const Text('FieldWithTitle using a titleText and a footer'),
            footer: const Text('This is a footer'),
            child: SizedBox(
              height: 150,
              child: PageView.builder(
                controller:
                    PageController(viewportFraction: 0.8, initialPage: 1),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            Colors.primaries[index % Colors.primaries.length],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const Divider(
            height: 70,
          ),
          TitleWrapper(
            title: const Row(
              children: [
                Icon(Icons.list),
                SizedBox(width: 10),
                Text('FieldWithTitle using a title widget'),
              ],
            ),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
