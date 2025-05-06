import 'package:estudantes_flutter/models/disciplina.dart';

class Estudante {
  String _id;
  String _nome;
  String _email;
  String _senha;
  List<Disciplina> _disciplinas = [];

  Estudante({
    required String id,
    required String nome,
    required String senha,
    required String email,
    required List<Disciplina> dcs,
  }) : _id = id,
       _nome = nome,
       _senha = senha,
       _email = email,
       _disciplinas = dcs;

  String get id => _id;
  String get nome => _nome;
  String get senha => _senha;
  String get email => _email;

  List<Disciplina> get getDisciplinas => _disciplinas;

  set disciplinas(List<Disciplina> disciplinas) {
    _disciplinas = disciplinas;
  }

  set id(String value) {
    _id = value;
  }

  set nome(String value) {
    _nome = value;
  }

  set senha(String value) {
    _senha = value;
  }
}
