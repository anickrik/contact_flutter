import 'package:flutter/material.dart';

import 'package:contacts_demo/utils/routes/routes_name.dart';
import 'package:contacts_demo/res/theme.dart';
import 'package:contacts_demo/utils/routes/routes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      initialRoute: RouteName.home,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
