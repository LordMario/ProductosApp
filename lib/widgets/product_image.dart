import 'package:flutter/material.dart';


class ProductImage extends StatelessWidget {
  const ProductImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
      child: Container(
        height: 450,
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: const ClipRRect(
          borderRadius:  BorderRadius.only(topLeft: Radius.circular(45),topRight: Radius.circular(45)),
          child:  FadeInImage(
            fit: BoxFit.cover,
            image:  NetworkImage('https://via.placeholder.com/400x300/green'),
            placeholder: AssetImage('assets/gifs/jar-loading.gif'), 
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return  BoxDecoration(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(45),topRight: Radius.circular(45)),
      color: Colors.indigo,
      boxShadow:  [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 5)
        )
      ]
    );
  }
}