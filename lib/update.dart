import 'package:flutter/material.dart';
import 'dbHelper.dart';

class Update extends StatefulWidget {
  const Update({Key? key}) : super(key: key);

  @override
  State<Update> createState() => _UpdateCard();
}

class _UpdateCard extends State<Update> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: FutureBuilder(
        future: DatabaseHelper.instance.getAllData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final data = snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(
                  title: Text('Name: ${item['name']}'),
                  subtitle: Text(
                      'DOB: ${item['dob']}, Address: ${item['address']}'),
                  onTap: () {
                    _navigateToUpdateScreen(context, item);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void _navigateToUpdateScreen(
      BuildContext context, Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateScreen(item: item),
      ),
    ).then((value) {
      // Refresh data when returning from the UpdateScreen
      if (value == true) {
        setState(() {}); // Trigger a rebuild to refresh the list
      }
    });
  }
}

class UpdateScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const UpdateScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TextEditingController _nameController;
  late TextEditingController _dobController;
  late TextEditingController _addressController;

@override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item['name']);
    _dobController = TextEditingController(
        text: DateTime.parse(widget.item['dob']).toString());
    _addressController = TextEditingController(text: widget.item['address']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Update Name:'),
            TextField(
              controller: _nameController,
            ),
            Text('Update Date of Birth:'),
            TextField(
              controller: _dobController,
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (selectedDate != null) {
                  setState(() {
                    _dobController.text =
                        selectedDate.toLocal().toString();
                  });
                }
              },
            ),
            Text('Update Address:'),
            TextField(
              controller: _addressController,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Perform the update logic here
                await DatabaseHelper.instance.updateData(
                  widget.item['id'],
                  _nameController.text,
                  DateTime.parse(_dobController.text),
                  _addressController.text,
                );

                // Notify the parent screen that data has been updated
                Navigator.pop(context, true);
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
