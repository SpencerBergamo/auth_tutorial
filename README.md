# auth_tutorial

Base Flutter project to get you started with email & password and Google authentication. I also include the image_picker package to store a profile photo in Firebase Storage. Please feel free to contribute to this project, I would love to let others use it as a starting point for their applications! Feel free to add to the UI or state management features.

## Packages for pubspec.yaml

firebase_auth: 
firebase_core:
cloud_firestore:
firebase_storage:
provider:
google_sign_in:
image_picker:
font_awesome_flutter:

Google Sign In docs: https://pub.dev/packages/google_sign_in
Image Picker docs: https://pub.dev/packages/image_picker

## FlutterFire CLI setup: 
### 1. Install the CLI if not already done so
dart pub global activate flutterfire_cli

### 2. Log In to your Flutter Account
firebase login

### 3. Run the `configure` command, select a Firebase project and platforms
flutterfire configure

### 4. Follow terminal instructions to finish Firebase setup
