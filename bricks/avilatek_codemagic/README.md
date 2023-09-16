# avilatek_codemagic

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

Generates a `codemagic.yaml` file ready to be used as the initial configuration of Avila Tek projects.

This brick allows you to set up CI for different flavors, and manages all the needed configuration for you, automatically.

### Important note

This brick is made specifically for Avila Tek Flutter projects, and the output is tailored for the standard followed by the team. 

## Project requisites
1. The project must have _at least_ three flavors, named strictly as follows: `development`, `staging`, and `production`.
2. The bundle ID must end with `.stg` for staging and `.dev` for develpment flavors. Production bundle ID must not be appended.
3. The project must use a main file for each flavor.
4. All main files must be in the same directory (generally under `lib/`).

> We refer to the main files as the files where Dart's `main()` method  for each flavor is declared. Each flavor should have its own main file.

## Pre-requisites

### Codemagic project setup

1. Create the project in Codemagic's platform.
2. Depending on the selected flavors, the project must include the corresponding group, which must be named as follows: `production`, `staging`, and `development`.

### For App Store distribution
1. In Codemagic, upload or fetch from Developer Portal the provisioning profile of the app. [Read more][2].
2. Create the app in App Store Connect.
3. (Optional) Create beta groups in TestFlight.

### For Play Store distribution.

1. For standard code signing, simply modify the `android/app/build.gradle` as follows:

    ```gradle
    android {
        ...
        defaultConfig { ... }
        signingConfigs {
            release {
                if (System.getenv()["CI"]) { // CI=true is exported by Codemagic
                    storeFile file(System.getenv()["CM_KEYSTORE_PATH"])
                    storePassword System.getenv()["CM_KEYSTORE_PASSWORD"]
                    keyAlias System.getenv()["CM_KEY_ALIAS"]
                    keyPassword System.getenv()["CM_KEY_PASSWORD"]
                } else {
                    keyAlias keystoreProperties['keyAlias']
                    keyPassword keystoreProperties['keyPassword']
                    storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
                    storePassword keystoreProperties['storePassword']
                }
            }
        }
        buildTypes {
            release {
                ...
                signingConfig signingConfigs.release
            }
        }
    }
    ```

    > **Note:** *If you need to use a different keystore, read more about [Android code signing][1]*.

2.  The Google Cloud secret key for distribution must be declared in a variable named GCLOUD_SERVICE_ACCOUNT_CREDENTIALS in a group named `play_store_credentials`. Preferably on Codemagic team's variables. 

For more information about distribution keys, contact the Senior developer in charge of the CI/CD workflow.

## How to use 🚀

### Command Line 

```
mason make avilatek_codemagic
```

## Available variables

| Variable             | Description                                                               | Default                            | Type     |
| -------------------- | ------------------------------------------------------------------------- | ---------------------------------- | -------- |
| `flutter_version`    | The version that will be used in Codemagic to build the project.          | stable                             | `string` |
| `bundle_identifier`  | Base bundle identifier of the project. Do not include flavor appends.     | com.avilatek.example               | `string` |
| `flavors`            | The flavors that will be configured to be deployed with Codemagic.        | [production, staging, development] | `array`  |
| `path_to_main_files` | Path to all the main files. All files must be in this directory.          | lib/                               | `string` |
| `beta_groups`        | Beta groups in TestFlight. **Must be created first in App Store Connect** | []                                 | `list`   |
| `email_recipients`   | A list of emails that will receive updates about the CI results.          | []                                 | `list`   |


## Planned for future versions
- Firebase distribution
- iOS/Android only workflows
- Customize CI triggering
- Declare .env variables
- Customize groups for each flavor
- Set different versions for each flavor

_made with 💚 by ⛰️ Avila Tek_

[1]: https://docs.codemagic.io/yaml-quick-start/building-a-flutter-app/#code-signing
[2]: https://docs.codemagic.io/yaml-quick-start/building-a-flutter-app/#code-signing