import 'package:cosbiome_envios/src/pages/detail_pedido_page.dart';
import 'package:cosbiome_envios/src/pages/home_page.dart';
import 'package:cosbiome_envios/src/pages/login_page.dart';
import 'package:cosbiome_envios/src/utils/preferences_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesUtils.init();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0XFFBFE3ED),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0XFF4CAAB1),
          onPrimary: Colors.white,
          background: const Color(0XFFBFE3ED),
          onBackground: Colors.black,
          secondary: const Color(0XFFBFE3ED),
          onSecondary: Colors.white,
          error: Colors.black,
          onError: Colors.white,
          surface: const Color(0XFF4CAAB1),
          onSurface: Colors.black,
          brightness: Brightness.light,
        ),
      ),
      title: 'Material App',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/detalle_pedido': (context) => const DetailPedidoPage(),
      },
    );
  }
}
