import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/utils/global_variable.dart';
import 'package:instagram_clone_flutter/widgets/AllItem.dart';
import 'package:instagram_clone_flutter/widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      // width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: Colors.grey[900],
              centerTitle: true,
              // title: SvgPicture.asset(
              //   'assets/ic_instagram.svg',
              //   color: primaryColor,
              //   height: 32,
              // ),
              title: Text(
                "ORION",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 240, 238, 237)),
              ),
              // actions: [
              //   IconButton(
              //     icon: const Icon(
              //       Icons.messenger_outline,
              //       color: primaryColor,
              //     ),
              //     onPressed: () {},
              //   ),
              // ],
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // Check if snapshot has data and if data.docs is not empty
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No data available'),
            );
          }

          final List<Map<String, dynamic>> items = snapshot.data!.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();

          // Pad the items list to make it a multiple of 2
          while (items.length % 2 != 0) {
            items.add({});
          }

          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: (items.length / 2).ceil(),
            itemBuilder: (context, rowIndex) {
              final int startIndex = rowIndex * 2;
              final int endIndex = startIndex + 2;

              return Row(
                children: items.sublist(startIndex, endIndex).map((snap) {
                  return Expanded(
                    child: snap.isNotEmpty
                        ? AllItem(
                            snap: snap,
                          )
                        : SizedBox
                            .shrink(), // Use SizedBox.shrink() for empty items
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
