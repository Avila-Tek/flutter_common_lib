# Avila Tek README Brick.

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

Generates a README file for Avila Tek projects. The generated file follows the standard format for this file and generates documentation for various libraries and packages normally used in our projects.

> Disclaimer: The generated README file is based on [VGV](https://github.com/VeryGoodOpenSource/very_good_cli) README files. Credits to them!

## How to use 🚀

### Command Line 

```
mason make avilatek_readme
```

## Available variables

| Variable         | Description                                                        | Default                                   | Type     |
| ---------------- | ------------------------------------------------------------------ | ----------------------------------------- | -------- |
| `project_name`   | Name of the project. Will be used as the header of the README file | Avila Tek Flutter Project                 | `string` |
| `description`    | Description of the project.                                        | This project was created using the Avi... | `string` |
| `uses_fvm`       | Whether the project uses FVM or not.                               | false                                     | `bool`   |
| `uses_melos`     | Whether the project uses Melos or not.                             | false                                     | `bool`   |
| `uses_go_router` | Whether the project uses Go Router or not.                         | false                                     | `bool`   |

<!-- | `ci`             | The implemented CI service                                         | none (none, github, codemagic)            | `enum`   | -->

Depending on the values given to the brick, the README file generated will include extra information about setting up the project with the specified libraries.

<!-- TODO: Add CI documentation -->

_made with 💚 by ⛰️ Avila Tek_