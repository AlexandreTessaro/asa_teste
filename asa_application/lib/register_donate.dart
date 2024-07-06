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
  final List<Item> _itensDoacao = [];

  void _addItem() {
    setState(() {
      _itensDoacao.add(Item(descricao: '', unidade: '', quantidade: 0));
    });
  }

  void _removeItem(int index) {
    setState(() {
      _itensDoacao.removeAt(index);
    });
  }

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
          itensDoacao: _itensDoacao,
        );
        FirebaseFirestore.instance.collection('donations').add(donation.toMap()).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Doação registrada com sucesso')));
          _formKey.currentState!.reset();
          setState(() {
            _itensDoacao.clear();
          });
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey, Colors.black],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: _localController,
                  decoration: const InputDecoration(
                    labelText: 'Local',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o local';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _beneficiarioController,
                  decoration: const InputDecoration(
                    labelText: 'Beneficiário',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o beneficiário';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cpfController,
                  decoration: const InputDecoration(
                    labelText: 'CPF',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o CPF';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _rgController,
                  decoration: const InputDecoration(
                    labelText: 'RG',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o RG';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _telefoneController,
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o telefone';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _enderecoController,
                  decoration: const InputDecoration(
                    labelText: 'Endereço',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o endereço';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _numeroPessoasResidenciaController,
                  decoration: const InputDecoration(
                    labelText: 'Número de Pessoas na Residência',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
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
                const Text(
                  'Itens Doação',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                ..._itensDoacao.asMap().entries.map((entry) {
                  int index = entry.key;
                  Item item = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: item.descricao,
                            decoration: const InputDecoration(
                              labelText: 'Descrição',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                            onChanged: (value) {
                              setState(() {
                                item.descricao = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira a descrição';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            initialValue: item.unidade,
                            decoration: const InputDecoration(
                              labelText: 'Unidade',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                            onChanged: (value) {
                              setState(() {
                                item.unidade = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira a unidade';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            initialValue: item.quantidade.toString(),
                            decoration: const InputDecoration(
                              labelText: 'Quantidade',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                item.quantidade = int.tryParse(value) ?? 0;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira a quantidade';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Por favor, insira um número válido';
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () => _removeItem(index),
                        ),
                      ],
                    ),
                  );
                }),
                ElevatedButton(
                  onPressed: _addItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Adicionar Item'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _registerDonation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Registrar Doação'),
                ),
              ],
            ),
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
