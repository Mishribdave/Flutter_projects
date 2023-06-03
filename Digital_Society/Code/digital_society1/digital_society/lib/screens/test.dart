// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

// class ImageModel {
//   String? url;
//   ImageModel({
//     this.url,
//   });

//   factory ImageModel.fromJson(Map<String, dynamic> map) {
//     return ImageModel(
//       url: map['url'] != null ? map['url'] as String : null,
//     );
//   }
// }

// class MyApi extends StatefulWidget {
//   const MyApi({super.key});

//   @override
//   State<MyApi> createState() => _MyApiState();
// }

// class _MyApiState extends State<MyApi> {
//   String url = "https://jsonplaceholder.typicode.com/photos";

//   Future<List<ImageModel>> fetchImage() async {
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       List result = json.decode(response.body);
//       return result.map((e) => ImageModel.fromJson(e)).toList();
//     } else {
//       throw Exception("Invalid data");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: fetchImage(),
//         builder: (context, snapshot) {
//           List<ImageModel> vdata = snapshot.data!;
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: vdata.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   height: 100,
//                   width: 100,
//                   decoration: BoxDecoration(
//                     image:DecorationImage(
//                       image: NetworkImage(vdata[index].url!),fit: BoxFit.cover)
//                   ),
//                 );
//               },
//             );
//           } else {
//             return
//             Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
