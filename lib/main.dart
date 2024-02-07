import 'package:chat_app/ChatProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "index.dart";
import "package:lottie/lottie.dart";
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> _initDatabase() async {
  await Hive.initFlutter();
  var mybox = await Hive.openBox('Convo');
  await Hive.openBox("instruction");
  await Hive.openBox("userInfo");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Display custom splash screen
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ChangeNotifierProvider(create: (_) => ThemeIconProvider()),
    ChangeNotifierProvider(create: (_) => ChatProvider()),
  ], child: LoadingScreen()));
  // Delay to simulate initialization tasks
  await Future.delayed(Duration(seconds: 5));

  // Remove native splash screen (if using a package)
  FlutterNativeSplash.remove();

  // Run initialization tasks concurrently
  await _initDatabase();

  // Navigate to main app after completion

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => ThemeIconProvider()),
      ChangeNotifierProvider(create: (_) => ChatProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SigninPage.routeName: (context) => SigninPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Chat Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: FutureBuilder(
        future: Account().testToken(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text("Error fetching data: ${snapshot.error}"));
          }

          if (snapshot.hasData) {
            return snapshot.data == "User Authenticated"
                ? HomePage()
                : SigninPage();
          } else {
            return LoadingScreen();
          }
        },
      ),
    );
  }
}

// LoadingScreen widget
class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat Demo',
        theme: Provider.of<ThemeProvider>(context).themeData,
        home: Scaffold(
          body: Center(
            child: Lottie.asset("assets/chat.json",
                height: 100,
                animate: true), // Or your preferred loading indicator
          ),
        ));
  }
}
