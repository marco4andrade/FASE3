import 'package:flutter/material.dart';
import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

class UserCreationForm extends StatefulWidget {
  final Future<UserModel> Function(CreateUserInput input) onSubmit;
  const UserCreationForm({super.key, required this.onSubmit});

  @override
  State<UserCreationForm> createState() => _UserCreationFormState();
}

class _UserCreationFormState extends State<UserCreationForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  String? _result;

  @override
  void dispose() {
    _email.dispose();
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _result = null; });
    try {
      final input = CreateUserInput.minimal(
        email: _email.text.trim(),
        username: _username.text.trim(),
        password: _password.text,
      );
      final user = await widget.onSubmit(input);
      setState(() => _result = 'Creado ID: ${user.id}\nUsername: ${user.username}');
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
            Text('Crear Usuario (mínimo)', style: theme.textTheme.titleLarge),
            const SizedBox(height: 12),
            TextFormField(
              controller: _email,
              decoration: _dec('Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (v) => v != null && v.contains('@') ? null : 'Email inválido',
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _username,
              decoration: _dec('Username'),
              validator: (v) => (v ?? '').isEmpty ? 'Requerido' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _password,
              decoration: _dec('Password'),
              obscureText: true,
              validator: (v) => (v ?? '').length < 4 ? 'Min 4 chars' : null,
            ),
            const SizedBox(height: 16),
            if (_loading) const Center(child: CircularProgressIndicator()),
            if (_result != null)
              Text(
                _result!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: _result!.startsWith('Error') ? Colors.red : Colors.green,
                ),
              ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _loading ? null : _submit,
              icon: const Icon(Icons.check),
              label: const Text('Crear'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _loading ? null : () => Navigator.of(context).maybePop(),
              child: const Text('Cerrar'),
            ),
            const SizedBox(height: 12),
            Text(
              'Equivalente curl:\n'
              "curl -X POST 'https://fakestoreapi.com/users' \\\n+  -H 'Content-Type: application/json' \\\n+  -d '{\"username\": \"USER\", \"email\": \"MAIL\", \"password\": \"PASS\"}'",
              style: theme.textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}
