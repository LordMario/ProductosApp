import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-8690a-default-rtdb.firebaseio.com';

  final List<Product> products = [];

  late Product productSelect;

  bool isLoading = true;
  bool isSaving = false;
  ProductsService() {
    getProducts();
  }

  Future<List<Product>> getProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, '/products.json');
    final resp = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromJson(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();
    return products;
  }

  Future saveOrCreateProduct(Product producto) async {
    isSaving = true;
    notifyListeners();

    if (producto.id == null) {
    } else {
      await updateProduct(producto);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product producto) async {
    final url = Uri.https(_baseUrl, '/products/${producto.id}.json');
    final resp = await http.put(url, body: json.encode(producto.toJson()));
    final decodedData = resp.body;
    final index = products.indexWhere((element) => element.id == producto.id);

    products[index] = producto;

    return decodedData;
  }
}
