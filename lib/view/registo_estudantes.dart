import 'package:estudantes_flutter/models/disciplina.dart';
import 'package:estudantes_flutter/view/login_estudante.dart';
import 'package:estudantes_flutter/view/lista_estudantes.dart';
import 'package:estudantes_flutter/viewmodel/estudanteViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistoEstudantes extends StatefulWidget {
  const RegistoEstudantes({super.key});

  @override
  State<RegistoEstudantes> createState() => _RegistoEstudanteState();
}

class _RegistoEstudanteState extends State<RegistoEstudantes> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _senha = TextEditingController();

  final List<Disciplina> _disciplinas = [
    Disciplina(nome: "Matematica"),
    Disciplina(nome: "Português"),
    Disciplina(nome: "História"),
    Disciplina(nome: "Geografia"),
    Disciplina(nome: "Ciências"),
    Disciplina(nome: "Filosofia"),
  ];

  final List<Disciplina> _disciplinasSelecionadas = [];

  @override
  void dispose() {
    _nome.dispose();
    _email.dispose();
    _senha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final estudanteviewmodel = Provider.of<Estudanteviewmodel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Registro de Estudante")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nome,
                  decoration: const InputDecoration(labelText: "Nome"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, Insira o nome";
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, Insira o Email";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Por favor, insira um email válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _senha,
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
                const Text(
                  "Selecione as Disciplinas",
                  style: TextStyle(fontSize: 16),
                ),
                Column(
                  children:
                      _disciplinas.map((dc) {
                        return CheckboxListTile(
                          value: _disciplinasSelecionadas.contains(dc),
                          onChanged: (bool? isChecked) {
                            setState(() {
                              if (isChecked == true) {
                                _disciplinasSelecionadas.add(dc);
                              } else {
                                _disciplinasSelecionadas.remove(dc);
                              }
                            });
                          },
                          title: Text(dc.nome),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      estudanteviewmodel.criarEstudante(
                        _nome.text,
                        _email.text,
                        _senha.text,
                        _disciplinasSelecionadas,
                      );

                      _nome.clear();
                      _email.clear();
                      _senha.clear();
                      setState(() {
                        _disciplinasSelecionadas.clear();
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (BuildContext context) => const ListaEstudantes(),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Cadastro realizado com sucesso!'),
                        ),
                      );
                    }
                  },
                  child: Text("Registrar"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (BuildContext context) => const LoginEstudante(),
                      ),
                    );
                  },
                  child: Text("Entrar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
