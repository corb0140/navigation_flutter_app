import 'dart:convert';
import 'dart:io';
import 'api_key.dart';
// import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DataScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Data>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No movies found.');
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data![index].name),
                  ),
                );
              },
            );
          }),
    );
  }

  Future<List<Data>> fetchData() async {
    var response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=0c97bbce4648e9fb783091167f7ee438'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      final results = jsonResponse['results'] as List<dynamic>;
      return results.map((dynamic data) => Data.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data from the internet');
    }
  }
}

class Data {
  final String name;

  Data({required this.name});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['original_title'] ?? 'Unknown title',
    );
  }
}
