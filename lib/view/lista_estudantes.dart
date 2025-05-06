import 'package:estudantes_flutter/models/estudante.dart';
import 'package:estudantes_flutter/view/estudante_detalhes.dart';
import 'package:estudantes_flutter/view/login_estudante.dart';
import 'package:estudantes_flutter/view/registo_estudantes.dart';
import 'package:estudantes_flutter/viewmodel/estudanteViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaEstudantes extends StatefulWidget {
  const ListaEstudantes({super.key});

  @override
  State<ListaEstudantes> createState() => _ListaEstudanteState();
}

class _ListaEstudanteState extends State<ListaEstudantes> {
  @override
  Widget build(BuildContext context) {
    final estudanteviewmodel = Provider.of<Estudanteviewmodel>(context);
    final estudantes = estudanteviewmodel.estudantes;
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Estudantes")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: estudantes.length,
                  itemBuilder: (context, index) {
                    final estudante = estudantes[index];
                    return ListTile(
                      title: Text(estudante.nome),
                      subtitle: Text(estudante.email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                estudantes.removeAt(index);
                              });
                            },
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (BuildContext context) =>
                                          EstudanteDetalhes(index),
                                ),
                              );
                              // Add your edit functionality here
                            },
                            icon: Icon(Icons.remove_red_eye),
                            color: Colors.black,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
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
                    child: Text("Login"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (BuildContext context) =>
                                  const RegistoEstudantes(),
                        ),
                      );
                    },
                    child: Text("Registrar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
