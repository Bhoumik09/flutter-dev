import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/cart_provider.dart';
import 'package:shop_flutter/global_varibles.dart';
import 'package:shop_flutter/home_page.dart';
import 'package:shop_flutter/product_detail_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  await Supabase.initialize(
    url: 'https://bzhyqsojlpnmtuxabmfe.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ6aHlxc29qbHBubXR1eGFibWZlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTgzNzE3OTksImV4cCI6MjAzMzk0Nzc5OX0.jD-pH4PBa_r3MP3LqU06126a82euLr9AU7thf1j4Ax4',
  );
  runApp(const MyApp());
}
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  ///Provider -> Read only value 
  ///chnage notifier provider -> chnage the value and notify the widget listening to it 
  ///future provider 
  ///Stream notifier provider 
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // the thing we return hee would be availabe to all the widegot 
      create: (context)=>CartProvider(),
      child: MaterialApp(
        title: "shopping mall app",
        debugShowCheckedModeBanner: false,
        home:  const LoginScreen(),
        theme: ThemeData(
            useMaterial3: true,
            inputDecorationTheme: const InputDecorationTheme(
              prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            appBarTheme:const AppBarTheme(titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            textTheme: const TextTheme(
              
                titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                bodySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
      ),
    );
  }
}
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    _setupAuthListener();
    super.initState();
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    });
  }
Future<AuthResponse> _googleSignIn() async {
    /// TODO: update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    const webClientId = '762059499647-a360nq583n6ethbvpd32m643qpp5egnb.apps.googleusercontent.com';

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId = 'my-ios.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _googleSignIn,
          child: const Text('Google login'),
        ),
      ),
    );
  }
}

