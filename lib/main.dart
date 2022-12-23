import 'package:flutter/material.dart';

import 'Dashboard.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.black,
      ),
      textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.red)),
    ),
    home: const Dashboard(),
  ));
}