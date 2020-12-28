import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
      ),
      body: Column(
        children: [
          Card(
            color: Colors.blue,
            child: Container(width: double.infinity, child: Text('CHART!')),
            elevation: 5,
          ),
          Card(
            child: Text('LIST OF TX!'),
          )
        ],
      ),
    ));
  }
}
