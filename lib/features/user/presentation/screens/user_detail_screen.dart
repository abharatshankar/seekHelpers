import 'dart:ui';
import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;
  const UserDetailScreen({required this.user, super.key});

  String getInitials(String? name) {
    if (name == null || name.trim().isEmpty) return "?";
    final parts = name.trim().split(RegExp(r'\s+'));
    String first = parts.isNotEmpty && parts[0].isNotEmpty ? parts[0][0] : '';
    String second = parts.length > 1 && parts[1].isNotEmpty ? parts[1][0] : '';
    String initials = (first + second).toUpperCase();
    return initials.isEmpty ? "?" : initials;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: null,
      ),
      backgroundColor: Color.fromARGB(255, 172, 146, 211),
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [ Color.fromARGB(255, 172, 146, 211), Color(0xFFF2EAFE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Glassmorphic card
                    Container(
                      margin: const EdgeInsets.only(top: 75),
                      padding: const EdgeInsets.only(top: 80, bottom: 32, left: 20, right: 20),
                      width: MediaQuery.of(context).size.width * 0.88,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.20),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.25),
                          width: 1.8,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 30,
                            offset: Offset(0, 16),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                user.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              const SizedBox(height: 22),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.email_rounded,
                                        color: Color(0xFF8760FF), size: 26),
                                    const SizedBox(width: 16),
                                    Flexible(
                                      child: Text(
                                        user.email,
                                        style: const TextStyle(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 14),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.phone_rounded,
                                        color: Color(0xFF8760FF), size: 26),
                                    const SizedBox(width: 16),
                                    Flexible(
                                      child: Text(
                                        user.phone,
                                        style: const TextStyle(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
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
                    // Floating gradient avatar
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration:  BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Color(0xFF8760FF), Color(0xFFA18AFF)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 32,
                                offset: Offset(0, 16),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.white.withOpacity(0.25),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              getInitials(user.name),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                              ),
                            ),
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
}
