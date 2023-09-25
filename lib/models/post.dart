import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final likes;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  final String itemname;
  // final String Description;
  final String RentailAmount;
  final String Deposite;
  final String phone;
  final String address;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.Deposite,
    // required this.Description,
    required this.RentailAmount,
    required this.address,
    required this.itemname,
    required this.phone,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      description: snapshot["description"],
      uid: snapshot["uid"],
      likes: snapshot["likes"],
      postId: snapshot["postId"],
      datePublished: snapshot["datePublished"],
      username: snapshot["username"],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage'],
      // Description: snapshot["Description"],
      itemname: snapshot["itemname"],
      RentailAmount: snapshot["RentailAmount "],
      Deposite: snapshot["Deposite"],
      phone: snapshot["phone"],
      address: snapshot['address'],
    );
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "likes": likes,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'profImage': profImage,
        // 'Description': Description,
        'itemname': itemname,
        'RentailAmount': RentailAmount,
        'Deposite': Deposite,
        'phone': phone,
        'address': address,
      };
}
