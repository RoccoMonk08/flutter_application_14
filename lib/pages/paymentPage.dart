import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_14/pages/paymentSuccessPage.dart';

class PaymentPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  PaymentPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Numero carta'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci il numero della carta';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Data di scadenza (MM/AA)'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci la data di scadenza';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'CVV'),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci il CVV';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  const PaymentSuccessPage()),
                    );
                  }
                },
                child: const Text('Paga', style: TextStyle(color: const Color.fromARGB(255, 35, 47, 62)),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



  Future<void> clearCart() async {
    final cartRef = FirebaseFirestore.instance.collection('cart');

    final querySnapshot = await cartRef.get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }
