import 'package:flutter/material.dart';
import 'package:marketap_sdk/marketap_sdk.dart';
import '../utils/storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _id = TextEditingController();
  final _pw = TextEditingController();
  final _email = TextEditingController();

  void _login() async {
    if (_id.text.isEmpty || _pw.text.isEmpty || _email.text.isEmpty) return;
    await Storage.saveUser(_id.text, _email.text);
    Marketap.login(
      userId: _id.text,
      userProperties: {'mkt_email': _email.text},
    ); // Marketap Login 호출

    if (mounted) {
      Navigator.pop(context); // 홈으로
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${_id.text} 님, 환영합니다!')));
    }
  }

  @override
  void dispose() {
    _id.dispose();
    _pw.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
    appBar: AppBar(title: const Text('Login')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          TextField(
            controller: _id,
            decoration: const InputDecoration(labelText: 'ID'),
          ),
          TextField(
            controller: _pw,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          TextField(
            controller: _email,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: _login, child: const Text('LOGIN')),
        ],
      ),
    ),
  );
}
