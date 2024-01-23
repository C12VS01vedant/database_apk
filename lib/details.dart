import 'package:flutter/material.dart';
import 'dbHelper.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsCard();
}

class _DetailsCard extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body:FutureBuilder(
        future:DatabaseHelper.instance.getAllData(),
        builder:(context,snapshot) {  
          if(snapshot.connectionState == ConnectionState.waiting){
            return const CircularProgressIndicator();
          }
          else if(snapshot.hasError){
            return Text('Error: ${snapshot.error}');
          }
          else{
            final data = snapshot.data as List<Map<String,dynamic>>;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context,index){
                final item=data[index];
                return ListTile(
                  title: Text('Name: ${item['name']}'),
                  subtitle: Text('DOB: ${item['dob']}, Address: ${item['address']}'),
                );
              },
            );
          }
        }
      )
    );
  }
}