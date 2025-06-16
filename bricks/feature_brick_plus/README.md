# Feature Brick Plus

> **Disclaimer:** This is a custom brick forked from [mason_bricks](https://github.com/LukeMoody01/mason_bricks/tree/master) and modified to our needs. This README is a copy of the original.

A brick to create a feature and tests using our personal favorite practices! This includes using Bloc as a state management solution, and the Equatable package for value equality. Additionally, it makes use of private classes and files to keep the feature organized and make sure devs don't accidentally use classes where they don't belong. Includes optional tests for the features.

This brick allows users to create templates for multiple types of features, including the following:

- Default
- Stepper
- Tabbed

## How to use 🚀

```
mason make feature_brick_plus --feature_name login
```

## Variables ✨

| Variable         | Description                           | Default | Type           | Conditional | When                                |
| ---------------- | ------------------------------------- | ------- | -------------- | ----------- | ----------------------------------- |
| `feature_name`   | The name of the feature               | login   | `string`       | false       | N/A                                 |
| `feature_type`   | The feature type or general structure | default | `enum`         | false       | N/A                                 |
| `create_tests`   | Creates tests for the feature         | false   | `boolean`      | false       | N/A                                 |
| `step_amout`     | The amount of steps for the feature   | 2       | `string`       | true        | Feature is stepper                  |
| `tab_amount`     | The amount of tabs for the feature    | 2       | `string`       | true        | Feature is tabbed                   |
| `children_names` | The names of every child feature      | N/A     | `list<string>` | true        | Feature is either stepper or tabbed |

## Outputs 📦

See [feature_brick_tests](https://github.com/LukeMoody01/mason_bricks/tree/master/bricks/feature_brick_tests) for tests output

### Default

```
--feature_name login --feature_type default
├── login
│   ├── base
|   |   ├── login_body.dart
│   │   └── login_page.dart
│   ├── bloc
│   │   ├── login_bloc.dart
│   │   ├── login_event.dart
│   │   └── login_state.dart
│   ├── widgets
│   │   └── widgets.dart
│   └── login.dart
└── ...
```

### Stepper

```
--feature_name login --feature_type stepper
├── login
│   ├── base
│   │   ├── login_body.dart
│   │   └── login_page.dart
│   ├── bloc
│   │   ├── login_bloc.dart
│   │   ├── login_event.dart
│   │   └── login_state.dart
│   ├── steps
│   │   ├── step_one
│   │   │   ├── base
│   │   │   │   ├── step_one_body.dart
│   │   │   │   └── step_one_page.dart
│   │   │   ├── bloc
│   │   │   │   ├── step_one_bloc.dart
│   │   │   │   ├── step_one_event.dart
│   │   │   │   └── step_one_state.dart
│   │   │   └── widgets
│   │   │       └── widgets.dart
│   │   └── step_two
│   │       ├── base
│   │       │   ├── step_two_body.dart
│   │       │   └── step_two_page.dart
│   │       ├── bloc
│   │       │   ├── step_two_bloc.dart
│   │       │   ├── step_two_event.dart
│   │       │   └── step_two_state.dart
│   │       └── widgets
│   │           └── widgets.dart
│   ├── widgets
│   │   └── widgets.dart
│   └── login.dart
└── ...
```

### Tabbed

```
--feature_name login --feature_type tabbed
├── login
│   ├── base
│   │   ├── login_body.dart
│   │   └── login_page.dart
│   ├── bloc
│   │   ├── login_bloc.dart
│   │   ├── login_event.dart
│   │   └── login_state.dart
│   ├── tabs
│   │   ├── tab_one
│   │   │   ├── base
│   │   │   │   ├── tab_one_body.dart
│   │   │   │   └── tab_one_page.dart
│   │   │   ├── bloc
│   │   │   │   ├── tab_one_bloc.dart
│   │   │   │   ├── tab_one_event.dart
│   │   │   │   └── tab_one_state.dart
│   │   │   └── widgets
│   │   │       └── widgets.dart
│   │   └── tab_two
│   │       ├── base
│   │       │   ├── tab_two_body.dart
│   │       │   └── tab_two_page.dart
│   │       ├── bloc
│   │       │   ├── tab_two_bloc.dart
│   │       │   ├── tab_two_event.dart
│   │       │   └── tab_two_state.dart
│   │       └── widgets
│   │           └── widgets.dart
│   ├── widgets
│   │   └── widgets.dart
│   └── login.dart
└── ...
```
