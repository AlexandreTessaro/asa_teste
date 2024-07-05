import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterDonatePage extends StatefulWidget {
  const RegisterDonatePage({super.key});

  @override
  RegisterDonatePageState createState() => RegisterDonatePageState();
}

class RegisterDonatePageState extends State<RegisterDonatePage> {
  final _formKey = GlobalKey<FormState>();
  final _localController = TextEditingController();
  final _beneficiarioController = TextEditingController();
  final _cpfController = TextEditingController();
  final _rgController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _numeroPessoasResidenciaController = TextEditingController();

  void _registerDonation() {
    if (_formKey.currentState!.validate()) {
      try {
        _formKey.currentState!.save();
        final donation = Donation(
          local: _localController.text,
          data: DateTime.now(),
          beneficiario: _beneficiarioController.text,
          cpf: _cpfController.text,
          rg: _rgController.text,
          nascimento: DateTime.now(),  
          telefone: _telefoneController.text,
          endereco: _enderecoController.text,
          numeroPessoasResidencia: int.parse(_numeroPessoasResidenciaController.text),
          itensDoacao: [],  
        );
        FirebaseFirestore.instance.collection('donations').add(donation.toMap()).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Doação registrada com sucesso')));
          _formKey.currentState!.reset();
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao registrar doação: $error')));
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao registrar doação: $e')));
      }
    }
  }

  @override
  void dispose() {
    _localController.dispose();
    _beneficiarioController.dispose();
    _cpfController.dispose();
    _rgController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    _numeroPessoasResidenciaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Doações'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _localController,
                decoration: const InputDecoration(labelText: 'Local'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o local';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _beneficiarioController,
                decoration: const InputDecoration(labelText: 'Beneficiário'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o beneficiário';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cpfController,
                decoration: const InputDecoration(labelText: 'CPF'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o CPF';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _rgController,
                decoration: const InputDecoration(labelText: 'RG'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o RG';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o telefone';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _enderecoController,
                decoration: const InputDecoration(labelText: 'Endereço'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o endereço';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _numeroPessoasResidenciaController,
                decoration: const InputDecoration(labelText: 'Número de Pessoas na Residência'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o número de pessoas na residência';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerDonation,
                child: const Text('Registrar Doação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Donation {
  String local;
  DateTime data;
  String beneficiario;
  String cpf;
  String rg;
  DateTime nascimento;
  String telefone;
  String endereco;
  int numeroPessoasResidencia;
  List<Item> itensDoacao;

  Donation({
    required this.local,
    required this.data,
    required this.beneficiario,
    required this.cpf,
    required this.rg,
    required this.nascimento,
    required this.telefone,
    required this.endereco,
    required this.numeroPessoasResidencia,
    required this.itensDoacao,
  });

  Map<String, dynamic> toMap() {
    return {
      'local': local,
      'data': data,
      'beneficiario': beneficiario,
      'cpf': cpf,
      'rg': rg,
      'nascimento': nascimento,
      'telefone': telefone,
      'endereco': endereco,
      'numeroPessoasResidencia': numeroPessoasResidencia,
      'itensDoacao': itensDoacao.map((item) => item.toMap()).toList(),
    };
  }
}

class Item {
  String descricao;
  String unidade;
  int quantidade;

  Item({
    required this.descricao,
    required this.unidade,
    required this.quantidade,
  });

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'unidade': unidade,
      'quantidade': quantidade,
    };
  }
}
