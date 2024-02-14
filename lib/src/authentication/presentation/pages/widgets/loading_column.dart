import 'package:flutter/material.dart';

class LoadingColumn extends StatelessWidget {
  final String message;

  const LoadingColumn({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 10.0, width: double.infinity),
        Text('$message...'),
      ],
    );
  }
}
