import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/screens/single.dart';
import 'package:myfirstapp/screens/delete.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dio = Dio();
  bool isLoading = true;
  List<dynamic> blogs = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'MockAPI CRUD',
            style: TextStyle(color: Color.fromARGB(255, 230, 230, 230)),
          )),
          backgroundColor: const Color.fromARGB(255, 107, 91, 90),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  final blog = blogs[index];
                  final id = blog['id'];
                  final title = blog['name'];
                  final avatar = blog['avatar'];
                  final description = blog['description'];
                  print(description);
                  return ListTile(
                    onTap: () => navigateToNextPageId(id),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(avatar),
                    ),
                    title: Text(title),
                    subtitle: Text(
                      description,
                      maxLines: 3,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              print("this is presed");
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () async {
                              var data = await showDialog(
                                  context: context, builder: (_) => Delete(id));
                              if (data == true) {
                                setState(() {
                                  blogs.remove(blog);
                                });
                              }
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  );
                }));
  }

  void navigateToNextPageId(String id) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => SingleScreen(id)));
  }

  void getData() async {
    var response =
        // await dio.get('https://65d5cb34f6967ba8e3bc963e.mockapi.io/blog');
        await dio.get('https://65d596c8f6967ba8e3bbe1cc.mockapi.io/blog');
    if (response.statusCode == 200) {
      setState(() {
        blogs = response.data;
        isLoading = false;
      });
    }
  }
}
