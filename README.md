# Pokédex Challenge by David Barbero

## Installation

**1. Download Packages and build Translations**
Before starting the application, you need to run the following script to download the translations:

```bash
flutter pub get
```


```bash
dart run intl_utils:generate
```

**2. **Generate Data Models (Optional)****
If you have created new data models for the database (Hive), run the following command:

```bash
flutter pub run build_runner build
```

**3. **Generate the Application****
Example: Android Dev:

```bash
flutter build apk -t lib/main_dev.dart
```
