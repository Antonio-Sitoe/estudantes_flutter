import 'package:estudantes_flutter/view/lista_estudantes.dart';
import 'package:estudantes_flutter/viewmodel/estudanteViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginEstudante extends StatefulWidget {
  const LoginEstudante({super.key});

  @override
  State<LoginEstudante> createState() => _LoginEstudanteState();
}

class _LoginEstudanteState extends State<LoginEstudante> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final estudanteviewmodel = Provider.of<Estudanteviewmodel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _senhaController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a senha';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final existEstudante = estudanteviewmodel
                        .pesquisaPorEmailESenha(
                          _emailController.text,
                          _senhaController.text,
                        );

                    if (existEstudante) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListaEstudantes(),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login válido!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Nenhum Usuario com esse email e senha!',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }
}
