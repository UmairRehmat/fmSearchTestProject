import 'package:flutter/material.dart';
import 'package:fmsearcfeature/models/album_response.dart';
import 'package:fmsearcfeature/utilities/network_constants.dart';

class AlbumDetailsScreen extends StatefulWidget {
  const AlbumDetailsScreen(this.item, {Key? key}) : super(key: key);
  final Album item;
  @override
  _AlbumDetailsScreenState createState() => _AlbumDetailsScreenState();
}

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    int length = widget.item.image?.length ?? 0;
    int largeImage = length > 0 ? length - 1 : length;
    String image = widget.item.image?[largeImage]!.text == ""
        ? defaultImage
        : widget.item.image?[largeImage]!.text ?? defaultImage;
    if (!image.startsWith("http")) image = "http://$image";
    return Scaffold(
      appBar: AppBar(
        title: Text("Album details"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.zero,
            elevation: 5,
            child: Container(
              height: height * 0.35,
              child: Center(
                child: Image.network(image),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Album Name:",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    widget.item.name ?? " N/A",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Artist:",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    widget.item.artist ?? " N/A",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
