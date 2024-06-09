import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:lush_app/view_models/registration_view_model.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistrationViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registrazione'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextFiled(
                  label: 'Il tuo nome',
                  onChanged: (value) => {
                        Provider.of<RegistrationViewModel>(context,
                                listen: false)
                            .setUsername(value)
                      }),
              _buildTextFiled(
                  label: 'La tua email',
                  onChanged: (value) => {
                        Provider.of<RegistrationViewModel>(context,
                                listen: false)
                            .setEmail(value)
                      }),
              _buildTextFiled(
                  label: 'La tua password',
                  onChanged: (value) => {
                        Provider.of<RegistrationViewModel>(context,
                                listen: false)
                            .setPassword(value)
                      }),
              ElevatedButton(
                  onPressed: () =>
                      Provider.of<RegistrationViewModel>(context, listen: false)
                          .registerUser(),
                  child: const Text('Registrati'))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFiled({
    required String label,
    bool obscureText = false,
    required Function(String) onChanged,
  }) {
    return TextField(
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(labelText: label),
    );
  }
}
