import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:instagram_clone_flutter/models/user.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/resources/firestore_methods.dart';
import 'package:instagram_clone_flutter/widgets/like_animation.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Itemdetail extends StatefulWidget {
  final Map<String, dynamic> snap;

  Itemdetail({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<Itemdetail> createState() => _ItemdetailState();
}

class _ItemdetailState extends State<Itemdetail> {
  final TextEditingController _commentEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentEditingController.dispose();
  }

  double rating = 5.0;
  _launchPhoneCall() async {
    final String? phoneNumber = widget.snap['phone'];

    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

      // Use the `mailto` package to attempt the phone call
      try {
        await launch(phoneUri.toString());
      } catch (e) {
        print('Error launching phone call: $e');
        // Handle the error here, e.g., show an error message to the user.
      }
    } else {
      // Handle the case where the phone number is empty or null.
      // You can show a message to the user or take appropriate action.
    }
  }

  _launchMessage() async {
    final phoneNumber = widget.snap['phone'];
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      final Uri messageUri = Uri(scheme: 'sms', path: phoneNumber);
      final String uri = messageUri.toString();
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  _launchMap(String? address) async {
    if (address != null && address.isNotEmpty) {
      final Uri mapUri = Uri.parse(
          'https://www.google.com/maps?q=${Uri.encodeQueryComponent(address)}');

      try {
        await launch(mapUri.toString());
      } catch (e) {
        print('Error launching map: $e');
        // Handle the error here, e.g., show an error message to the user.
      }
    } else {
      // Handle the case where the address is empty or null.
      // You can show a message to the user or take appropriate action.
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF475269).withOpacity(0.3),
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Color(0xFF475269),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.48,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      widget.snap['postUrl'] ?? '',
                      height: 380,
                      width: 400,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  // height: MediaQuery.of(context).size.height * 0.9,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 245, 245, 245),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 86, 86, 119)
                            .withOpacity(0.4),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.snap['itemname'] ?? '',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Rs.' + (widget.snap['RentailAmount'] ?? ''),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          LikeAnimation(
                            isAnimating:
                                widget.snap['likes'].contains(user.uid),
                            smallLike: true,
                            child: IconButton(
                              onPressed: () async {
                                await FireStoreMethods().likePost(
                                    widget.snap['postId'],
                                    user.uid,
                                    widget.snap['likes']);
                              },
                              icon: widget.snap['likes'].contains(user.uid)
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 30,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      color: Colors.black,
                                    ),
                            ),
                          ),
                          Text(
                            '${widget.snap['likes'].length} likes',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Description :",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            widget.snap['description'] ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: Colors.grey[900],
                        thickness: 0.50,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Deposit: ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.snap['Deposite'] ?? '',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: Colors.grey[900],
                        thickness: 0.50,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Contact:",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _launchPhoneCall();
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.call,
                                  color: Colors.blue,
                                  size: 28,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '+91 ' + (widget.snap['phone'] ?? ''),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _launchMessage();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.message,
                                  color: Colors.green,
                                  size: 28,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '+91 ' + (widget.snap['phone'] ?? ''),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: Colors.grey[900],
                        thickness: 0.50,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Address:",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          _launchMap(widget.snap['address']);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 28,
                            ),
                            SizedBox(width: 5),
                            Text(
                              widget.snap['address'] ?? '',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: Colors.grey[900],
                        thickness: 0.50,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors
                              .yellow, // Change the background color as needed
                          borderRadius:
                              BorderRadius.circular(10), // Add rounded corners
                        ),
                        padding:
                            EdgeInsets.all(16), // Add padding around the text
                        child: Text(
                          'For renting the product CALL and MESSAGE no given Detail!!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: Colors.grey[900],
                        thickness: 0.50,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                widget.snap['profImage'].toString()),
                            radius: 13,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 16, right: 8.0),
                              child: TextField(
                                controller: _commentEditingController,
                                decoration: InputDecoration(
                                  hintText: 'Comment as username',
                                  border: InputBorder.none,
                                  // Style the text within the TextField
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey, // Customize the color
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 16, // Customize the font size
                                  color:
                                      Colors.black, // Customize the text color
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: Colors
                                  .white, // Background color of the container
                              borderRadius:
                                  BorderRadius.circular(25), // Rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), // Shadow color
                                  spreadRadius: 2, // Spread radius
                                  blurRadius: 5, // Blur radius
                                  offset: Offset(
                                      0, 3), // Offset in the x and y direction
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () async {
                                await FireStoreMethods().postComment(
                                    widget.snap['postId'],
                                    _commentEditingController.text,
                                    user.uid,
                                    user.username,
                                    user.photoUrl);
                                setState(() {
                                  _commentEditingController.text = "";
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 7),
                                child: Text(
                                  'Post',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: Colors.grey[900],
                        thickness: 0.50,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Review :',
                            style: TextStyle(
                                color: Colors.grey[900], fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Column(

                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('posts')
                            .doc(widget.snap['postId'])
                            .collection('comments')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text("No comments available."),
                            );
                          }

                          // Build a list of comment widgets with space in between
                          List<Widget> commentWidgets = [];

                          for (var commentDoc in snapshot.data!.docs) {
                            var commentData =
                                commentDoc.data() as Map<String, dynamic>;
                            commentWidgets.add(
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical:
                                        8.0), // Adjust the vertical spacing here
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 8.0,
                                      ),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          widget.snap['profImage'].toString(),
                                        ),
                                        radius: 13,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: widget.snap['username']
                                                    .toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              WidgetSpan(
                                                child: SizedBox(
                                                  width: 7,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${commentData['text'].toString()}',
                                                style: TextStyle(
                                                  color: Colors.grey[900],
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Additional widgets or content here
                                  ],
                                ),
                              ),
                            );
                          }

                          // Use a ListView to display all comment widgets
                          return ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: commentWidgets,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
