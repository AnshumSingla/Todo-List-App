import 'package:flutter/material.dart';

class taskPage extends StatelessWidget {
  final String taskName;
  const taskPage({super.key, required this.taskName});

  @override
  Widget build(BuildContext context) {
    const String tasktitle = 'Untitled';
    final TextEditingController changedTitle =
        TextEditingController(text: tasktitle);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context, changedTitle.text);
          },
        ),
        backgroundColor: const Color.fromARGB(171, 0, 0, 0),
        title: const Text(
          'Tasks',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color.fromRGBO(89, 89, 89, 1),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: TextField(
          style: const TextStyle(
            color: Colors.white, 
          ),
          controller: changedTitle,
          cursorColor: Colors.blue,
          decoration: const InputDecoration(
            labelStyle: TextStyle(color: Colors.white),
            labelText: 'Title',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey), 
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue), 
            ),
          ),
        ),
      ),
    );
  }
}
