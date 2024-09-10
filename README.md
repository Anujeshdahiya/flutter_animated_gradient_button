<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# flutter_animated_gradient_button
Create a Flutter widget for a button with an animated gradient effect.

# Using AnimatedGradientButton objects directly

```dart
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Animated Gradient Button"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
                        height: 100,
              child: const Column(
                 mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedGradientButton(
                    btnText: "FAG_Btn",
                    color1: Colors.green,
                    color2: Colors.yellow,
                    color3: Colors.red,
                    color4: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
