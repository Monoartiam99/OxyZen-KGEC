import 'package:flutter/material.dart';
import 'screens/doctor_dashboard_screen.dart';

void main() => runApp(const DashboardDemoApp());

class DashboardDemoApp extends StatelessWidget {
  const DashboardDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Dashboard Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const DoctorDashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
