import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final int quantity;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.description,
      required this.quantity});

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['Nome'] ?? '',
      description: data['descrizione'] ?? '',
      price: double.tryParse(data['prezzo'].toString()) ?? 0.0,
      imageUrl: data['imageURL'] ?? '',
      quantity: data['quantity'] ?? 0,
    );
  }
}

