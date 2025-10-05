/*Purpose: the app bootstrap — NearMeApp StatelessWidget that returns MaterialApp with global theme, title, routes/home. Keep this file minimal; it wires top-level settings and the initial screen.
Recommended content to keep here: theme, route registration, localization delegates. Move screens, widgets, services to separate files.*/
import 'package:flutter/material.dart';//Flutter UI framework: provides core components for building UIs.
import 'screens/home_screen.dart';// Home screen widget.

//Root widget of the application.
class NearMeApp extends StatelessWidget {//Stateless widget as the app's main structure doesn't change dynamically.
  const NearMeApp({super.key});//Constructor with optional key parameter.

  @override
  Widget build(BuildContext context) {//Build method to describe the part of the UI represented by this widget.
    return MaterialApp(//MaterialApp widget provides material design structure.
      title: 'Unlock Local Wonders with AI',//App title.
      theme: ThemeData(//Theme configuration.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const HomeScreen(),//Home screen of the app.
      debugShowCheckedModeBanner: false,//Disables the debug banner in the app UI.
    );
  }
}
