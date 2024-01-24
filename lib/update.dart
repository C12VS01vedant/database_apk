import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class ShowDataPage2 extends StatefulWidget {
  const ShowDataPage2({Key? key}) : super(key: key);

  @override
  _ShowDataPageState createState() => _ShowDataPageState();
}

class _ShowDataPageState extends State<ShowDataPage2> {
  final String apiUrl = 'https://65af54122f26c3f2139a7694.mockapi.io/Insert';

  List<Map<String, dynamic>> apiData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          apiData = List<Map<String, dynamic>>.from(responseData);
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: apiData.isNotEmpty
            ? ListView.builder(
                itemCount: apiData.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> data = apiData[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text('Name: ${data['name']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text('Date of Birth: ${data['dob']}'),
                          const SizedBox(height: 8),
                          Text('Address: ${data['address']}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Navigate to UpdateDataPage with the user ID
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateDataPage(itemId: data['id']),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text('No data available'),
              ),
      ),
    );
  }
}

class UpdateDataPage extends StatefulWidget {
  final String itemId;

  const UpdateDataPage({Key? key, required this.itemId}) : super(key: key);

  @override
  _UpdateDataPageState createState() => _UpdateDataPageState();
}

class _UpdateDataPageState extends State<UpdateDataPage> {
  final String apiUrl = 'https://65af54122f26c3f2139a7694.mockapi.io/Insert';

  late TextEditingController nameController;
  late DateTime selectedDate;
  late TextEditingController dobController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    dobController = TextEditingController();
    addressController = TextEditingController(); // Initialize the controller here
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final http.Response response = await http.get(Uri.parse('$apiUrl/${widget.itemId}'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        setState(() {
          nameController.text = responseData['name'];
          selectedDate = DateTime.parse(responseData['dob']);
          dobController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
          addressController.text = responseData['address'];
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  Future<void> updateData() async {
    final Map<String, dynamic> data = {
      'name': nameController.text,
      'dob': DateFormat('yyyy-MM-dd').format(selectedDate),
      'address': addressController.text,
    };

    try {
      final http.Response response = await http.put(
        Uri.parse('$apiUrl/${widget.itemId}'),
        body: jsonEncode(data),
        headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Data updated successfully');
        // Additional logic or navigation after successful update
      } else {
        print('Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dobController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Data'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  icon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: dobController,
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                      icon: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  icon: Icon(Icons.location_on),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Submit Button Pressed
                  updateData();
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}