import 'package:cosbiome_envios/src/models/pedido_cosbiome_model.dart';
import 'package:cosbiome_envios/src/providers/pedidos_provider.dart';
import 'package:dio/dio.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class DetailPedidoPage extends ConsumerStatefulWidget {
  const DetailPedidoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailPedidoPageState();
}

class _DetailPedidoPageState extends ConsumerState<DetailPedidoPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final pedido =
          ModalRoute.of(context)!.settings.arguments as PedidoCosbiomeModel;
      ref.read(pedidosProvider.notifier).updatePedido(pedido);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pedido =
        ModalRoute.of(context)!.settings.arguments as PedidoCosbiomeModel;
    final size = MediaQuery.of(context).size;
    final pedidos = ref.watch(pedidosProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          'DETALLE DEL PEDIDO ${pedido.idPedido!}'.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                'PEDIDODO DE ${pedido.nombreCliente!}'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 25),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    )),
                height: size.height * 0.4,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final producto = pedido.productosCompra![index]!;
                    final check = pedidos.productosSeleccionados.isEmpty
                        ? false
                        : pedidos.productosSeleccionados[index];

                    return ListTile(
                      leading: Checkbox(
                        value: check,
                        onChanged: (value) {
                          ref
                              .read(pedidosProvider.notifier)
                              .updateProductoSeleccionado(index, value!);
                        },
                      ),
                      title: Text(
                        producto.producto!,
                      ),
                      subtitle: Text(producto.cantidad!),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: pedido.productosCompra!.length,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Guia de envio',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  ref.read(pedidosProvider.notifier).updateNoGuia(value);
                },
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.camera,
                  );

                  if (image != null) {
                    FormData formData = FormData.fromMap(
                      {
                        'key':
                            'envios/pedidos/${pedido.idPedido}/evidencia_entrega_${DateTime.now().toLocal().toIso8601String()}.jpg',
                        'file': MultipartFile.fromBytes(
                          await image.readAsBytes(),
                        ),
                      },
                    );

                    pedidos.updateFormData(formData);
                  }
                },
                icon: const Icon(Icons.photo_camera),
                label: const Text('Agregar evidencia de entrega'),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              ElevatedButton(
                onPressed: pedidos.isLoading
                    ? null
                    : ([mounted = true]) async {
                        if (!pedidos.productosSeleccionados.every(
                          (element) => element,
                        )) {
                          return ElegantNotification.error(
                            title: const Text("Error"),
                            description: const Text(
                              "POR FAVOR SELECCIONE TODOS LOS PRODUCTOS",
                            ),
                          ).show(
                            context,
                          );
                        }

                        if (pedidos.formData == null) {
                          return ElegantNotification.error(
                            title: const Text("Error"),
                            description: const Text(
                              "POR FAVOR AGREGUE UNA FOTO DE LA ENTREGA",
                            ),
                          ).show(
                            context,
                          );
                        }

                        final confirm = await pedidos.handleConfirmPedido();

                        if (!mounted) return;

                        if (confirm) {
                          ElegantNotification.success(
                            title: const Text("Exito"),
                            description: const Text(
                              "PEDIDO ENVIADO CORRECTAMENTE",
                            ),
                          ).show(
                            context,
                          );

                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home',
                            (route) => false,
                          );
                        } else {
                          ElegantNotification.error(
                            title: const Text("Error"),
                            description: const Text(
                              "OCURRIO UN ERROR AL ENVIAR EL PEDIDO",
                            ),
                          ).show(
                            context,
                          );
                        }
                      },
                child: const Text('ENVIAR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
