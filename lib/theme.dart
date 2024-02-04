import "package:flutter/material.dart";

ColorScheme lightColorScheme = ColorScheme(

  brightness: Brightness.light,
  primary: Colors.black, // Background color
  onPrimary: Colors.black, // Text color
  //primaryVariant: Colors.grey[300], // Lighter grey for variations
  secondary: Colors.grey.shade200, // Optional accent color
  onSecondary: Colors.black, // Text color on accent
  //secondaryVariant: Colors.blue[700], // Darker accent for variations
  background: Color.fromRGBO(238, 238, 238, 1), // Slightly lighter background for surfaces
  onBackground: Colors.black, // Text color on surfaces
  surface: Colors.grey, // Lighter surface color for cards, etc.
  onSurface: Colors.black, // Text color on surfaces
  error: Colors.red, // Error color
  onError: Colors.white, // Text color on error
);

ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color.fromRGBO(28,27,32,0), // Background color
  onPrimary: Colors.grey, // Text color
  //primaryVariant: Colors.grey.shade800, // Slightly lighter grey for variations
  secondary: Color.fromRGBO(37, 36, 42, 1),//Color.fromRGBO(44, 42, 50, 1), // Optional accent color
  onSecondary: Colors.white, // Text color on accent
  //secondaryVariant: Colors.blue.shade700, // Darker accent for variations
  background: Color.fromRGBO(30, 29, 35, 1),
  onBackground: Colors.grey.shade400, // Lighter text color on surfaces
  surface: Color.fromRGBO(30, 29, 35, 1), // Same as background for consistency
  onSurface: Colors.grey.shade200, // Text color on surfaces
  error: Colors.red, // Error color
  onError: Colors.white,


   // Text color on error
);

ThemeData lightTheme() {
  return ThemeData(
    colorScheme: lightColorScheme,
    brightness: Brightness.light,
    primarySwatch: null,
    secondaryHeaderColor: Colors.grey.shade300,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      activeIndicatorBorder: BorderSide(color: Colors.grey),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color.fromARGB(255, 66, 66, 66)),borderRadius: BorderRadius.circular(20)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    ),
    //scaffoldBackgroundColor: Color.fromARGB(255, 214, 214, 214),
    iconTheme:
        const IconThemeData(color: const Color.fromARGB(255, 28, 27, 27)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.black,
        primary: Colors.black,
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 28, 27, 27),
        surfaceTintColor: Colors.black,
      ),
    ),
    
    appBarTheme: AppBarTheme(
      color: Colors.grey.shade200,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color.fromARGB(255, 33, 33, 33)),
    ),
    textSelectionTheme: TextSelectionThemeData(selectionColor: Color.fromARGB(255, 129, 135, 169)),
    

  );
}

ThemeData darkTheme() {
  return ThemeData(
      primarySwatch: null,
      colorScheme: darkColorScheme,
      brightness: Brightness.dark,
      //textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.grey)),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(20)),
          floatingLabelStyle: TextStyle(color: Colors.grey.shade300),
          labelStyle: TextStyle(color: Colors.grey.shade200),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200),borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(20)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
      secondaryHeaderColor: Colors.grey,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(shadowColor: Colors.black,
          backgroundColor: Color.fromRGBO(49, 48, 56, 0),
          //textStyle: TextStyle(color: Colors.grey.shade200)
          )),
      textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.grey.shade300,selectionColor: Color.fromARGB(255, 50, 49, 81)),
      expansionTileTheme: ExpansionTileThemeData(collapsedIconColor: Colors.white,iconColor: Colors.white, )
      
          );

}
