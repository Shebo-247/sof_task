import 'package:flutter/material.dart';
import 'package:sof_task/core/di/injection.dart';
import 'core/services/storage_service.dart';
import 'app.dart';

/// Main entry point of the application
void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize local storage
  await StorageService().init();

  // Initialize dependency injection
  await configureDependencies();

  // Run the app
  runApp(const MyApp());
}
