import 'dart:convert';

import 'package:cosbiome_envios/src/models/login_data_model.dart';
import 'package:cosbiome_envios/src/models/pedido_cosbiome_model.dart';
import 'package:cosbiome_envios/src/utils/http_utils.dart';
import 'package:cosbiome_envios/src/utils/preferences_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PedidosService extends ChangeNotifier {
  List<PedidoCosbiomeModel> _pedidos = [];
  PedidoCosbiomeModel _pedido = PedidoCosbiomeModel();
  List<bool> _productosSeleccionados = [];
  FormData? _formData;
  String _noGuia = '';
  bool _isLoading = false;

  List<PedidoCosbiomeModel> get pedidos => _pedidos;
  PedidoCosbiomeModel get pedido => _pedido;
  List<bool> get productosSeleccionados => _productosSeleccionados;
  FormData? get formData => _formData;
  String get noGuia => _noGuia;
  bool get isLoading => _isLoading;

  void updatePedidos(List<PedidoCosbiomeModel> value) {
    _pedidos = value;
    notifyListeners();
  }

  void updatePedido(PedidoCosbiomeModel value) {
    _pedido = value;

    _productosSeleccionados = List.generate(
      _pedido.productosCompra!.length,
      (index) => false,
    );

    notifyListeners();
  }

  void updateProductosSeleccionados(List<bool> value) {
    _productosSeleccionados = value;
    notifyListeners();
  }

  void updateProductoSeleccionado(int index, bool value) {
    _productosSeleccionados[index] = value;
    notifyListeners();
  }

  void updateFormData(FormData value) {
    _formData = value;
    notifyListeners();
  }

  void updateNoGuia(String value) {
    _noGuia = value;
    notifyListeners();
  }

  void updateIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<List<PedidoCosbiomeModel>> handleGetPedidos() async {
    // try {
    final pedidosDB = await Http.get("cosbiomepedidos", {
      "_limit": 100000.toString(),
      "ENVIO": "ENVIOMAQUINA",
      "_sort": "nombreCliente%3AASC",
    });

    List<PedidoCosbiomeModel> pedidosData =
        pedidosDB.data.map<PedidoCosbiomeModel>((e) {
      return PedidoCosbiomeModel.fromJson(e);
    }).toList();

    return pedidosData;
    // } catch (e) {
    //   print(e);
    //   return [];
    // }
  }

  Future<bool> handleConfirmPedido() async {
    try {
      updateIsLoading(true);

      LoginDataModelUser user = LoginDataModelUser.fromJson(
        jsonDecode(
          PreferencesUtils.getString('user'),
        ),
      );

      await Http.update(
        'cosbiomepedidos/${pedido.id}',
        jsonEncode({
          "ENVIO": "ENTREGADO",
          "estatus": "ENTREGADO",
          "de": user.username,
          "idFirebase": await Http.uploadFileToS3(formData!),
          "a": noGuia,
        }),
      );

      updateIsLoading(false);
      _formData = null;

      notifyListeners();

      return true;
    } catch (e) {
      updateIsLoading(false);

      return false;
    }
  }
}
