import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.suggestion});

  final Map<String, String> suggestion;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Product Page")),
    );
  }
}
