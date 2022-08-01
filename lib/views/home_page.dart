import 'package:flutter/material.dart';
import 'package:post_api/models/post.dart';
import 'package:post_api/servicess/remote_services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post>? post;
  var isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    post = await RemoteService().getPosts();
    if (post != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Post"),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
            itemCount: post?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        //color: Colors.grey,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.amberAccent),
                        child: Center(child: Text(post![index].id.toString())),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post![index].title,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(post![index].body ?? ""),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
