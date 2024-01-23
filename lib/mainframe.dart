import 'package:database_apk/dbHelper.dart';
import 'package:database_apk/details.dart';
import 'package:flutter/material.dart';
import 'Insert_ui.dart';
import 'update.dart';
import 'delete.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Handle 'Insert' button click
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InsertUi()),
                );
              },
              child: const Text('Insert'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle 'Details' button click
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Details()),
                );
              },
              child: const Text('ListView'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Handle 'Update' button click
                final List<Map<String, dynamic>> items = await DatabaseHelper.instance.getAllData();

                if (items.isNotEmpty) {
                  final Map<String, dynamic> itemToUpdate = items.first;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdateScreen(item: itemToUpdate)),
                  ).then((value) {
                    // Handle any actions after returning from UpdateScreen
                    if (value == true) {
                      // Handle the case where data has been updated
                      // For example, you might want to refresh the list
                    }
                  });
                }
              },
              child: const Text('Update'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Handle 'Delete' button click
                // Get the item to delete (for example, the first item in the list)
                final List<Map<String, dynamic>> items = await DatabaseHelper.instance.getAllData();

                if (items.isNotEmpty) {
                  final Map<String, dynamic> itemToDelete = items.first;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeleteScreen(item: itemToDelete)),
                  ).then((value) {
                    // Handle any actions after returning from DeleteScreen
                    if (value == true) {
                      // Handle the case where data has been deleted
                      // For example, you might want to refresh the list
                    }
                  });
                }
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
