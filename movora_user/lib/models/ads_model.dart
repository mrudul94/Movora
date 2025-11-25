import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String postId;
  final String userId;
  final String username;
  final String userProfile;
  final String productName;
  final String description;
  final double price;
  final String imageUrl;
  final List<dynamic> likes;
  final String location;
  final String status;
  final Timestamp createdAt;

  PostModel({
    required this.postId,
    required this.userId,
    required this.username,
    required this.userProfile,
    required this.productName,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.likes,
    required this.location,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'userId': userId,
      'username': username,
      'userProfile': userProfile,
      'productName': productName,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'likes': likes,
      'location': location,
      'status': status,
      'createdAt': createdAt,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['postId'],
      userId: json['userId'],
      username: json['username'],
      userProfile: json['userProfile'],
      productName: json['productName'],
      description: json['description'],
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'],
      likes: json['likes'] ?? [],
      location: json['location'] ?? '',
      status: json['status'] ?? 'active',
      createdAt: json['createdAt'] ?? Timestamp.now(),
    );
  }
}
