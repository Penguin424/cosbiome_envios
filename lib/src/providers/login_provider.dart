import 'package:cosbiome_envios/src/services/login_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = ChangeNotifierProvider<LoginService>(
  (ref) => LoginService(),
);
