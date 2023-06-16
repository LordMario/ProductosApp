import 'package:flutter/material.dart';
import 'package:productos_app/provider/providers.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

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
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: _LoginForm(),
                ),
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
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'Mario@gmail.com',
                label: 'Correo',
                icono: Icons.alternate_email),
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

              RegExp regExp = RegExp(pattern);

              return regExp.hasMatch(value ?? '') ? null : 'Correo Incorrecto';
            },
            onChanged: (value) => loginForm.email = value,
          ),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(
                hintText: '******',
                label: 'Contraseña',
                icono: Icons.lock_outline),
            validator: (value) {
              if (value != null && value.length >= 6) return null;
              return 'La contraseña debe de ser de 6 caracteres';
            },
            onChanged: (value) => loginForm.password = value,
          ),
          const SizedBox(
            height: 30,
          ),
          MaterialButton(
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    if (!loginForm.isValidForm()) return;
                    loginForm.isLoading = true;

                    final navigator = Navigator.of(context);
                    await Future.delayed(const Duration(seconds: 2));

                    loginForm.isLoading = false;

                    navigator.pushReplacementNamed('home');
                  },
            color: Colors.deepPurple,
            disabledColor: Colors.grey,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 0,
            child: Container(
                padding: const EdgeInsets.all(15),
                child: Text(loginForm.isLoading ? 'Espere' : 'Ingresar',
                    style: const TextStyle(color: Colors.white))),
          )
        ],
      ),
    );
  }
}
