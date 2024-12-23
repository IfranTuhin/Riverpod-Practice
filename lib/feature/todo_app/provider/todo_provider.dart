import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_practice/feature/todo_app/model/todo_model.dart';

part 'todo_provider.g.dart';

@riverpod
class Todos extends _$Todos{
  @override
  List<TodoModel> build() {
    return [];
  }

  // Add Todo Methods
  void addTodo(TodoModel todo) {
    state = [todo, ...state];
  }

  // Toggle Todo
  void toggleTodo(int id, bool isCompleted) {
    state = [
      for(final todo in state)
        if(todo.id == id)
          todo.copyWith(completed: isCompleted)
        else todo
    ];
  }
}