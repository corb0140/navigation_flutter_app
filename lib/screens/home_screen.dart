import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        children: <Widget>[
          const Expanded(
              // flex: 1,
              child: Image(
                  image: AssetImage('assets/Nissan GT-R50.jpg'),
                  fit: BoxFit.cover)),
          Expanded(
              // flex: 1,
              child: Container(
                  color: Colors.red,
                  child: Center(
                      child: Transform.rotate(
                          angle: -45 * 3.14159 / 180,
                          child: Text(
                            'Mark Corbin'.toUpperCase(),
                            style: textTheme.headlineLarge
                                ?.copyWith(color: colorScheme.primary),
                          ))))),
        ],
      ),
    );
  }
}
