import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';

class UserTile extends StatelessWidget {
  final User user;
  final VoidCallback onTap;
  const UserTile({required this.user, required this.onTap, super.key});

  String getInitials(String? name) {
  if (name == null || name.trim().isEmpty) return "?";
  final parts = name.trim().split(RegExp(r'\s+')); // Handles multiple spaces

  String first = parts.isNotEmpty && parts[0].isNotEmpty ? parts[0][0] : '';
  String second = parts.length > 1 && parts[1].isNotEmpty ? parts[1][0] : '';

  String initials = (first + second).toUpperCase();
  return initials.isEmpty ? "?" : initials;
}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF8760FF), Color(0xFF9572FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Text(
              getInitials(user.name),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
        ),
        title: Text(
          user.name,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          user.email,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 15,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 28),
        onTap: onTap,
      ),
    );
  }
}
