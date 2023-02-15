import 'package:cosbiome_envios/src/providers/pedidos_provider.dart';
import 'package:cosbiome_envios/src/widgets/pedidos_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pedidos = ref.watch(pedidosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PEDIDOS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              showSearch(
                context: context,
                delegate: SearchPedidos(),
              );
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: pedidos.handleGetPedidos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final pedido = snapshot.data![index];

                return ListTile(
                  leading: Text(pedido.idPedido!),
                  title: Text(pedido.nombreCliente!),
                  subtitle: Text(pedido.fechaDeEntrega!),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/detalle_pedido',
                        arguments: pedido,
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
      ),
    );
  }
}
