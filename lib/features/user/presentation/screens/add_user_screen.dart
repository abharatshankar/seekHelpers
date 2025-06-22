import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/user.dart';
import '../providers/user_provider.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});
  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: null,
      ),
      backgroundColor: Color.fromARGB(255, 164, 121, 228),
      body: Stack(
        children: [
          // Softer gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 164, 121, 228), Color(0xFFE5DEFC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    // Softer glass card with form
                    Container(
                      margin: const EdgeInsets.only(top: 38),
                      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 28),
                      width: MediaQuery.of(context).size.width * 0.90,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.19),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.21),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 24,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Center(
                                child: Text(
                                  'Add User',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: _inputDecoration('Name'),
                                      validator: (v) => v == null || v.isEmpty ? 'Enter name' : null,
                                      onSaved: (v) => name = v ?? '',
                                    ),
                                    const SizedBox(height: 18),
                                    TextFormField(
                                      decoration: _inputDecoration('Email'),
                                      validator: (v) => v == null || !v.contains('@') ? 'Enter valid email' : null,
                                      onSaved: (v) => email = v ?? '',
                                    ),
                                    const SizedBox(height: 18),
                                    TextFormField(
                                      decoration: _inputDecoration('Phone'),
                                      validator: (v) => v == null || v.isEmpty ? 'Enter phone' : null,
                                      onSaved: (v) => phone = v ?? '',
                                    ),
                                    const SizedBox(height: 36),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                          backgroundColor: const Color(0xFFB7A3F7),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18),
                                          ),
                                          elevation: 3,
                                          shadowColor: Colors.black12,
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState?.validate() ?? false) {
                                            _formKey.currentState!.save();
                                            Provider.of<UserProvider>(context, listen: false).addUser(
                                              User(
                                                id: DateTime.now().millisecondsSinceEpoch,
                                                name: name,
                                                email: email,
                                                phone: phone,
                                              ),
                                            );
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text(
                                          'Add User',
                                          style: TextStyle(color: Color(0xFF5636B8)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w500,
        fontSize: 17,
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.20),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.19)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF8760FF), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.red.withOpacity(0.7)),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
    );
  }
}
