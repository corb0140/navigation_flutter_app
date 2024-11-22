import 'package:flutter/material.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ContactsScreen> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

  final MyData _data = MyData();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        body: SafeArea(
            child: Form(
      key: _formStateKey,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            Text(
              "Want something? Tell us!",
              style: textTheme.headlineLarge
                  ?.copyWith(color: colorScheme.secondary),
            ),
            TextFormField(
                decoration: const InputDecoration(
                  labelText: 'What do people call you?',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null; //means no error
                },
                onSaved: (String? value) {
                  _data.name = value ?? '';
                }),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'What email can we reach you at?',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Request Message',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Validate the form
              },
              child: Text('Submit',
                  style: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.tertiary)),
            ),
          ])),
    )));
  }
}

class MyData {
  //this is like a plain Object in JS to hold properties
  String name = "";
  String email = "";
  String message = "";
}
