import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final TextEditingController _passwordController = TextEditingController();
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter your password:',
            style: TextStyle(fontSize: 18)
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _passwordController,
            obscureText: _hidePassword,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState( () => _hidePassword = !_hidePassword );
                  },
                  icon: Icon(_hidePassword
                      ? Icons.visibility
                      : Icons.visibility_off
                  ),
                )),
          )
        ],
      ),
    );
  }
}