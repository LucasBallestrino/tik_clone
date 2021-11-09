import 'dart:convert';

class Post {
  String description;
  String userName;
  String id;
  String uri;
  String uId;
  int likes;
  Map<String, String>? comments;
  Post({
    required this.uId,
    required this.description,
    required this.userName,
    required this.uri,
    required this.id,
    required this.comments,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "comments": jsonEncode(this.comments),
        "createdBy": this.userName,
        "desc": this.description,
        "likes": this.likes,
        "videoLink": this.uri,
        "uId": this.uId,
      };

  static Post fromJson(Map json) {
    return Post(
      comments: null,
      id: "",
      userName: json['createdBy'],
      description: json['desc'],
      likes: json['likes'],
      uri: json['videoLink'],
      uId: json['uId'],
    );
  }
}
