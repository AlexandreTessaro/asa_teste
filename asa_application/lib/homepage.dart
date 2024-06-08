import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_donate.dart'; // Certifique-se de que o caminho está correto
import 'view_donate.dart'; // Certifique-se de que o caminho está correto
import 'signin.dart'; // Certifique-se de que o caminho está correto

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(FirebaseAuth.instance.currentUser?.displayName ?? 'Usuário'),
              accountEmail: Text(FirebaseAuth.instance.currentUser?.email ?? 'Email não disponível'),
              currentAccountPicture: CircleAvatar(
                child: Text(
                  FirebaseAuth.instance.currentUser?.displayName?.substring(0, 1).toUpperCase() ?? 'U',
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Informações do Usuário'),
              onTap: () {
                // Navegar para uma página de informações do usuário, se necessário
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Deslogar'),
              onTap: () => _signOut(context),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey, Colors.black],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Homepage', style: TextStyle(fontSize: 24, color: Colors.white)),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterDonatePage()),
                  );
                },
                child: const Text('Cadastrar Doações'),
              ),
              const SizedBox(height: 20), // Espaçamento entre os botões
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewDonatePage()),
                  );
                },
                child: const Text('Visualizar Doações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
