import 'package:cosbiome_envios/src/services/pedidos_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pedidosProvider = ChangeNotifierProvider<PedidosService>(
  (ref) => PedidosService(),
);
