import 'package:flutter/material.dart';
import 'donor_page.dart'; 

class DonateBloodPage extends StatelessWidget {
  const DonateBloodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate Blood'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Donate Blood and Save Lives',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'To donate blood, follow these steps:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              '1. Ensure you are in good health and have not donated blood recently.\n'
              '2. Visit a local blood bank or donation center.\n'
              '3. Go through the screening process.\n'
              '4. Once approved, donate your blood!\n'
              '5. After donation, rest and hydrate yourself.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate to Find Donors Page instead of showing a confirmation dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FindDonorsPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Donate Now'),
            ),
          ],
        ),
      ),
    );
  }
}
