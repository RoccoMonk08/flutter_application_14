// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Wishlist extends StatelessWidget {
   const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("wishlist").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final WishlistItems = snapshot.data!.docs;

          return ListView.builder(
            itemCount: WishlistItems.length,
            itemBuilder: (context, index) {
              final item = WishlistItems[index];
              return ListTile(
                title: Text(item['name']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('\$${item['price']}'),
                    IconButton(
                      icon: Icon(Icons.delete, color: const Color.fromARGB(255, 35, 47, 62)),
                      onPressed: () async {
                        try {
                          await FirebaseFirestore.instance
                              .collection('wishlist')
                              .doc(item.id)
                              .delete();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Errore durante l\'eliminazione')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
