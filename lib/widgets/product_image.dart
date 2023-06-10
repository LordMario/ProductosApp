import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? imagen;

  const ProductImage({super.key, this.imagen});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        height: 450,
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Opacity(
          opacity: 0.8,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            child: imagen == null
                ? const Image(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/no-image.png'),
                  )
                : FadeInImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imagen!),
                    placeholder:
                        const AssetImage('assets/gifs/jar-loading.gif'),
                  ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(45), topRight: Radius.circular(45)),
        color: const Color.fromARGB(255, 0, 0, 0),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5))
        ]);
  }
}
