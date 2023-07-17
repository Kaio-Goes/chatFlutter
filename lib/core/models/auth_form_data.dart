import 'dart:io';

enum AuthMode { signup, login }

class AuthFormData {
  String name = '';
  String email = '';
  String password = '';
  File? image;
  AuthMode mode = AuthMode.login;

  bool get isLogin {
    return mode == AuthMode.login;
  }

  bool get isSignup {
    return mode == AuthMode.signup;
  }

  void toggleAuthMode() {
    mode = isLogin ? AuthMode.signup : AuthMode.login;
  }
}
