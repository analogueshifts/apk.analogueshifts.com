import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:flutter/material.dart';

class SingleJobScreen extends StatefulWidget {
  const SingleJobScreen({super.key});

  @override
  State<SingleJobScreen> createState() => _SingleJobScreenState();
}

class _SingleJobScreenState extends State<SingleJobScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaylonyAppBarTwo(title: ""),
    );
  }
}