import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox('count');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var box = Hive.box('count');

  void _count() {
    var count = box.get('countState');
    box.put('countState', count + 1);
    // print(box.get('countState'));
  }

  void _resetCount() {
    box.put('countState', 0);
  }

  @override
  Widget build(BuildContext context) {
    var count = box.get('countState');
    count ??= 0;
    return MaterialApp(
      title: 'Hive Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Hive Counter"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('You Clicked this button:',
                  style: TextStyle(
                    fontSize: 30,
                  )),
              Text(
                '$count',
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    _resetCount();
                  });
                },
                color: Colors.blue,
                child: const Text("Reset"),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _count();
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
