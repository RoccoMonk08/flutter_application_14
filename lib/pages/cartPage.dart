// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_14/pages/paymentPage.dart';

class CartPage extends StatelessWidget {
   const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrello"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("cart").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final cartItems = snapshot.data!.docs;
          double totalAmount = 0;

          for (var item in cartItems) {
            totalAmount += (item['price'] as double) * (item['quantity'] ?? 1);
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Totale: \$${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(item['name']),
                        subtitle: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, size: 25, ),
                              onPressed: () {
                                updateQuantity(item.id, -1);
                              },
                            ),
                            Text('Quantità: ${item['quantity'] ?? 1}'),
                            IconButton(
                              icon: Icon(Icons.add, size: 25, ),
                              onPressed: () {
                                updateQuantity(item.id, 1);
                              },
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('\$${item['price']}'),
                            IconButton(
                              icon: Icon(Icons.delete, color: const Color.fromARGB(255, 35, 47, 62)),
                              onPressed: () async {
                                try {
                                  await FirebaseFirestore.instance
                                      .collection('cart')
                                      .doc(item.id)
                                      .delete();
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Errore durante l\'eliminazione'),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentPage()),
          );
        },
        label: Text(
          'Vai al pagamento',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.payment,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 35, 47, 62),
      ),
    );
  }

  Future<void> updateQuantity(String itemId, int change) async {
    final cartRef = FirebaseFirestore.instance.collection('cart').doc(itemId);

    try {
      final doc = await cartRef.get();
      final currentQuantity = doc.data()?['quantity'] ?? 1;
      final newQuantity = currentQuantity + change;

      if (newQuantity <= 0) {
        await cartRef.delete();
      } else {
        await cartRef.update({'quantity': newQuantity});
      }
    } catch (e) {
      print("Errore durante l'aggiornamento della quantità: $e");
    }
  }
}
