import 'package:amazon_self/common/botton_navigation_bar.dart';
import 'package:amazon_self/constants/global_variables.dart';
import 'package:amazon_self/features/admin/screens/admin_screen.dart';
import 'package:amazon_self/features/auth/screen/auth_screen.dart';
import 'package:amazon_self/features/auth/screen/auth_service.dart';
import 'package:amazon_self/features/home_screens/screen/screens/home_screen.dart';
import 'package:amazon_self/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          
            colorScheme: const ColorScheme.light(
                primary: GlobalVariables.secondaryColor),
            scaffoldBackgroundColor: GlobalVariables.greyBackgroundCOlor,
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalVariables.secondaryColor,
                    foregroundColor: GlobalVariables.backgroundColor))),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? Provider.of<UserProvider>(context).user.type=='user'? const BottonNavigationBar()
            :const AdminScreen(): const AuthScreen());
  }
}
