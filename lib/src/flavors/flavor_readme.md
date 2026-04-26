# Adding a New Flavor
This guide explains how to add a new flavor to your Flutter project, including Android build configuration, app icon, splash, and build integration.
---

# ---------------------------- Android ---------------------------- #

## 1. Create the Flavor in Android build.gradle
1. **Open `android/app/build.gradle` or `build.gradle.kts`**
2. In the `flavorDimensions` and `productFlavors` section, add your new flavor. For example:
**Kotlin DSL (build.gradle.kts):**
```kotlin
android {
    ...
    flavorDimensions += "default"
    productFlavors {
        create("techlab") {
            dimension = "default"
            applicationIdSuffix = ".techlab"
            resValue("string", "app_name", "Techlab")
        }
        create("aboellez") {
            dimension = "default"
            applicationIdSuffix = ".aboellez"
            resValue("string", "app_name", "Aboellez")
        }
        create("myflavor") { // <-- Add your new flavor here
            dimension = "default"
            applicationIdSuffix = ".myflavor"
            resValue("string", "app_name", "MyFlavor")
        }
    }
}
```
---
## 2. Create the Flavor Class
1. In `lib/src/flavors/`, create a new folder for your flavor (e.g., `myflavor`).
2. Add a Dart file for your flavor, e.g., `myflavor_flavor.dart`:
```dart
import 'package:coursaty/src/flavors/interface_flavor.dart';
import 'package:flutter/widgets.dart';
class MyFlavor implements InterfaceFlavor {
   @override
  String get appName => 'MyFlavor';

  @override
  String get flavorName => 'myFlavor';

  @override
  String get appIcon => 'lib/src/flavors/$flavorName/app_icon.png';

  @override
  String get appSplash => 'lib/src/flavors/$flavorName/app_icon.png';

  @override
  String get upgradeImage => 'lib/src/flavors/$flavorName/upgrade.png';

  @override
  String get splashPattern => 'lib/src/flavors/$flavorName/appicons/splash_pattern.png';

  @override
  Color get primaryColor => const Color(0xff123456); // Change as needed
  @override
  Color get secondaryColor => const Color(0xff654321); // Change as needed



  @override
  String get apiUrlProd => "https://saas.crazyidea.online/api/";

  @override
  String get apiUrlDev => 'https://edu.techlabeg.com/api/';

  @override
  String get apiKey =>
      r'api_key'; 

  @override
  FirebaseOptions? get firebaseOptions => AtharFirebaseOptions.currentPlatform;
}
```
---
## 3. Add Assets
- Place your app icon, splash, and other images in `assets/flavors/myflavor/`.
  - `app_icon.png` (launcher icon)
  - `splash_image.png` (splash image)
  - `upgrade.png` (upgrade image)
  - `splash_pattern.png` (optional splash pattern)
- In `pubspec.yaml` add the new flavor to the `assets` section.
  ```yaml
  assets:
    - assets/flavors/myflavor/
  ```
> **Note:** You **must** use "app_icon.png" and "splash_icon.png" names for your assets.
>
> This is required because the build and icon generation scripts expect the path to be exactly
> for app icon `'assets/flavors/$flavor/app_icon.png'`.
> for splash icon `'assets/flavors/$flavor/splash_icon.png'`.
---
## 4. Add Your Flavor to Tasks to enable build (if you use vscode)
- Open `.vscode/tasks.json`.
- In the `"inputs"` section, add your new flavor (e.g., `"myflavor"`) to the `"options"` array:
  ```json
  "inputs": [
    {
      "id": "flavor",
      "type": "pickString",
      "description": "Select flavor",
      "options": [
        "techlab",
        "aboellez",
        "myflavor" // add your new flavor here
      ]
    }
  ]
  ```
  ### otherwise you can run those commands to build the app
```bash
dart run lib/src/core/configs/build_release_config.dart --flavor techlab # build apk
dart run lib/src/core/configs/build_release_config.dart --flavor techlab --abb # build appbundle
dart run lib/src/core/configs/launch_app_icon_config.dart --flavor techlab # launch app icon
dart run lib/src/core/configs/lafunch_native_splash_icon_config.dart --flavor techlab # launch native splash icon
```
---
## 5. Add Launch/Build Configurations to enable launch (if you use vscode)
- Add a new entry in `.vscode/launch.json` for your flavor:
  ```json
       {
            "name": "Flutter - techlab",
            "request": "launch",
            "type": "dart",
            "program": "lib/main.dart",
            "noDebug": true,
            "args": [
                "--flavor=techlab",
                "--dart-define=FLAVOR=techlab",
            ]
        },
  ```
  ### otherwise you can run those commands to launch the app
```bash
  flutter run --flavor techlab --dart-define FLAVOR=techlab
  flutter run --release --flavor techlab --dart-define FLAVOR=techlab
```
---
## 6. Add Google Service File & firebase_options
- Place your `google-services.json` (for Android) path for your new flavor:
  `android/app/src/<yourflavor>/google-services.json`
- If you are using Firebase, run the following command to generate the `firebase_options.dart` file:
  ```bash
  flutterfire configure \
  --project=<project-id> \
  --android-package-name=<package-name> \
  --ios-bundle-id=<package-name>
  ```
- Make sure to replace `<project-id>` and `<package-name>` with your actual Firebase project ID and package name.
- This will generate the `firebase_options.dart` file in `lib/firebase_options.dart`.
- move it to `lib/src/flavors/<yourflavor>/your_flavor_firebase_options.dart`
---
## 7. Register Your Flavor in main.dart
- Open `lib/src/flavors/flover_inject.dart`.
- In the `injectFlavor()` method, add a case for your new flavor. For example:
  ```dart
  class FlavorInject {
    static void injectFlavor() {
      const flavor = String.fromEnvironment('FLAVOR');
      printDM("flavor is $flavor");
      switch (flavor) {
        case 'techlab':
          FlavorHolder.instance.flavor = TechlabFlavor();
          printDM('techlab flavor injected');
          break;
        case 'aboellez':
          FlavorHolder.instance.flavor = AboellezFlavor();
          printDM('aboellez flavor injected');
          break;
      }
    }
  }
  ```
---
> **Note:** The flavor name in the `injectFlavor()` method must be the same as the flavor name in the `flavor` inputs in the `.vscode/tasks.json` file and the `flavor` argument in the `launch.json` file and the flavor name in the `productFlavors` section in the `build.gradle.kts` file.
## 8. Test Your Flavor
- Run your app icon
- Run your app apk/appbundle
**That’s it! Your new flavor is ready.**


# -------------------------------------- IOS --------------------------------------------- #

## 1. Add Scheme

1. **Open your iOS project in Xcode** by navigating to `ios/Runner.xcworkspace`

2. **Create a new scheme for your flavor:**
  - In Xcode, go to **Product > Scheme > Manage Schemes**
  - Click the **"+"** button to create a new scheme
  - Name it after your flavor (e.g., "myflavor")
  - Make sure the target is set to "Runner"

------------

## 2. Create Build Configuration

1. **In Xcode, select the Runner project** in the navigator

2. **Go to the Info tab** of the project settings

3. **Duplicate existing configurations:**
  - Right-click on "Debug" and select **"Duplicate"**
  - Rename it to "Debug-myflavor"
  - Right-click on "Profile" and select **"Duplicate"**
  - Rename it to "Profile-myflavor"
  - Right-click on "Release" and select **"Duplicate"**
  - Rename it to "Release-myflavor"

> **Note:** Ensure that Your configurations should be based on your **Debug.xconfig**, **Profile.xcconfig**, and **Release.xcconfig** files, not the **Pods-Runner.xcconfigs** file. You can check this by expanding the configuration names in Xcode.

4. **Update scheme to use new configurations:**
  - In Xcode, go to **Product > Scheme > Manage Schemes**
  - Select your scheme and click **"Edit"**
  - In the **Build** tab, ensure "Runner" target is selected
  - In the **Run** tab, 
    - set **Build Configration** to "Debug-myflavor"
    - Then go to **Arguments** and add:
    - Under **Arguments Passed On Launch**: 
      `--dart-define=FLAVOR=myflavor`
      `--config-only`
    - Under **Environment Variables**: Add `FLUTTER_FLAVOR` with value `myflavor`
  - In the **Test** tab, set **Build Configuration** to "Debug-myflavor"
  - In the **Analyze** tab, set **Build Configuration** to "Debug-myflavor"
  - In the **Profile** tab, set **Build Configuration** to "Profile-myflavor"
  - In the **Archive** tab, set **Build Configuration** to "Release-myflavor"

> **Note:** `FLUTTER_FLAVOR` Not mandatory for Flutter itself.
Flutter flavors are controlled by --flavor and --dart-define=FLAVOR=myflavor. These are enough for Dart to know which flavor to inject (through your FlavorInject class).
It’s mainly useful for native iOS code (Swift/Objective-C).
If you have native code (e.g., push notification setup, app group IDs, environment-specific API keys, Firebase plist switching, etc.), you might

## 3. Configure Bundle Identifier

1. **Select the Runner target** in Xcode
2. **Go to Build Settings** tab
3. **Search for "Product Bundle Identifier"**
4. **Set different bundle identifiers for each configuration:**
  - For "Debug-myflavor": `com.yourcompany.my.flavor`
  - For "Profile-myflavor": `com.yourcompany.my.flavor`
  - For "Release-myflavor": `com.yourcompany.my.flavor`


## 4. Configure App Display Name

  1. **In Xcode, select the Runner target**
  2. **Go to Build Settings** tab
  3. **Search for "Product Name"**
  4. **Set different app names for each configuration:**
    - For "Debug-myflavor": `MyFlavor Debug`
    - For "Profile-myflavor": `MyFlavor Profile`
    - For "Release-myflavor": `MyFlavor`
## 5. Add Firebase Configuration

  1. **Create flavor-specific directories:**
    ```
    ios/config/
    ├── myflavor/
    │   └── GoogleService-Info.plist
    ├── techlab/
    │   └── GoogleService-Info.plist
    └── aboellez/
       └── GoogleService-Info.plist
    ```

  2. **Add your flavor's `GoogleService-Info.plist`** to `ios/config/myflavor/`

## 6. Update flavor version 

1. **In Xcode, select the Runner target**
2. **Go to Build Settings** tab
3. **Search for "Versioning"**
4. **Set different versioning for each configuration:**
  - In "**Current Project Version**" set the build number for each configuration
  - In "**Marketing Version**" set the version number for each configuration

> **Note:** You don't have to change for debug, profile, just change for release.

## 7. Test iOS Flavor

1. **Run in debug mode:**
   ```bash
   flutter run --flavor myflavor --dart-define FLAVOR=myflavor
   ```

2. **Build for release:**
   ```bash
   flutter build ios --flavor myflavor --dart-define FLAVOR=myflavor
   ```

3. **Run from Xcode:**
   - Select your flavor scheme (e.g., "myflavor")
   - Press Cmd+R to run
   - The correct Firebase config will be copied automatically

**That's it! Your iOS flavor is now properly configured.**