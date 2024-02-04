import 'package:chat_app/ChatProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "index.dart";
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  var mybox = await Hive.openBox('Convo');
  await Hive.openBox("instruction");
  await Hive.openBox("userInfo");
  

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
    return Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(), // Or your preferred loading indicator
      ),
    );
  }
}
