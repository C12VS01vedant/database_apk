import 'package:flutter/material.dart';
import 'dbHelper.dart';

class DeleteScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const DeleteScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  late TextEditingController _nameController;
  late TextEditingController _dobController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item['name']);
    _dobController = TextEditingController(
        text: DateTime.parse(widget.item['dob']).toLocal().toString());
    _addressController = TextEditingController(text: widget.item['address']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              // Perform the delete logic here
              await DatabaseHelper.instance.deleteData(widget.item['id']);

              // Notify the parent screen that data has been deleted
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${widget.item['name']}'),
            Text('Date of Birth: ${widget.item['dob']}'),
            Text('Address: ${widget.item['address']}'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // You can add additional actions here if needed
                // For example, navigate back when the delete button is pressed
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
