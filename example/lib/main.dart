import 'package:avilatek_ui/avilatek_ui.dart';
import 'package:example/pages/adaptive_dialog/adaptive_dialog_example.dart';
import 'package:example/pages/avila_snackbar/avila_snackar_example_page.dart';
import 'package:example/pages/constants_showcase/constants_showcase_page.dart';
import 'package:example/pages/custom_loading_indicator/custom_loading_indicator_example.dart';
import 'package:example/pages/custom_tag/custom_tags_page.dart';
import 'package:example/pages/developed_by_logo/developed_by_logo_example.dart';
import 'package:example/pages/field_with_title/title_wrapper_example_page.dart';
import 'package:example/pages/file_uploader/file_uploader_page.dart';
import 'package:example/pages/pending_notifications/pending_notifications_example_page.dart';
import 'package:example/pages/permission_handler_example_page.dart';
import 'package:example/pages/remote_data/remote_data_fetch_example_page.dart';
import 'package:example/pages/remote_data_paginated/view/rainbow_page.dart';
import 'package:example/pages/selector_sheet/selector_sheet_example_page.dart';
import 'package:example/pages/send_data/send_data_page.dart';
import 'package:flutter/material.dart';

class ExampleMenuItem {
  const ExampleMenuItem({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;
}

class ExampleMenuCategory {
  const ExampleMenuCategory({
    required this.title,
    required this.children,
  });

  final String title;
  final List<ExampleMenuItem> children;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const avilaCustomTheme = AvilaCustomTheme(
      titleWrapperStyle: TitleWrapperStyle(),
      selectorButtonStyle: SelectorButtonStyle(),
      avilaSnackBarTheme: AvilaSnackBarTheme(),
      customTagStyle: CustomTagStyle(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
      ),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        extensions: avilaCustomTheme.extensions,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final widgetItems = const [
    ExampleMenuItem(
      title: 'Title Wrapper Example',
      child: TitleWrapperExample(),
    ),
    ExampleMenuItem(
      title: 'Adaptive dialog',
      child: AdaptiveDialogExample(),
    ),
    ExampleMenuItem(
      title: 'Developed By Logo',
      child: DevelopedByLogoExample(),
    ),
    ExampleMenuItem(
      title: 'Avila Snackbar Example',
      child: AvilaSnackbarExamplePage(),
    ),
    ExampleMenuItem(
      title: 'Selector Sheet Example',
      child: SelectorSheetExamplePage(),
    ),
    ExampleMenuItem(
      title: 'Custom Loading Indicator Example',
      child: CustomLoadingIndicatorExample(),
    ),
    ExampleMenuItem(
      title: 'Custom Tags Example',
      child: CustomTagsPage(),
    ),
  ];
  final blocItems = const [
    ExampleMenuItem(
      title: 'Remote Data Fetch Bloc Example',
      child: RemoteDataFetchExamplePage(),
    ),
    ExampleMenuItem(
      title: 'Permission Handler Bloc Example',
      child: PermissionHandlerExamplePage(),
    ),
    ExampleMenuItem(
      title: 'Pending Notifications Bloc Example',
      child: PendingNotificationsExamplePage(),
    ),
    ExampleMenuItem(
      title: 'Paged Remote Data Bloc Example',
      child: RainbowPage(),
    ),
    ExampleMenuItem(
      title: 'Upload File Bloc Example',
      child: FileUploaderPage(),
    ),
    ExampleMenuItem(
      title: 'Send Data Bloc',
      child: SendDataPage(),
    ),
  ];
  final otherItems = const [
    ExampleMenuItem(
      title: 'Constants Showcase',
      child: ConstantsShowcasePage(),
    ),
  ];

  late final categories = [
    ExampleMenuCategory(title: 'Blocs', children: blocItems),
    ExampleMenuCategory(title: 'Widgets', children: widgetItems),
    ExampleMenuCategory(title: 'Others', children: otherItems),
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView.separated(
          itemCount: categories.length,
          padding: const EdgeInsets.all(24),
          itemBuilder: (context, index) {
            final category = categories[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: category.children.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(category.children[index].title),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => category.children[index].child,
                        ),
                      );
                    },
                  ),
                  separatorBuilder: (_, __) => const Divider(height: 0),
                ),
              ],
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 24),
        ),
      ),
    );
  }
}
