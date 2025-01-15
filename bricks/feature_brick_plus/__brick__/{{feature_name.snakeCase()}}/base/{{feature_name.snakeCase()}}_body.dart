part of 'package:{{{fullPath}}}/base/{{feature_name.snakeCase()}}_page.dart';
// NOTE: Declare all the UI widgets here, including BlocBuilders.
/// {@template {{feature_name.snakeCase()}}_body}
/// Body of the {{feature_name.pascalCase()}}Page.
/// {@endtemplate}
{{#isDefault}}class _{{feature_name.pascalCase()}}Body extends StatelessWidget {
  /// {@macro {{feature_name.snakeCase()}}_body}
  const _{{feature_name.pascalCase()}}Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_{{feature_name.pascalCase()}}Bloc, _{{feature_name.pascalCase()}}State>(
      builder: (context, state) {
        return const Center(child: Text('{{feature_name.pascalCase()}}Page'));
      },
    );
  }
  
}{{/isDefault}}{{#isTabbed}}
class _{{feature_name.pascalCase()}}Body extends StatelessWidget {
  /// {@macro {{feature_name.pascalCase()}}_body}
  const _{{feature_name.pascalCase()}}Body({
    required TabController tabController,
    Key? key,
  })  : _tabController = tabController,
        super(key: key)

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_{{feature_name.pascalCase()}}Bloc, _{{feature_name.pascalCase()}}State>(
      builder: (context, state) {
        return TabBarView(
          controller: _tabController,
          children: const [
            {{#childrenNames}}_{{..pascalCase()}}Page(),
            {{/childrenNames}}
          ],
        );
      },
    );
  }
}{{/isTabbed}}{{#isStepper}}
class _{{feature_name.pascalCase()}}Body extends StatelessWidget {
  /// {@macro {{feature_name.snakeCase()}}_body}
  _{{feature_name.pascalCase()}}Body({Key? key}) : super(key: key);

  final controller = PageController();

  final scrollController = ScrollController(keepScrollOffset: false);

  int get totalSteps => _{{feature_name.pascalCase()}}Step.values.length - 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_{{feature_name.pascalCase()}}Bloc, _{{feature_name.pascalCase()}}State>(
        builder: (context, state) {
          return NestedScrollView(
            controller: scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                // TODO: add appbar here
              ];
            },
            body: PageView(
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                {{#childrenNames}}_{{#pascalCase}}{{.}}{{/pascalCase}}Page(),
                {{/childrenNames}}
              ],
            ),
          );
        },
      );
  }
}
{{/isStepper}}
