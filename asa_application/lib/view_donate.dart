import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewDonatePage extends StatelessWidget {
  const ViewDonatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizar Doações'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('donations').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return ListTile(
                title: Text(document['beneficiario']),
                subtitle: Text(document['local']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DonationDetailPage(donation: document),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class DonationDetailPage extends StatelessWidget {
  final DocumentSnapshot donation;

  const DonationDetailPage({super.key, required this.donation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Doação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text('Local: ${donation['local']}'),
            Text('Beneficiário: ${donation['beneficiario']}'),
            Text('CPF: ${donation['cpf']}'),
            Text('RG: ${donation['rg']}'),
            Text('Telefone: ${donation['telefone']}'),
            Text('Endereço: ${donation['endereco']}'),
            Text('Número de Pessoas na Residência: ${donation['numeroPessoasResidencia']}'),
            const Text('Itens Doação:'),
            ...donation['itensDoacao'].map<Widget>((item) {
              return ListTile(
                title: Text(item['descricao']),
                subtitle: Text('${item['unidade']} - ${item['quantidade']}'),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
