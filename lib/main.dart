import 'package:flutter/material.dart';


import 'src/core/routes/routes.dart';
import 'src/features/home/presentation/screens/screens.dart';

void main() {


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

       return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: HomeScreen.routeName,
          onGenerateRoute: AppRouter.onGenerateRoute,
          title: 'ddd v1 app template',
          // theme: ThemeData(
          //   primarySwatch: Colors.blue,
          //   primaryColorDark: Colors.blue.shade900,
          //   primaryColorLight: Colors.blue.shade50,
          // ),
          home: const HomeScreen(),
        );
  }
}


