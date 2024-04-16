import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/post_provider.dart';

import 'HomePage/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PostProvider())],
      child: MaterialApp(
      
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
      
        ),
        
        home: const HomePage(),
      
      ),
    );
  }
}
