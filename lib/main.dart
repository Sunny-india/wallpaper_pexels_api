import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/src_model.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirstPage(),
  ));
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late Future<DataPhoto> data;
  Future<DataPhoto> fetchPhotosFromPexel(String query) async {
    String webAddress =
        'https://api.pexels.com/v1/search?query=$query&per_page=20';
    DataPhoto dataPhoto;
    var response = await http.get(Uri.parse(webAddress), headers: {
      'Authorization':
          'zniJvGPGePLscmLk7ixnLyhOIWq0QYJxvC8R32kH50Xmjkh4Bzjict80'
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      dataPhoto = DataPhoto.fromJson(json);
      return dataPhoto;
    } else {
      return DataPhoto();
    }
  }

  @override
  void initState() {
    data = fetchPhotosFromPexel('nature');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: FutureBuilder<DataPhoto>(
            future: data,
            builder:
                (BuildContext context, AsyncSnapshot<DataPhoto?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (!snapshot.hasData) {
                return const Text('Not Data Exists');
              } else {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2),
                    itemCount: snapshot.data!.photos!.length,
                    itemBuilder: (context, index) {
                      Photo photo = snapshot.data!.photos![index];
                      return Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    photo.src!.portrait.toString()))),
                      );
                    });
              }
            }),
      ),
    );
  }
}

/// Ankit Madaan from Youtube method
// Future<DataPhoto> fetchPhotosFromPexels() async {
//   String webAddress = 'https://api.pexels.com/v1/curated?per_page=80';
//   DataPhoto dataPhoto;
//   await http.get(Uri.parse(webAddress), headers: {
//     'Authorization':
//         'zniJvGPGePLscmLk7ixnLyhOIWq0QYJxvC8R32kH50Xmjkh4Bzjict80'
//   }).then((value) {
//     var json = jsonDecode(value.body);
//     setState(() {});
//     images = json['photos'];
//     print('starts here');
//     // print(images);
//     //print('ends here');
//     //print(images.length);
//     dataPhoto = DataPhoto.fromJson(json);
//     print(dataPhoto.photos!.length);
//     //
//   });
//   return dataPhoto;
// }
