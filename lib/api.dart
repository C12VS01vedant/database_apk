import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Api extends StatefulWidget {
  const Api({super.key});

  @override
  _ApipageState createState() => _ApipageState();
}

class _ApipageState extends State<Api> {
  final String apiUrl = 'https://65af54122f26c3f2139a7694.mockapi.io';

  bool isApiConnected = false;

  @override
  void initState() {
    super.initState();
    checkApiConnection();
  }

  Future<void> checkApiConnection() async {
    try {
      final http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          isApiConnected = true;
        });
      } else {
        setState(() {
          isApiConnected = false;
        });
      }
    } catch (e) {
      setState(() {
        isApiConnected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Connection Checker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isApiConnected ? Icons.check_circle : Icons.error,
              color: isApiConnected ? Colors.green : Colors.red,
              size: 80,
            ),
            const SizedBox(height: 20),
            Text(
              isApiConnected ? 'API Connected' : 'API Not Connected',
              style: TextStyle(
                fontSize: 18,
                color: isApiConnected ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
