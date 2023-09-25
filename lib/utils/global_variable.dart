// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:instagram_clone_flutter/screens/add_post_screen.dart';
// import 'package:instagram_clone_flutter/screens/feed_screen.dart';
// import 'package:instagram_clone_flutter/screens/profile_screen.dart';
// import 'package:instagram_clone_flutter/screens/search_screen.dart';

// const webScreenSize = 600;

// List<Widget> homeScreenItems = [
//   const FeedScreen(),
//   const SearchScreen(snap: {},),
//   const AddPostScreen(),
//   const Text('notifications'),
//   ProfileScreen(
//     uid: FirebaseAuth.instance.currentUser!.uid,
//   ),
// ];

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/screens/add_post_screen.dart';
import 'package:instagram_clone_flutter/screens/feed_screen.dart';
import 'package:instagram_clone_flutter/screens/profile_screen.dart';
import 'package:instagram_clone_flutter/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(
      snap: {}), // Remove 'const' since SearchScreen requires a parameter
  const AddPostScreen(),
  const Text('notifications'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
