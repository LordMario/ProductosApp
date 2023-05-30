import 'package:flutter/material.dart';
import 'package:productos_app/ui/input_decorations.dart';
import '../widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children:  [
            Stack(
              children:  [
                const ProductImage(),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    }, 
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 40,),
                  )
                ),
                const Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: null,
                    icon:  Icon(Icons.camera_alt_outlined, color: Colors.white, size: 40,),
                  )
                )
              ],
            ),
            _ProductForm(),
            const SizedBox(height: 100,)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.save_outlined),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children:  [
              const SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecorations.authInputDecoration(label: 'Nombre', hintText: 'Nombre del producto'),
              ),
              const SizedBox(height: 30,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(label: 'Precio', hintText: '\$150'),
              ),
              const SizedBox(height: 30,),
              SwitchListTile.adaptive(
                value: true,
                activeColor: Colors.indigo,
                title: const Text('Disponible'),
                onChanged: (value){}
              ),
              const SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return  BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      boxShadow:  [
        BoxShadow(
          offset: const Offset(0, 5),
          blurRadius: 5,
          color: Colors.black.withOpacity(0.05),
        )
      ]
    );
  }
}