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
                decoration: InputDecoration(
                    labelText: 'What do people call you?',
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.green,
                    ))),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _data.name = value ?? '';
                }),
            const SizedBox(height: 116.0),
            TextFormField(
                decoration: InputDecoration(
                    labelText: 'What email can we reach you at?',
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.green,
                    ))),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null; //means no error
                },
                onSaved: (String? value) {
                  _data.email = value ?? '';
                }),
            const SizedBox(height: 116.0),
            TextFormField(
                decoration: InputDecoration(
                    labelText: 'Request Message',
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.green,
                    ))),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _data.message = value ?? '';
                }),
            const SizedBox(height: 56.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(250, 40),
                  backgroundColor: Colors.red),
              onPressed: () {
                if (_formStateKey.currentState?.validate() ?? false) {
                  _formStateKey.currentState?.save();
                  print('Name: ${_data.name}');
                  print('Email: ${_data.email}');
                  print('Message: ${_data.message}');
                } else {
                  print("Form is invalid");
                }
              },
              child: Text('Submit'.toUpperCase(),
                  style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.tertiary,
                      fontWeight: FontWeight.bold)),
            ),
          ])),
    )));
  }
}

class MyData {
  String name = "";
  String email = "";
  String message = "";
}
