import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gym/user_session.dart';
import 'package:provider/provider.dart';
import 'Pages/training_manager.dart';
import 'Pages/main_nav_page.dart';
import 'Pages/login_page.dart';


const MaterialColor gymlionGold = MaterialColor(
  0xFFC7A868,
  <int, Color>{
    50: Color(0xFFFFFBE6), 
    100: Color(0xFFFFF0B3),
    200: Color(0xFFFFE080),
    300: Color(0xFFFDD04D),
    400: Color(0xFFC7A868), 
    500: Color(0xFFB0945E),
    600: Color(0xFFA18552),
    700: Color(0xFF8F7346),
    800: Color(0xFF7D613A),
    900: Color(0xFF6B4F2E),
  },
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final bool isLoggedIn = await SessionManager.loadSession();

  runApp(MyApp(isLoggedIn: isLoggedIn)); 
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn; 
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TrainingManager>(
      create: (context) => TrainingManager(),
      
      child: MaterialApp(
        title: 'GYMLION',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: gymlionGold,
          primaryColor: const Color(0xFFC7A868),
          scaffoldBackgroundColor: Colors.black, 
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFFC7A868),
            secondary: Color(0xFFC7A868),
            surface: Colors.black,
          ),
          useMaterial3: true,
        ), 
        home: isLoggedIn ? const MainNavPage() : const LoginPage(), 
      ),
    );
  }
}