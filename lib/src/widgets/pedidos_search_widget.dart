import 'package:cosbiome_envios/src/models/pedido_cosbiome_model.dart';
import 'package:cosbiome_envios/src/utils/http_utils.dart';
import 'package:flutter/material.dart';

class SearchPedidos extends SearchDelegate {
  Future<List<PedidoCosbiomeModel>> handleSearchPedidos(
      String querySearch) async {
    try {
      final pedidosDB = await Http.get("cosbiomepedidos", {
        "_limit": 100000.toString(),
        "ENVIO": "ENTREGADO",
        "_sort": "nombreCliente%3AASC",
        "_q": querySearch,
      });

      List<PedidoCosbiomeModel> pedidosData =
          pedidosDB.data.map<PedidoCosbiomeModel>((e) {
        return PedidoCosbiomeModel.fromJson(e);
      }).toList();

      return pedidosData;
    } catch (e) {
      return [];
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: handleSearchPedidos(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No se encontraron pedidos'),
            );
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              final pedido = snapshot.data![index];

              return ListTile(
                leading: Text(pedido.idPedido!),
                title: Text(pedido.nombreCliente!),
                subtitle: Text(pedido.fechaDeEntrega!),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () async {
                    return await showDialog(
                      context: context,
                      builder: (context) {
                        final size = MediaQuery.of(context).size;

                        return ModalDetailPedido(size: size, pedido: pedido);
                      },
                    );
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: snapshot.data!.length,
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: handleSearchPedidos(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No se encontraron pedidos'),
            );
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              final pedido = snapshot.data![index];

              return ListTile(
                leading: Text(pedido.idPedido!),
                title: Text(pedido.nombreCliente!),
                subtitle: Text(pedido.fechaDeEntrega!),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () async {
                    return await showDialog(
                      context: context,
                      builder: (context) {
                        final size = MediaQuery.of(context).size;

                        return ModalDetailPedido(size: size, pedido: pedido);
                      },
                    );
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: snapshot.data!.length,
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ModalDetailPedido extends StatelessWidget {
  const ModalDetailPedido({
    Key? key,
    required this.size,
    required this.pedido,
  }) : super(key: key);

  final Size size;
  final PedidoCosbiomeModel pedido;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: BoxConstraints(
          maxHeight: size.height * 0.7,
          maxWidth: size.width * 0.8,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${pedido.idPedido!}\n${pedido.nombreCliente}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    'Numero de guia: ${pedido.a}',
                    style: const TextStyle(
                      fontSize: 16,
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
                      ),
                    ),
                    height: size.height * 0.4,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final producto = pedido.productosCompra![index]!;

                        return ListTile(
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
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: pedido.idFirebase == null ||
                            pedido.idFirebase == '' ||
                            !pedido.idFirebase!.contains('https')
                        ? Image.asset(
                            'assets/noimage.png',
                          )
                        : Image.network(
                            pedido.idFirebase!,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
