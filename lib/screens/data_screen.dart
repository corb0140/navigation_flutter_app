import 'dart:convert';
import 'dart:io';
import 'api_key.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data![index].name,
                          style: textTheme.headlineMedium
                              ?.copyWith(color: colorScheme.secondary),
                        ),
                        const SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Popularity: ${snapshot.data![index].popularity.toStringAsFixed(1)}',
                                style: textTheme.bodyMedium,
                              ),
                              Text(
                                  'Release Date: ${snapshot.data![index].releaseDate}',
                                  style: textTheme.bodyMedium),
                            ])
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }

  Future<List<Data>> fetchData() async {
    var response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=$tmdbApiKey'));

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
  final double popularity;
  final String releaseDate;

  Data(
      {required this.name,
      required this.popularity,
      required this.releaseDate});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['original_title'] ?? 'Unknown title',
      popularity: json['popularity'] ?? 0.0,
      releaseDate: json['release_date'] ?? 'Unknown date',
    );
  }
}
