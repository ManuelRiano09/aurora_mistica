import 'package:aurora_candle/firebase_options.dart';
import 'package:aurora_candle/presentation/providers/candle_template_provider.dart';
import 'package:aurora_candle/presentation/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CandleTemplateProvider(),)
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: const Color.fromARGB(255, 180, 17, 205)
        ),
        home: MainScreen()
      ),
    );
  }

}