import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SingleScreen extends StatefulWidget {
  final String id;
  SingleScreen(this.id);
  @override
  State<SingleScreen> createState() => _SingleScreenState();
}

class _SingleScreenState extends State<SingleScreen> {
  final dio = Dio();
  bool isLoading = true;
  dynamic blog = {};
  @override
  void initState() {
    super.initState();
    getData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Single Page")),
          backgroundColor: Color.fromARGB(255, 6, 54, 87),
          foregroundColor: Colors.white,
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [
                      Image(
                        image: NetworkImage(blog['avatar']),
                        height: 250,
                        width: 250,
                      ),
                      Text(
                        blog['name'],
                        textAlign: TextAlign.center,
                      ),
                      Text(blog['description'])
                    ],
                  ),
                ),
              ));
  }

  void getData(String id) async {
    var response =
        // await dio.get('https://65d5cb34f6967ba8e3bc963e.mockapi.io/blog');
        await dio.get('https://65d596c8f6967ba8e3bbe1cc.mockapi.io/blog/${id}');
    if (response.statusCode == 200) {
      setState(() {
        blog = response.data;
        print(blog);
        isLoading = false;
      });
    }
  }
}
