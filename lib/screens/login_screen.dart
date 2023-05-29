import 'package:flutter/material.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 250,
          ),
          CardContainer(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text('hope',
                    style: TextStyle(
                      color: Color.fromARGB(255, 2, 11, 131),
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                    ) 
                ),
                const SizedBox(height: 30),
                _LoginForm(),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text('Crear una nueva cuenta'),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(hintText:'Mario@gmail.com',label: 'Correo',icono: Icons.alternate_email),
          ),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(hintText:'******',label: 'Contraseña',icono: Icons.lock_outline),
          ),
          const SizedBox(height: 30,),
          MaterialButton(
            onPressed: (){
            
            },
            color: Colors.deepPurple,
            disabledColor: Colors.grey,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 0,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: const Text(
                'Ingresar',
                style: TextStyle(color: Colors.white)
              )
            ),
          )
        ],
      ),
    );
  }
}
