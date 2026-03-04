import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateProviderScreen extends ConsumerStatefulWidget {
  const StateProviderScreen({super.key});

  @override
  ConsumerState<StateProviderScreen> createState() =>
      _StateProviderScreenState();
}

class _StateProviderScreenState extends ConsumerState<StateProviderScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter Screen')),
      body: Center(
        child: Column(
          children: [
            Text('You have pushed the button this many times: $_counter'),
            Text('Counter: $_counter'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _counter++;
                    });
                  },
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _counter--;
                    });
                  },
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
