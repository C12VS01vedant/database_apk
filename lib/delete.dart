import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShowDataPage3 extends StatefulWidget {
  const ShowDataPage3({Key? key}) : super(key: key);

  @override
  _ShowDataPageState createState() => _ShowDataPageState();
}

class _ShowDataPageState extends State<ShowDataPage3> {
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

  Future<void> deleteRecord(String itemId) async {
    try {
      final http.Response response = await http.delete(
        Uri.parse('$apiUrl/$itemId'),
        headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Record deleted successfully');
        // Refresh the list after deletion
        fetchData();
      } else {
        print('Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Data'),
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
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Trigger the delete functionality
                          deleteRecord(data['id']);
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
