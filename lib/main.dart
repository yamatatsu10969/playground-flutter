import 'package:flutter/material.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  FocusNode? _focusNode;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode?.addListener(() {
      print('focusNode: ${_focusNode!.hasFocus}');
    });
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              const Text(
                'You have pushed the button this many times: hgoe hoge hoge hoge',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              TextFormField(
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  hintText: 'hoge',
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // show modal
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.8,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              color: Colors.red,
                              child: const Center(
                                child: Text('This is Modal'),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 1000,
                                      color: Colors.white,
                                      child: const Center(
                                        child: Text('This is Modal'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('modal bottom sheet'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
              ),
              const Text('hoge'),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    CustomPaint(
                      // size: const Size(20, 20),
                      painter: Triangle(Colors.green),
                    ),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(
                          100,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Text(
                        'text だよ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Triangle extends CustomPainter {
  Triangle(this.bgColor);
  final Color bgColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = bgColor;
    final path = Path()
      ..lineTo(-20, 20)
      ..lineTo(0, -20)
      ..lineTo(20, 20);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
