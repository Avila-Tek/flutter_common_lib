# Avila Tek Themes Template

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

Generates the base app theme system for Avila Tek Flutter projects, made especifically for our Figma design system.

Inside of it, the brick creates three different folders:

- _Constants:_ contains two files, `color_constants.dart` and `width_constants.dart`. These represent the first level variables (or primitive variables) described in Figma.
  
- _Values:_ contains three files, `color_values.dart`, `width_values.dart`, and `text_values.dart`. These represent the second level variables described in Figma. These should be used during development.
- 
- _Theme:_ contains two files, `app_theme.dart` and `theme_provider.dart`. These contain the theme definition for the application and the provider for the theme with a light/dark toggle included.
