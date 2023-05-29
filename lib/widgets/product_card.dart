import 'package:flutter/material.dart';


class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30,bottom: 50),
        width: double.infinity,
        height: 400,
        decoration:  _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(),
            _ProductDetail(),
            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: _NotAvailable(),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() {
    return  BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: const [
        BoxShadow(
          blurRadius: 10,
          color: Colors.black26,
          offset: Offset(0, 5)
        )
      ]
    );
  }
}

class _NotAvailable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25),bottomRight: Radius.circular(25))
      ),
      child: const FittedBox(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'No disponible',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: const SizedBox(
        width: double.infinity,
        height: 400,
        child: FadeInImage(
          placeholder: AssetImage('assets/gifs/jar-loading.gif'), 
          image: NetworkImage('https://via.placeholder.com/400x300/f6f6f6'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _ProductDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        decoration: _buildBoxDecoration(),
        height: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Disco Duro G',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Id del disco duro',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
        color: Colors.indigo,
      );
  }
}

class _PriceTag extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),topRight: Radius.circular(25))
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center ,
      child: const FittedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '\$1033333.99',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}