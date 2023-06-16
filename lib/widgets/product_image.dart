import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? imagen;

  const ProductImage({super.key, this.imagen});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
      child: Container(
        height: 450,
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Opacity(
          opacity: 0.9,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            child: SizedBox(
              width: double.infinity,
              height: 450,
              child: UploadImage(imagen: imagen),
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
        color: const Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5))
        ]);
  }
}

class UploadImage extends StatelessWidget {
  final String? imagen;

  const UploadImage({super.key, this.imagen});

  @override
  Widget build(BuildContext context) {
    if (imagen == null) {
      return const Image(
          fit: BoxFit.cover, image: AssetImage('assets/images/no-image.png'));
    }

    if (imagen!.startsWith('http')) {
      return FadeInImage(
        fit: BoxFit.contain,
        image: NetworkImage(imagen!),
        placeholder: const AssetImage('assets/gifs/jar-loading.gif'),
      );
    } else {
      return Image.file(
        File(imagen!),
        fit: BoxFit.cover,
      );
    }
  }
}
