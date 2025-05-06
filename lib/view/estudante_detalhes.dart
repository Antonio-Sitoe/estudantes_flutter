import 'package:estudantes_flutter/viewmodel/estudanteViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EstudanteDetalhes extends StatelessWidget {
  final int id;
  EstudanteDetalhes(this.id);
  @override
  Widget build(BuildContext context) {
    final estudanteviewmodel = Provider.of<Estudanteviewmodel>(context);
    final estudante = estudanteviewmodel.obterEStudante(id);
    print(estudante.getDisciplinas.toString());
    return Scaffold(
      appBar: AppBar(title: Text("Detalhes de Estudante")),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              Text('ID: ${estudante.id}'),
              Text('Nome: ${estudante.nome}'),
              Text('Email: ${estudante.email}'),
              Text('Senha: ${estudante.senha}'),
              SizedBox(height: 20),
              Text(
                'Disciplinas:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...estudante.getDisciplinas
                  .map((dc) => Text('- ${dc.nome}'))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
