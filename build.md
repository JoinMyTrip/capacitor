# Build release packages

- Archive Android and iOS versions

```shell
git archive -o capacitor-android-<version>-custom1.tar.gz HEAD:android
git archive -o capacitor-ios-<version>-custom1.tar.gz HEAD:ios
```

- put source into subdirectory (extract into subdirectory before and then run)

```shell
tar -czvf capacitor-android-<version>-custom1.tar.gz capacitor-android-<version>-custom1
tar -czvf capacitor-ios-<version>-custom1.tar.gz capacitor-ios-<version>-custom1
```
