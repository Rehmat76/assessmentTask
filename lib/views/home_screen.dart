
import 'dart:convert';

import 'package:assessmenttask/models/video_model.dart';
import 'package:assessmenttask/views/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<VideoModel>> listUsers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listUsers = fetchUsers();
  }

  Future<List<VideoModel>> fetchUsers() async {
    final response = await http.get(Uri.parse(
        'https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json'));
    // print("response is ${response.body}");
    if (response.statusCode == 200) {
      var getUsersData = json.decode(response.body) as List;
      var listUsers = getUsersData.map((i) => VideoModel.fromJson(i)).toList();
      return listUsers;
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Video List'),
        centerTitle: true,
      ),

        body: FutureBuilder<List<VideoModel>>(
            future: listUsers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var videoData = (snapshot.data)![index];
                      return Card(
                          child: ListTile(onTap: ()=> Get.to(VideoPlayerScreen(videoUrl: videoData.videoUrl.toString(),) ),
                            leading: CachedNetworkImage(
                              imageUrl: videoData.thumbnailUrl.toString(),
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              height: 90, width: 90,),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Text(
                                  videoData.title.toString(),
                                  style: const TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18))),
                            ),
                            subtitle: Center(child: Text(
                                "Duration ${videoData.duration}", style: TextStyle(
                                color: Colors.indigo.shade500,
                                fontWeight: FontWeight.bold,
                                fontSize: 15))),
                          ));
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.cyanAccent,
                ),
              );
            })
    );
  }
}