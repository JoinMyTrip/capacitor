# Build release packages

- Archive Android and iOS versions

```shell
git archive -o capacitor-android-2.4.7-custom1.tar.gz HEAD:android
git archive -o capacitor-ios-2.4.7-custom.tar.gz HEAD:ios
```

- put source into subdirectory (extract into subdirectory before and then run)

```shell
tar -czvf capacitor-android-2.4.7-custom1.tar.gz capacitor-android-2.4.7-custom1
tar -czvf capacitor-ios-2.4.7-custom1.tar.gz capacitor-ios-2.4.7-custom1
```
