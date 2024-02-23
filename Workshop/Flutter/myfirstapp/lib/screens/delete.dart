import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Delete extends StatefulWidget {
  final String id;
  Delete(this.id);
  @override
  State<Delete> createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  final dio = Dio();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete"),
      content: Text("Do you want to Delete?"),
      actions: [
        ElevatedButton(
            onPressed: () {
              Delete(widget.id);
            },
            child: Text("Delete")),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"))
      ],
    );
  }

  void Delete(String id) async {
    var response = await dio
        .delete('https://65d596c8f6967ba8e3bbe1cc.mockapi.io/blog/${id}');
    if (response.statusCode == 200) {
      Navigator.pop(context, true);
    }
  }
}
