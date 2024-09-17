// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_14/main.dart';
import 'package:flutter_application_14/pages/paymentPage.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento riuscito'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 100),
              const SizedBox(height: 20),
               Text(
                'Il pagamento è stato effettuato con successo!',
                style: TextStyle(
                  fontSize: 15,
                  ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await clearCart();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp()), 
                  );
                },
                child: const Text("Torna allo Shop"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}