import 'package:flutter/material.dart';
import 'api.dart';
import 'insert.dart';
import 'show.dart';
import 'update.dart';
import 'delete.dart';

class MyHomePage extends StatelessWidget {
  final String apiUrl = 'https://65af54122f26c3f2139a7694.mockapi.io';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Operations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Insert
                print('Insert button pressed');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreatePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text('Insert'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Show
                print('Show button pressed');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShowDataPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.list),
                  SizedBox(width: 8),
                  Text('Show'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Update
                print('Update button pressed');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShowDataPage2()),
                );
              
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.update),
                  SizedBox(width: 8),
                  Text('Update'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Delete
                print('Delete button pressed');
                // Add your delete functionality here
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShowDataPage3()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 8),
                  Text('Delete'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // API Status
                print('API Status button pressed');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Api()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud),
                  SizedBox(width: 8),
                  Text('API Status'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
