import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AddBlog extends StatefulWidget {
  AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final dio = Dio();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final avatarController = TextEditingController();
  bool isLoading = false;
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
      title: Text('Add Blog'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
            maxLines: 3,
          ),
          TextFormField(
            controller: avatarController,
            decoration: InputDecoration(labelText: 'Avatar'),
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
              addData(data);
            },
            child: isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  )
                : Text('Add'))
      ],
    );
  }

  void addData(Map data) async {
    setState(() {
      isLoading = true;
    });
    var response = await dio
        .post('https://65d596c8f6967ba8e3bbe1cc.mockapi.io/blog', data: data);

    if (response.statusCode == 201) {
      Navigator.pop(context, response.data);
    }
  }
}
