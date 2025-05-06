import 'dart:math';

import 'package:estudantes_flutter/models/disciplina.dart';
import 'package:estudantes_flutter/models/estudante.dart';
import 'package:flutter/widgets.dart';

class Estudanteviewmodel extends ChangeNotifier {
  List<Estudante> estudantes = [];

  criarEstudante(
    String nome,
    String email,
    String senha,
    List<Disciplina> disciplina,
  ) {
    estudantes.add(
      Estudante(
        id: Random().nextInt(1000).toString(),
        nome: nome,
        senha: senha,
        email: email,
        dcs: disciplina,
      ),
    );
    notifyListeners();
  }

  List<Estudante> listarEstudantes() {
    return estudantes;
  }

  atualizarEstudante(int index, Estudante estudante) {
    estudantes[index] = estudante;
    notifyListeners();
  }

  removerEstudante(int index) {
    estudantes.removeAt(index);
    notifyListeners();
  }

  bool pesquisaPorEmailESenha(String email, String senha) {
    return estudantes.any((e) => e.email == email && e.senha == senha);
  }

  Estudante obterEStudante(int index) {
    return estudantes[index];
  }
}
