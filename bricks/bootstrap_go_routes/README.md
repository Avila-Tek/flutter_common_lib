# Go Route Bootstraper

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

Boostrap routing in your Flutter app with Go Router. This brick sets your project with a ready-to-go routing system using Go Router.

## Breaking down the layout of the brick

Supposing your app has a layout with three sections: Home, Products and Profile, the brick generates the following structure:

```
routes/
    - branches/
        - home_branch.dart
        - products_branch.dart
        - profile_branch.dart
    - indexes/
        - home_index.dart
        - products_index.dart
        - profile_index.dart
    - index.dart
    - router.dart
    - shell_branches.dart
```

Let's break down every file:

### `router.dart`

Here's the `GoRouter` object with all the routes and branches. By default, it defines a `StatefulShellRoute.indexedStack` in the root to handle the common layout of bottom navitations using Go Router's stateful [ShellRoutes](https://pub.dev/documentation/go_router/latest/go_router/ShellRoute-class.html). You might want to add routes at the same level of the main ShellRoute, like login or sign up, here.

### `index.dart`

Here's the `IndexNavigationPage` widget which you might love (or not, it's pretty opinionated). It defines for you the scaffolding with the `BottomNavigationBar` with every item, and already implements the logic to do the navigation between the sections. If you peek into it, you might wonder what is the `AppShellBranch` class. We'll cover it next

### `shell_branches.dart` 

Defines the `AppShellBranch` class we just mentioned. It is an extended enum that defines the sections of your app. To reorder the tabs you just have to change the order in the enum. To update the icons or title, update the implementation of `title()`, `icon()` and `activeIcon()`. It's simple as that.

### `branches` directory

Here you'll find the branches for each section of your app. Each branch should implement the `AppBaseShellBranch` class. As every branch is a `ShellRoute`, each might have its own list of routes. You can define the routes in the `routes` getter of each branch.

The `List<RouteBase> rootRoutes(GlobalKey<NavigatorState> rootNavigatorKey)` function is a helper to define routes that will be *pushed over* the Bottom Navigation Bar, which is not the default behaviour. The function receives the `rootNavigatorKey` to push the routes over the main navigator, so you should declare the roots here using that key. For instance:

```
List<RouteBase> rootRoutes(GlobalKey<NavigatorState> rootNavigatorKey) {
    return [
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/shopcart',
        name: 'shopcart',
        builder: (_, __) => ShopcardPage();
      ),
    ];
  }
```

And so, you would navigate to the shopcart page using `GoRouter.of(context).go('/shopcart')`, and it would be pushed over the main navigator.

These routes can also be declared in the `router.dart` file, and it will probably be your preference. The above example is more appropiate when you want to keep the routes close to the branch, or if the router file is getting too big.

### `indexes` directory

Here you'll find the index pages for each section of your app. I would recommend avoiding putting too much logic in these pages, as they should be used only to return the widget of the feature you want the `ShellBranch` to show first.

