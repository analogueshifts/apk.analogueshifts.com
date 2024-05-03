import 'package:flutter/material.dart';

class VettingSystemScreen extends StatefulWidget {
  const VettingSystemScreen({super.key});

  @override
  State<VettingSystemScreen> createState() => _VettingSystemScreenState();
}

class _VettingSystemScreenState extends State<VettingSystemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Table(
          border: TableBorder.all(color: Colors.black),
          children: [
            TableRow(children: [
              Text('Cell 1'),
              Text('Cell 2'),
              Text('Cell 3'),
            ]),
            TableRow(children: [
              Text('Cell 4'),
              Text('Cell 5'),
              Text('Cell 6'),
            ])
          ],
        ),
      ),
    );
  }
}