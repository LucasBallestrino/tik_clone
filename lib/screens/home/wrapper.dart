import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:tik_clone/models/user/user.dart';

import 'package:tik_clone/screens/home/profile.dart';
import 'package:tik_clone/screens/profile/loged_profile.dart';
import 'package:tik_clone/screens/upload/upload_screen.dart';
import 'package:tik_clone/services/auth.dart';


/// this screen just check your login status and redirect.

class WrapperScreen extends StatefulWidget {
  final bool upload;
  final void Function() onTap;
  const WrapperScreen({Key? key, required this.upload, required this.onTap})
      : super(key: key);

  @override
  _WrapperScreenState createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    if (user == null) {
      return ProfileScreen(
        upload: widget.upload,
      );
    } else {
      if (widget.upload) {
        return UploadScreen(
          onTap: widget.onTap,
        );
      }
      return LogedProfileScreen(user: _authService.getUser()!.uid,userName: _authService.getUser()!.displayName!, ownProfile: true,);
    }
  }
}
