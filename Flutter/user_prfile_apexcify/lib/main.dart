import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(const ApexcifyApp());
}

class ApexcifyApp extends StatelessWidget {
  const ApexcifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ApexcifyTechnology',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0E7C86),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ),
      initialRoute: AppPages.initail,
      getPages: AppPages.routes,
    );
  }
}
