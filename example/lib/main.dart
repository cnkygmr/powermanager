import 'package:flutter/material.dart';
import 'package:powermanager/powermanager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    _powerManagerOn();
  }

  @override
  void dispose() {
    _powerManagerOff();
    super.dispose();
  }

  void _powerManagerOn() async =>
      await Powermanager().on();

  void _powerManagerOff() async =>
      await Powermanager().off();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PowerManager'),
        ),
        body: const Center(
          child: Text('PowerManager'),
        ),
      ),
    );
  }
}
