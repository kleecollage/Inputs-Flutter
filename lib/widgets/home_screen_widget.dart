import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inputs/widgets/password_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller for TextField
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _aliasController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  bool _isAccept = false;
  bool _acceptNewslatter = false;
  bool _acceptPromotions = false;
  String? _errorMessage;

  void _validateInput() {
    setState(() {
      _controller.text.trim().isEmpty
          ? _errorMessage = "This field can't be empty"
          : _errorMessage = null;
    });
  }

  void _validateEmail() {
    setState(() {
      String email = _emailController.text;
      email.trim().isEmpty
          ? _errorMessage = "Email can't be empty"
          : !_isEmailValid(email)
          ? _errorMessage = 'Enter a valid email'
          : _errorMessage = null;
    });
  }

  bool _isEmailValid(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TextField Input')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===============   NAME INPUT   =============== //
            const Text('Enter your name', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Name',
                hintText: 'Enter your full name',
                errorText: _errorMessage,
              ),
              onChanged: (text) => log('Input text: $text'),
            ),
            const SizedBox(height: 20),
            // ===============   ALIAS INPUT   =============== //
            const Text(
              'Enter your alias (10 chars max.)',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _aliasController,
              maxLength: 10,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Alias',
                hintText: 'Enter your alias',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                log('Full name: ${_controller.text}');
                _validateInput();
                if (_errorMessage == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Hello, ${_controller.text}!')),
                  );
                }
              },
              child: const Text('Show Name'),
            ),
            const SizedBox(height: 20),
            // ===============   PHONE INPUT   =============== //
            const Text(
              'Enter your phone number',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Phone',
                hintText: 'Enter your phone',
              ),
            ),
            const SizedBox(height: 20),
            // ===============   EMAIL INPUT   =============== //
            const Text('Enter your email', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter your email',
                errorText: _errorMessage,
              ),
              onChanged: (text) => log('Email input text: $text'),
            ),
            const SizedBox(height: 20),
            // ===============   PAS§§WORD INPUT   =============== //
            PasswordField(),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _isAccept,
                  onChanged: (bool? value) {
                    setState(() => _isAccept = value ?? false );
                  }),
                const Text('Accept terms and conditions'),
              ]
            ),
            Row(
              children: [
                Checkbox(
                  value: _acceptNewslatter,
                  onChanged: (bool? value) {
                    setState(() => _acceptNewslatter = value ?? false );
                  }),
                const Text('I wish receive the latests news'),
              ]
            ),
            Row(
              children: [
                Checkbox(
                  value: _acceptPromotions,
                  onChanged: (bool? value) {
                    setState(() => _acceptPromotions = value ?? false );
                  }),
                const Text('Accept receive offerts'),
              ]
            ),
            ElevatedButton(
              onPressed: () {
                log('Email input: ${_emailController.text}');
                _validateEmail();
              },
              child: const Text('Validate Email'),
            ),
            if (_isAccept)
              const Text(
                'Thank you for accept the terms and conditions',
                style: TextStyle(color: Colors.amber),
              )
          ],
        ),
      ),
    );
  }
}
