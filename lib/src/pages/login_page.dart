import 'package:cosbiome_envios/src/providers/login_provider.dart';
import 'package:cosbiome_envios/src/services/login_service.dart';
import 'package:cosbiome_envios/src/utils/preferences_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final isLogin = PreferencesUtils.getBool('isLogged');

      if (isLogin) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final login = ref.watch(loginProvider);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.background,
                Theme.of(context).colorScheme.primary,
              ],
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SafeArea(
                          child: Column(
                            children: const [
                              SizedBox(height: 16),
                              Text(
                                'BIENVENIDO A COSBIOME',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Inicia sesion',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          // height: size.height * 0.5,
                          width: size.width,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 20.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 3.0,
                                offset: Offset(
                                  0.0,
                                  5.0,
                                ),
                                spreadRadius: 3.0,
                              )
                            ],
                          ),
                          child: _createFormLogin(
                            context,
                            size,
                            login,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Form _createFormLogin(
    BuildContext context,
    Size size,
    LoginService login,
  ) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Ingresa tu usuario';
              }
              return null;
            },
            onChanged: (value) => {
              login.updateEmail(value),
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36.0),
              ),
              hintText: 'Usuario',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Ingresa tu contraseña';
              }
              return null;
            },
            onChanged: (value) => {
              login.updatePassword(value),
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36.0),
              ),
              hintText: 'Contraseña',
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36.0),
              ),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await login.handleLogin(context);
              }
            },
            child: const Text(
              'Iniciar sesión',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
