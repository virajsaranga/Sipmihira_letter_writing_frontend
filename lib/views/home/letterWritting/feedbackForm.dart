import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResponsePage extends StatefulWidget {
   final String responseData; // Define responseData here

  ResponsePage({required this.responseData});
  @override
  _ResponsePageState createState() => _ResponsePageState();
}

class _ResponsePageState extends State<ResponsePage> {
  String responseData = ''; // Store the response data here

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the page loads
  }

 Future<void> fetchData() async {
  try {
    final Uri url = Uri.parse('http://192.168.101.88:8000/submit-char/'); // Convert the URL string to a Uri object
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final parsedData = json.decode(response.body);
      setState(() {
        // Access individual values from the parsed JSON and assign them to String variables
        String noOfObjects = parsedData['No.of Objects'];
        String status = parsedData['Status'];
        String shape = parsedData['Shape'];
        String understanding = parsedData['Understanding'];
        String clarity = parsedData['Clarity'];

        // Now, you have these values as String variables
        // You can use them as needed
      });
    } else {
      // Handle errors
      print('Failed to fetch data from the backend');
    }
  } catch (e) {
    // Handle exceptions
    print('Error: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Response Page'),
      ),
      body: Center(
        child: Text(responseData), // Display the response data here
      ),
    );
  }
}
