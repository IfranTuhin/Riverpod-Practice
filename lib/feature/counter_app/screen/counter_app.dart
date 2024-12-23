import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/feature/counter_app/provider/counter_provider.dart';

class CounterApp extends ConsumerWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    print('Counter screen building....');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter App"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('You have pushed the button this many time : '),
                const  SizedBox(height: 30),
                Consumer(
                  builder: (context, WidgetRef ref, Widget? child) {
                    final counter = ref.watch(counterProvider);
                    return Text(counter.toString(), style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600,),);
                  }
                ),
                const  SizedBox(height: 50),
                //
                ElevatedButton(onPressed: () {
                  ref.read(counterProvider.notifier).decrement();
                }, child: const Text('-', style: TextStyle(fontSize: 20),))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
