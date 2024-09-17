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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 20),
            const Text(
              'Il pagamento è stato effettuato con successo!',
              style: TextStyle(fontSize: 20),
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
    );
  }
}