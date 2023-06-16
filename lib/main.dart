import 'package:flutter/material.dart';
import 'package:movies_app/src/features/movies/presentation/manager/movies_manager.dart';
import 'package:movies_app/src/features/movies/presentation/pages/movies_page.dart';
import 'package:movies_app/src/services/service_locator/service_locator.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesManager()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MoviesPage(),
      ),
    );
  }
}

