import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:MoleDetect/themes/theme.dart';
import 'package:MoleDetect/views/home_view.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const OneSkin());
  FlutterNativeSplash.remove();
}

class MoleDetect extends StatelessWidget {
  const MoleDetect({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialTheme theme = const MaterialTheme(
        TextTheme(displayMedium: TextStyle(fontFamily: 'Manrope')));
    return MaterialApp(
      title: 'MoleDetect',
      debugShowCheckedModeBanner: false,
      theme: theme.dark(),
      initialRoute: '/',
      home: const HomeView(),
    );
  }
}
