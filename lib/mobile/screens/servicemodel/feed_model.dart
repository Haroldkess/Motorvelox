import 'package:cloud_firestore/cloud_firestore.dart';

class FeedModel {
  late String? id;
  late String? link;
  late String? caption;
  late String? title;
  late Timestamp? timestamp;

  FeedModel({
    this.id,
    this.link,
    this.caption,
    this.title,
    this.timestamp
  });

  factory FeedModel.fromDoc(DocumentSnapshot doc) {
    return FeedModel(
      id: doc.id,
      link: doc['link'],
      caption: doc['caption'],
      title: doc['title'],
      timestamp: doc['timestamp'],
    );
  }
}
