// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:instagram_clone_flutter/utils/colors.dart';
// import 'package:instagram_clone_flutter/utils/global_variable.dart';

// class MobileScreenLayout extends StatefulWidget {
//   const MobileScreenLayout({Key? key}) : super(key: key);

//   @override
//   State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
// }

// class _MobileScreenLayoutState extends State<MobileScreenLayout> {
//   int _page = 0;
//   late PageController pageController; // for tabs animation

//   @override
//   void initState() {
//     super.initState();
//     pageController = PageController();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     pageController.dispose();
//   }

//   void onPageChanged(int page) {
//     setState(() {
//       _page = page;
//     });
//   }

//   void navigationTapped(int page) {
//     //Animating Page
//     pageController.jumpToPage(page);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: pageController,
//         onPageChanged: onPageChanged,
//         children: homeScreenItems,
//       ),
//       bottomNavigationBar: Container(

//         child: CupertinoTabBar(
//           backgroundColor: Colors.grey[900],

//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(

//               icon: Icon(
//                 Icons.home,
//                 color: (_page == 0) ? primaryColor : Colors.white,
//               ),
//               label: '',
//               backgroundColor: primaryColor,
//             ),
//             BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.search,
//                   color: (_page == 1) ? primaryColor : Colors.white,
//                 ),
//                 label: '',
//                 backgroundColor: primaryColor),
//             BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.add_a_photo_outlined,
//                   color: (_page == 2) ? primaryColor : Colors.white,
//                 ),
//                 label: '',
//                 backgroundColor: primaryColor),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.bookmark_added_rounded,
//                 color: (_page == 3) ? primaryColor : Colors.white,
//               ),
//               label: '',
//               backgroundColor: primaryColor,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.person,
//                 color: (_page == 4) ? primaryColor : Colors.white,
//               ),
//               label: '',
//               backgroundColor: primaryColor,
//             ),
//           ],
//           onTap: navigationTapped,
//           currentIndex: _page,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/utils/global_variable.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    // Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: ClipRRect(
        // Wrap with ClipRRect
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0)), // Set the radius here
        child: CupertinoTabBar(
          backgroundColor: Colors.grey[900],
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: (_page == 0) ? primaryColor : Colors.white,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: (_page == 1) ? primaryColor : Colors.white,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_a_photo_outlined,
                color: (_page == 2) ? primaryColor : Colors.white,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark_added_rounded,
                color: (_page == 3) ? primaryColor : Colors.white,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: (_page == 4) ? primaryColor : Colors.white,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}
