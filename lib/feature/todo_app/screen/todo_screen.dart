import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/feature/todo_app/model/todo_model.dart';
import 'package:riverpod_practice/feature/todo_app/provider/todo_provider.dart';


class TodoScreen extends ConsumerWidget {
  TodoScreen({super.key});

  TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    

    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Screen'),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: inputController,
                  decoration: InputDecoration(
                    hintText: 'Type your todo..',
                    border: OutlineInputBorder(),
                  ),
                  onFieldSubmitted: (value) => {
                    ref.read(todosProvider.notifier).addTodo(
                      TodoModel(id: Random().nextInt(9999), description: value, completed: false),
                    ),
                    showSnackBar(context),
                    inputController.text = '',
                  },
                ),
                const SizedBox(height: 20),

                // Display Todos
                Consumer(
                  builder: (context, ref, child) {
                    final todos = ref.watch(todosProvider);
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: todos.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(
                          todos[index].description,
                          style: todos[index].completed ? const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.red) : null,
                        ),
                        trailing: Checkbox(
                          value: todos[index].completed,
                          onChanged: (value) => {
                            ref.read(todosProvider.notifier).toggleTodo(todos[index].id, value!),
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Show Snackbar
  showSnackBar(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Todo Added Successfully', style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.green,
    ));
  }
}
