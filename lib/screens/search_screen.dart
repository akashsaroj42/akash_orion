import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/screens/profile_screen.dart';
import 'package:instagram_clone_flutter/widgets/ItemDetail.dart';

class SearchScreen extends StatefulWidget {
  final Map<String, dynamic> snap;

  const SearchScreen({Key? key, required this.snap}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Form(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Product...',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 121, 121, 122),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: const Color.fromARGB(255, 126, 128, 129),
                ),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
              ),
              onFieldSubmitted: (String _) {
                setState(() {
                  isShowUsers = true;
                });
              },
              style: TextStyle(
                color: const Color.fromARGB(255, 13, 14, 14),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isShowUsers
            ? FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('posts')
                    .where(
                      'itemname',
                      isGreaterThanOrEqualTo: searchController.text,
                    )
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  final List<QueryDocumentSnapshot> postDocuments =
                      snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: postDocuments.length,
                    itemBuilder: (context, index) {
                      final Map<String, dynamic> post =
                          postDocuments[index].data() as Map<String, dynamic>;

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Itemdetail(
                                    snap: post,
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Container(
                                width:
                                    100, // Adjust the width and height as needed
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(post['postUrl']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(
                                post['itemname'],
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ), // Add a divider between search results
                        ],
                      );
                    },
                  );
                },
              )
            : FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('posts')
                    .orderBy('datePublished')
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  final List<QueryDocumentSnapshot> postDocuments =
                      snapshot.data!.docs;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of columns
                      mainAxisSpacing: 8.0, // Spacing along the main axis
                      crossAxisSpacing: 8.0, // Spacing along the cross axis
                      childAspectRatio: 0.75, // Aspect ratio of grid items
                    ),
                    itemCount: postDocuments.length,
                    itemBuilder: (context, index) {
                      final Map<String, dynamic> post =
                          postDocuments[index].data() as Map<String, dynamic>;

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Itemdetail(
                                snap: post,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 3,
                          child: Image.network(
                            post['postUrl'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
