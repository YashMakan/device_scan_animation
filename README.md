## Device Scan Animation

A package to quickly add nearby device scan animation with customizations.

https://github.com/YashMakan/device_scan_animation/assets/70023200/5008f628-bcf3-40b7-ad88-eadf581c9d56

## Pub.dev

The package is available on pub.dev
[Device Scan Animation Package](https://pub.dev/packages/device_scan_animation)

## Usage

For basic usage checkout the example provided.
Below are all the parameters `DeviceScanWidget` accepts for customizations.

```dart
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DeviceScanWidget(
          nodeType
          : ..., // optional
          ringColor: ..., // optional
          ringThickness: ..., // optional
          nodeColor: ..., // optional
          onInitialize: () {}, // optional
          newNodesDuration: ..., // optional
          duration: ..., // optional
          scanColor: ..., // optional
          centerNodeColor: ..., // optional
          gap: ..., // optional
          layers: ..., // optional
          hideNodes: ..., // optional
        ),
      ),
    );
  }
}

```
