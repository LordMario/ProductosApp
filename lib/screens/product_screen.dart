import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/provider/providers.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/input_decorations.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.productSelect),
      child: _ProdutScreenBody(productService: productService),
    );
  }
}

class _ProdutScreenBody extends StatelessWidget {
  const _ProdutScreenBody({
    required this.productService,
  });

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    final productformProvider = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(imagen: productService.productSelect.picture),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 40,
                      ),
                    )),
                Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                      onPressed: () async {
                        final picker = ImagePicker();
                        final XFile? pickedFile = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 100);

                        if (pickedFile == null) return;

                        productService
                            .updateSelectedProductImage(pickedFile.path);
                      },
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.black,
                        size: 40,
                      ),
                    ))
              ],
            ),
            _ProductForm(),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: productService.isSaving
            ? null
            : () async {
                if (!productformProvider.isValidForm()) return;

                final navigator = Navigator.of(context);
                final String? imagenUrl = await productService.createImage();
                if (imagenUrl != null) {
                  productformProvider.producto.picture = imagenUrl;
                }
                await productService
                    .saveOrCreateProduct(productformProvider.producto);

                navigator.pop();
              },
        child: productService.isSaving
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(Icons.save_outlined),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

    final producto = productForm.producto;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: producto.name,
                decoration: InputDecorations.authInputDecoration(
                    label: 'Nombre', hintText: 'Nombre del producto'),
                onChanged: (value) => producto.name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                initialValue: '${producto.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    producto.price = 0;
                  } else {
                    producto.price = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    label: 'Precio', hintText: '\$150'),
              ),
              const SizedBox(
                height: 30,
              ),
              SwitchListTile.adaptive(
                value: producto.available,
                activeColor: Colors.indigo,
                title: const Text('Disponible'),
                onChanged: productForm.updateAvailability,
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            blurRadius: 5,
            color: Colors.black.withOpacity(0.05),
          )
        ]);
  }
}
