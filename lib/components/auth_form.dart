import 'dart:io';

import 'package:chat/components/user_image_picker.dart';
import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({super.key, required this.onSubmit});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _authFormData = AuthFormData();

  void _handleImagePick(File image) {
    _authFormData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Theme.of(context).colorScheme.error,
    ));
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_authFormData.image == null && _authFormData.isSignup) {
      return _showError('Imagem não selecionada');
    }

    widget.onSubmit(_authFormData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_authFormData.isSignup)
                  UserImagePicker(onImagePick: _handleImagePick),
                if (_authFormData.isSignup)
                  TextFormField(
                    key: const ValueKey('name'),
                    initialValue: _authFormData.name,
                    onChanged: (name) => _authFormData.name = name,
                    decoration: const InputDecoration(
                      label: Text('Nome'),
                    ),
                    validator: (value) {
                      final name = value ?? '';
                      if (name.trim().length < 5) {
                        return 'Nome deve ter no mínimo 5 caracteres';
                      }
                      return null;
                    },
                  ),
                TextFormField(
                  key: const ValueKey('email'),
                  initialValue: _authFormData.email,
                  onChanged: (email) => _authFormData.email = email,
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, digite um e-mail.';
                    }
                    const pattern =
                        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                    final regExp = RegExp(pattern);

                    if (!regExp.hasMatch(value)) {
                      return 'Por favor, digite um e-mail válido.';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  key: const ValueKey('password'),
                  initialValue: _authFormData.password,
                  onChanged: (password) => _authFormData.password = password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text('Senha'),
                  ),
                  validator: (value) {
                    final password = value ?? '';
                    if (password.length < 6) {
                      return 'Senha deve ter no mínimo 6 caracteres.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(_authFormData.isLogin ? 'Entrar' : 'Cadastrar'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _authFormData.toggleAuthMode();
                    });
                  },
                  child: Text(_authFormData.isLogin
                      ? 'Criar uma nova conta?'
                      : 'Já possui conta?'),
                )
              ],
            )),
      ),
    );
  }
}
