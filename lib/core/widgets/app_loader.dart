import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final Color? color;
  const AppLoader({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: color));
  }
}
