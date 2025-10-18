import 'package:flutter/material.dart';

/// Widget for displaying messages (errors, empty states)
class MessageDisplay extends StatelessWidget {
  final String message;
  
  const MessageDisplay({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Text(
          message,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
