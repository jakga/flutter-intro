import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  bool isDone;
  String title;

  Todo(this.title, {this.isDone = false});
}

class Todolist extends StatefulWidget {
  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  var _todoController = TextEditingController();

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _todoController,
                  ),
                ),
                RaisedButton(
                  child: Text('추가'),
                  onPressed: () => _addTodo(Todo(_todoController.text)),
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('todo').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('Firebase를 연결하세요.')
                      ],
                    );
                  }
                  final documents = snapshot.data.documents;
                  return Expanded(
                    child: ListView(
                      children: documents
                          .map((doc) => _buildItemWidget(doc))
                          .toList(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
    final todo = Todo(doc['title'], isDone: doc['isDone']);
    return ListTile(
      onTap: () => _toggleTodo(doc),
      title: Text(
        todo.title,
        style: todo.isDone
            ? TextStyle(
                decoration: TextDecoration.lineThrough,
                fontStyle: FontStyle.italic,
              )
            : null,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () => _deleteTodo(doc),
      ),
    );
  }

  void _addTodo(Todo todo) {
    Firestore.instance
        .collection('todo')
        .add({'title': todo.title, 'isDone': todo.isDone});
    _todoController.text = '';
  }

  _deleteTodo(DocumentSnapshot doc) {
    Firestore.instance.collection('todo').document(doc.documentID).delete();
  }

  _toggleTodo(DocumentSnapshot doc) {
    Firestore.instance.collection('todo').document(doc.documentID).updateData({
      'isDone': !doc['isDone'],
    });
  }
}
