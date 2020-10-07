import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import './db/methods.dart';

void main(List<String> args) {
  initializeDb();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Todo App', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key) {
    getAllTodos();
  }

  List<Object> allTodos = [];

  void getAllTodos() async {
    allTodos = await todos();
  }

  @override
  Widget build(BuildContext context) {
    Widget addTodo = AddTodo();
    Widget todoList = ListComponent(items: allTodos);

    return Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
        ),
        // body: Column(children: [addTodo, todoList]),
        body: Column(
          children: <Widget>[addTodo, Expanded(child: todoList)],
        ));
  }
}

class AddTodo extends StatefulWidget {
  AddTodo({Key key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  void addTodo() async {
    var todo = Todo(name: myController.text);
    await insertTodo(todo);
    print("Todo Added: ${myController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: myController,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (term) {
          addTodo();
        },
        decoration: InputDecoration(
          hintText: "Add Todo",
          suffixIcon: IconButton(
            onPressed: () => {myController.clear()},
            icon: Icon(Icons.clear),
          ),
        ),
      ),
    );
  }
}

class ListComponent extends StatelessWidget {
  final List<Object> items;

  ListComponent({Key key, @required this.items}) : super(key: key){
    print('todo list ${this.items}');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: false,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${items[index]}'),
        );
      },
    );
  }
}