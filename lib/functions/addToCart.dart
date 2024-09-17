import 'package:flutter/material.dart';
import 'package:flutter_application_14/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addToCart(BuildContext context, Product product) async {
    final cartRef = FirebaseFirestore.instance.collection('cart');
    
    final querySnapshot = await cartRef.where('productId', isEqualTo: product.id).get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      final doc = querySnapshot.docs.first;
      final newQuantity = (doc['quantity'] ?? 0) + 1;

      await cartRef.doc(docId).update({'quantity': newQuantity});
    } else {
      await cartRef.add({
        'productId': product.id,
        'name': product.name,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'quantity': 1,
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${product.name} è stato aggiunto al Carrello con successo'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK',style: TextStyle(color: const Color.fromARGB(255, 35, 47, 62),),),
            ),
          ],
        );
      },
    );
  }