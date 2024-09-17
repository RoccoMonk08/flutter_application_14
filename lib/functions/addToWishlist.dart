import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_14/model/product.dart';

Future<void> addToWishlist(BuildContext context, Product product) async {
    final wishlistRef = FirebaseFirestore.instance.collection('wishlist');


    final querySnapshot = await wishlistRef.where('productId', isEqualTo: product.id).get();

    if (querySnapshot.docs.isNotEmpty) {

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('${product.name} è già nella Wishlist'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK',style: TextStyle(color: const Color.fromARGB(255, 35, 47, 62),),),
              ),
            ],
          );
        },
      );
    } else {

      await wishlistRef.add({
        'productId': product.id,
        'name': product.name,
        'price': product.price,
        'imageUrl': product.imageUrl,
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('${product.name} è stato aggiunto alla Wishlist con successo'),
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
  }