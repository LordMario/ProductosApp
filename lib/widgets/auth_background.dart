import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {

   final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            _PurpleBox(),
            _HeaderIcon(),
            child,
          ],
        ));
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child:
            const Icon(Icons.sunny, color: Colors.white, size: 100),
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeHeigth = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: sizeHeigth.height * 0.4,
      decoration: _purpleBackground(),
      child: Stack(
        children: const [
          Positioned(
            top: 160,
            left: 30,
            child: _Bubble(),
          ),
          Positioned(
            right: 22,
            top: 70,
            child: _Bubble(),
          ),
          Positioned(
            bottom: -60,
            left: 90,
            child: _Bubble(),
          ),
          Positioned(
            bottom: 4,
            right: 50,
            child: _Bubble(),
          ),
          Positioned(
            top: 120,
            right: 150,
            child: _Bubble(),
          ),
          Positioned(
            top: 20,
            left: 66,
            child: _Bubble(),
          )
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() {
    return const BoxDecoration(
        gradient: LinearGradient(colors: [
      Color.fromRGBO(63, 63, 156, 1),
      Color.fromRGBO(90, 70, 178, 1),
    ]));
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}
