import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import './db/methods.dart';

void main(List<String> args) async {
  initializeDb().then((value) => {runApp(TodoApp())});
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Todo App', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List allTodos;

  void updateList(id, todo) {
    setState(() {
      allTodos = List.from(allTodos)..add(Todo(id: id, name: todo));
    });
  }

  @override
  initState() {
    super.initState();
    getAllTodos();
  }

  getAllTodos() {
    todos().then((value) => {
          setState(() {
            allTodos = value;
          })
        });
  }

  delete(id) async {
    await deleteTodo(id);
  }

  @override
  Widget build(BuildContext context) {
    Widget addTodo = AddTodo(onAdd: (id, todo) => updateList(id, todo));
    Widget todoList =
        ListComponent(items: allTodos, onDelete: (id) => delete(id));

    if (allTodos == null) {
      return new Scaffold(
          appBar: new AppBar(
            title: Text('Todo App'),
          ),
          body: Column(
            children: <Widget>[
              addTodo,
              Expanded(child: Center(child: Text("No Todo's......")))
            ],
          ));
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text('Todo App'),
          ),
          body: Column(
            children: <Widget>[addTodo, Expanded(child: todoList)],
          ));
    }
  }
}

class AddTodo extends StatelessWidget {
  final Function onAdd;

  AddTodo({Key key, this.onAdd}) : super(key: key);

  final myController = TextEditingController();

  void dispose() {
    myController.dispose();
  }

  void addTodo() async {
    var todo = Todo(name: myController.text);
    var id = await insertTodo(todo);
    this.onAdd(id, myController.text);
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
  final List items;
  final Function onDelete;

  ListComponent({Key key, @required this.items, @required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: false,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Dismissible(
            key: Key(item.name),
            onDismissed: (direction) {
              this.onDelete(item.id);
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('${item.name} deleted')));
            },
            background: Container(color: Colors.red),
            child: ListTile(
              title: Text('${item.name}'),
            ));
      },
    );
  }
}
