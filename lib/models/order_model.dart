import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  late String? id;
  late String? address;
  late String? comment;
  late String? email;
  late String? location;
  late String? name;

  late String? phone;
  late String? price;

  late bool? recieved;
  late Timestamp? timeStamp;
  late String image;
  late String? userId;

  OrderModel(
      {this.id,
      required this.name,
      required this.address,
      required this.comment,
      required this.email,
      required this.price,
      required this.location,
      required this.phone,
      required this.recieved,
      required this.timeStamp,
      required this.image,
      required this.userId});

  factory OrderModel.fromDoc(DocumentSnapshot doc) {
    return OrderModel(
        id: doc.id,
        name: doc['name']!,
        address: doc['address'],
        comment: doc['comment'],
        email: doc['email'],
        price: doc["price"],
        location: doc['location'],
        phone: doc["phone"],
        recieved: doc['recieved'],
        timeStamp: doc['timestamp'],
        image: doc['image'],
        userId: doc['id']);
  }
}

class AdminOrderUserId {
  late String? id;
  late String? userId;

  AdminOrderUserId({
    required this.id,
     this.userId,
  });

  factory AdminOrderUserId.fromDoc(DocumentSnapshot doc) {
    return AdminOrderUserId(id: doc.id,
    // userId: doc['id']
     );
  }
}

class AdminOrderModel {
  late String? id;
  late String? address;
  late String? comment;
  late String? email;
  late String? location;
  late String? name;

  late String? phone;
  late String? price;

  late bool? recieved;
  late Timestamp? timeStamp;
  late String image;
  late String? userId;

  AdminOrderModel(
      {this.id,
      required this.name,
      required this.address,
      required this.comment,
      required this.email,
      required this.price,
      required this.location,
      required this.phone,
      required this.recieved,
      required this.timeStamp,
      required this.image,
      required this.userId});

  factory AdminOrderModel.fromDoc(DocumentSnapshot doc) {
    return AdminOrderModel(
        id: doc.id,
        name: doc['name']!,
        address: doc['address'],
        comment: doc['comment'],
        email: doc['email'],
        price: doc["price"],
        location: doc['location'],
        phone: doc["phone"],
        recieved: doc['recieved'],
        timeStamp: doc['timestamp'],
        image: doc['image'],
        userId: doc['id']);
  }
}
