import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  late String? id;
  late String? name;
  late String? desc;
  late String? price;
  late String? image;

  ServiceModel({
    this.id,
    this.name,
    this.desc,
    this.price,
    this.image
  });

  factory ServiceModel.fromDoc(DocumentSnapshot doc) {
    return ServiceModel(
      id: doc.id,
      name: doc['name'],
      desc: doc['desc'],
      price: doc['price'],
      image: doc['image'],
    );
  }
}
