import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class editblog extends StatefulWidget {
  final dynamic blog;
  editblog(this.blog);

  @override
  State<editblog> createState() => _editblogState();
}

class _editblogState extends State<editblog> {
  final dio = Dio();
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController avatarController;
  bool isLoading = false;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.blog['name']);
    descriptionController =
        TextEditingController(text: widget.blog['description']);
    avatarController = TextEditingController(text: widget.blog['avatar']);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    avatarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Blog'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'name'),
          ),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'description'),
            maxLines: 3,
          ),
          TextFormField(
            controller: avatarController,
            decoration: InputDecoration(labelText: 'avatar'),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              var data = {
                "name": nameController.text,
                "description": descriptionController.text,
                "avatar": avatarController.text,
              };
              editData(data);
            },
            child: isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  )
                : Text('Add')),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'))
      ],
    );
  }

  void editData(Map blog) async {
    setState(() {
      isLoading = true;
    });
    var response = await dio.put(
        'https://65d596c8f6967ba8e3bbe1cc.mockapi.io/blog/${widget.blog['id']}',
        data: blog);

    if (response.statusCode == 200) {
      Navigator.pop(context, response.data);
    }
  }
}
