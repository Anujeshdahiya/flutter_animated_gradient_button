# flutter_animated_gradient_button
A flutter widget for animated gradient button.

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
