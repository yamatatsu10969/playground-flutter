import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    focusNode.addListener(() {
      print('focusNode: ${focusNode.hasFocus}');
    });
    return    Padding(
            padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: focusNode.unfocus,
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Focus(
                  onFocusChange: (value) => print('Focus: $value'),
                  child: TextFormField(
                    focusNode: focusNode,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
