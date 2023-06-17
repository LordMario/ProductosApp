import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context);

    if (productsService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              authService.logOut();
              Navigator.pushReplacementNamed(context, 'login');
            },
            icon: const Icon(Icons.logout),
            color: Colors.black,
            iconSize: 32,
          ),
        ],
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (_, int index) => GestureDetector(
            onTap: () {
              productsService.productSelect =
                  productsService.products[index].copy();
              Navigator.pushNamed(context, 'product');
            },
            child: ProductCard(producto: productsService.products[index])),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productsService.productSelect =
              Product(available: false, name: '', price: 0.0);
          Navigator.pushNamed(context, 'product');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
