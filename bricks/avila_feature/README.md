# Avila Feature

> **Disclaimer:** This is a custom brick forked from [feature_brick](https://github.com/LukeMoody01/mason_bricks/tree/master/bricks/feature_brick) and modified to our needs. Credits to the original creator, [LukeMoody01](https://github.com/LukeMoody01).

A brick to create a feature and tests using best practices and your state management of choice! Supports Bloc, Cubit, Provider, Riverpod, None. This version of the brick adds small adjustments and improvements to the original brick to better Avila Tek project structures.

Note: Since version 0.6.0, the brick now uses Super Initializers for features widgets. If you are not using dart 2.17, use the below versions.

## How to use 🚀

```
mason make avila_feature --feature_name login --state_management bloc
```

## Variables ✨

| Variable           | Description                              | Default | Type      | Conditional | When             |
| ------------------ | ---------------------------------------- | ------- | --------- | ----------- | ---------------- |
| `feature_name`     | The name of the feature                  | login   | `string`  | false       | N/A              |
| `state_management` | The state management of the app          | bloc    | `enum`    | false       | N/A              |
| `use_equatable`    | Use the equatable package                | true    | `boolean` | true        | Using bloc/cubit |
| `include_tests`    | Whether to create test files for feature | false   | `boolean` | true        | N/A              |

## Outputs 📦

See [feature_brick_tests](https://github.com/LukeMoody01/mason_bricks/tree/master/bricks/feature_brick_tests) for tests output

```
--feature_name login --state_management bloc
├── login
│   ├── bloc
│   │   ├── bloc.dart
│   │   ├── login_bloc.dart
│   │   ├── login_event.dart
│   │   └── login_state.dart
│   ├── view
│   │   └── login_page.dart
│   ├── widgets
│   │   ├── login_body.dart
│   │   └── widgets.dart
│   └── login.dart
└── ...
```

```
--feature_name login --state_management cubit
├── login
│   ├── cubit
│   │   ├── cubit.dart
│   │   ├── login_cubit.dart
│   │   └── login_state.dart
│   ├── view
│   │   └── login_page.dart
│   ├── widgets
│   │   ├── login_body.dart
│   │   └── widgets.dart
│   └── login.dart
└── ...
```

```
--feature_name login --state_management provider
├── login
│   ├── provider
│   │   ├── login_provider.dart
│   │   ├── provider.dart
│   ├── view
│   │   └── login_page.dart
│   ├── widgets
│   │   ├── login_body.dart
│   │   └── widgets.dart
│   └── login.dart
└── ...
```

```
--feature_name login --state_management riverpod
├── login
│   ├── provider
│   │   ├── login_provider.dart
│   │   ├── provider.dart
│   ├── view
│   │   └── login_page.dart
│   ├── widgets
│   │   ├── login_body.dart
│   │   └── widgets.dart
│   └── login.dart
└── ...
```

```
--feature_name login --state_management none
├── login
│   ├── view
│   │   └── login_page.dart
│   ├── widgets
│   │   ├── login_body.dart
│   │   └── widgets.dart
│   └── login.dart
└── ...
```
