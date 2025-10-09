import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final Future<String> Function(String username, String password) onSubmit;
  const LoginForm({super.key, required this.onSubmit});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController(text: 'mor_2314');
  final _password = TextEditingController(text: '83r5^_');
  bool _loading = false;
  String? _result;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _result = null; });
    try {
      final token = await widget.onSubmit(_username.text.trim(), _password.text);
      setState(() => _result = 'Token: ${token.substring(0, token.length > 35 ? 35 : token.length)}...');
    } catch (e) {
      setState(() => _result = 'Error: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  InputDecoration _dec(String label) => InputDecoration(labelText: label, border: const OutlineInputBorder());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 16, left: 16, right: 16, top: 16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Login', style: theme.textTheme.titleLarge),
            const SizedBox(height: 12),
            TextFormField(controller: _username, decoration: _dec('Username'), validator: (v)=> (v??'').isEmpty ? 'Requerido' : null),
            const SizedBox(height: 12),
            TextFormField(controller: _password, decoration: _dec('Password'), obscureText: true, validator: (v)=> (v??'').isEmpty ? 'Requerido' : null),
            const SizedBox(height: 16),
            if (_loading) const Center(child: CircularProgressIndicator()),
            if (_result != null) Text(_result!, style: theme.textTheme.bodyMedium?.copyWith(color: _result!.startsWith('Error') ? Colors.red : Colors.green)),
            const SizedBox(height: 8),
            FilledButton.icon(onPressed: _loading ? null : _submit, icon: const Icon(Icons.login), label: const Text('Ingresar')),
            const SizedBox(height: 8),
            TextButton(onPressed: _loading ? null : () => Navigator.of(context).maybePop(), child: const Text('Cerrar')),
          ],
        ),
      ),
    );
  }
}
