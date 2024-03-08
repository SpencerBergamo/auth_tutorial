import 'package:auth_tutorial/data/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserAvatar extends StatefulWidget {
  final double radius;
  const UserAvatar({super.key, required this.radius});

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);
    final avatarUrl = userProv.user?.avatarUrl;
    return CircleAvatar(
      radius: widget.radius,
      backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
      child:
          avatarUrl == null ? const Icon(Icons.account_circle, size: 50) : null,
    );
  }
}
