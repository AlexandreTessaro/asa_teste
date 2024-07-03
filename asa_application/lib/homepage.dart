import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_donate.dart'; // Certifique-se de que o caminho está correto
import 'view_donate.dart'; // Certifique-se de que o caminho está correto
import 'signin.dart'; // Certifique-se de que o caminho está correto

// Definindo um GlobalKey para o NavigatorState
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();

    // Usando o navigatorKey para acessar o Navigator
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // Configurando o GlobalKey no MaterialApp
      home: Scaffold(
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
                    style: const TextStyle(fontSize: 40.0),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Informações do Usuário'),
                onTap: () {
                  // Navegar para uma página de informações do usuário, se necessário
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Deslogar'),
                onTap: _signOut,
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
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterDonatePage()),
                    );
                  },
                  child: const Text('Cadastrar Doações'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ViewDonatePage()),
                    );
                  },
                  child: const Text('Visualizar Doações'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
