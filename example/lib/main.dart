import 'package:flutter/material.dart';
import 'package:flutter_animated_gradient_button/flutter_animated_gradient_button.dart';
// import 'pa';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

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
                    btnText: "FAG_Button",
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
