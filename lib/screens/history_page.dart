import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Simulated history data
  final List<Map<String, String>> donatedHistory = [];
  final List<Map<String, String>> receivedHistory = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('History'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Donated'),
              Tab(text: 'Received'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildHistoryList(donatedHistory, isDonated: true),
            _buildHistoryList(receivedHistory, isDonated: false),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList(List<Map<String, String>> history, {required bool isDonated}) {
    if (history.isEmpty) {
      return const Center(child: Text('No history available.'));
    }
    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        final item = history[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            title: Text('Date: ${item['date']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location: ${item['location']}'),
                Text('${isDonated ? 'Receiver' : 'Donor'} ID: ${item['id']}'),
                Text('Quantity: ${item['quantity']}'),
              ],
            ),
            trailing: isDonated
                ? null
                : TextButton(
                    onPressed: () {
                      _viewDetails(item);
                    },
                    child: const Text(
                      'View Details',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
          ),
        );
      },
    );
  }

  void _viewDetails(Map<String, String> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Details'),
        content: Text(
          'ID: ${item['id']}\nQuantity: ${item['quantity']}\nDate: ${item['date']}\nLocation: ${item['location']}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Function to add history items
  void addHistoryItem({
    required bool isDonated,
    required String id,
    required String quantity,
    required String date,
    required String location,
  }) {
    final historyItem = {
      'id': id,
      'quantity': quantity,
      'date': date,
      'location': location,
    };
    setState(() {
      if (isDonated) {
        donatedHistory.add(historyItem);
      } else {
        receivedHistory.add(historyItem);
      }
    });
  }
}
