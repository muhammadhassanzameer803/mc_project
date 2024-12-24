import 'package:flutter/material.dart';
import 'find_donors_page.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: const Text(
          'Requests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 228, 228),
      body: requests.isEmpty
          ? const Center(
              child: Text(
                'No Requests Found!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      'Blood Group: ${request.bloodGroup}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(
                      'Relation: ${request.relation}\n'
                      'Gender: ${request.gender}\n'
                      'Age: ${request.age}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Accept Button
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () {
                            _showDialog(
                              context,
                              'Request Approved',
                              'Your request has been approved!',
                              const RequestPage(),
                            );
                          },
                        ),
                        // Decline Button
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            _showDialog(
                              context,
                              'Request Declined',
                              'Your request has been declined. Please send another request.',
                              const RequestPage(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showDialog(BuildContext context, String title, String message, Widget nextPage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => nextPage),
                ); // Navigate back to the RequestPage
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
