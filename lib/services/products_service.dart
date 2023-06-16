import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-8690a-default-rtdb.firebaseio.com';

  final List<Product> products = [];
  late Product productSelect;
  File? pathImage;

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
      await createProduct(producto);
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

  Future<String> createProduct(Product producto) async {
    final url = Uri.https(_baseUrl, '/products.json');
    final resp = await http.post(url, body: json.encode(producto.toJson()));
    final decodedData = jsonDecode(resp.body);

    producto.id = decodedData['name'];
    products.insert(0, producto);

    return decodedData['name'];
  }

  Future<String?> createImage() async {
    if (pathImage == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/deqdnytfx/image/upload?upload_preset=productosImage');

    final imageUpload = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', pathImage!.path);
    imageUpload.files.add(file);
    final streamResponse = await imageUpload.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      return null;
    }
    pathImage = null;

    final decodeData = json.decode(resp.body);
    return decodeData['secure_url'];
  }

  void updateSelectedProductImage(String url) {
    productSelect.picture = url;
    pathImage = File.fromUri(Uri(path: url));
    notifyListeners();
  }
}
