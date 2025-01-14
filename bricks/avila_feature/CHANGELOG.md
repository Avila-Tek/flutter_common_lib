# 0.1.0

- fork from [feature_brick](https://github.com/LukeMoody01/mason_bricks/tree/master/bricks/feature_brick) version 0.6.2.
- feat: added path and routeName static fields to FeaturePage classes to streamline route generation.
- refactor: generated Blocs are now single-class by default; and are created along an status enum with initial, loading, success and failure status.
- refactor: removed boilerplate code in some of generated classes.
- feat: FeaturePages are created with an AppBar by default.
- feat: new include_tests flag to include tests in the generated feature.