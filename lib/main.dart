import 'package:flutter/material.dart';
import 'package:taskmanager/route/app_route.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: AppRoute.initialRoute,
    routes: AppRoute.routes,
  ));
}
