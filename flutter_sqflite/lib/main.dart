import 'package:flutter/material.dart';
import 'package:flutter_sqflite/screens/note_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Color mainColor = Color(0xffb74093);
    Color maincolor = Color(0xff1B434D);
    Color btncolor = Color(0xff1B434D);
    MaterialColor mainmaterial = MaterialColorGenerator.from(maincolor);

    return MaterialApp(
      title: 'NoteKeeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: mainmaterial,
        buttonTheme: ButtonThemeData(
          buttonColor: btncolor,
        ),
       
        // iconButtonTheme: IconButtonThemeData(
        //   style: ButtonStyle(
        //     //backgroundColor: Color(0xff1B434D)
           
        //   )
        // )
      
        //mainColor,
        //Color(#1B434D)
        //Colors.deepPurple
      ),
      home: NoteList(),
    );
  }
}

class MaterialColorGenerator {
  static MaterialColor from(Color color) {
    return MaterialColor(color.value, <int, Color>{
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1.0),
    });
  }
}
