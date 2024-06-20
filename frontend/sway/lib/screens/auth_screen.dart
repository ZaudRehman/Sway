//frontend\sway\lib\screens\auth_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AuthScreen extends StatefulWidget {
  final Function() onLoginSuccess; // Define the callback here

  const AuthScreen({Key? key, required this.onLoginSuccess}) : super(key: key);


  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;
  bool _isLoading = false;
  bool _isOTPMode = false;
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      if (_isOTPMode) {
        final otpValid = await ApiService.verifyOTP(
          _emailController.text,
          _otpController.text,
        );
        if (otpValid) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          _showSnackBar('Invalid OTP!');
        }
      } else {
        if (_isLogin) {
          await ApiService.login(
            _emailController.text,
            _passwordController.text,
          );
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          await ApiService.signUp(
            _emailController.text,
            _passwordController.text,
          );
          await ApiService.sendOTP(_emailController.text);
          setState(() {
            _isOTPMode = true;
          });
        }
      }
    } catch (error) {
      _showSnackBar('An error occurred. Please try again.');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/9306407.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _isLogin ? 'Login' : 'Signup',
                        style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 20),
                      if (!_isOTPMode) ...[
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8)),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || !value.contains('@')) {
                              return 'Invalid email!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8)),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Password is too short!';
                            }
                            return null;
                          },
                        ),
                      ],
                      if (_isOTPMode) ...[
                        TextFormField(
                          controller: _otpController,
                          decoration: InputDecoration(
                              labelText: 'OTP',
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8)),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.length != 6) {
                              return 'Invalid OTP!';
                            }
                            return null;
                          },
                        ),
                      ],
                      const SizedBox(height: 20),
                      if (_isLoading)
                        const CircularProgressIndicator()
                      else
                        ElevatedButton(
                          onPressed: _submit,
                          child: Text(_isOTPMode
                              ? 'Verify OTP'
                              : _isLogin
                                  ? 'Log In'
                                  : 'Create Account'),
                        ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                            _isOTPMode = false;
                          });
                        },
                        child: Text(
                          _isLogin
                              ? 'Create new account'
                              : 'I already have an account',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      if (!_isOTPMode) ...[
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.login, color: Colors.white),
                              onPressed: () {
                                // Handle Google login
                              },
                            ),
                            IconButton(
                              icon:
                                  const Icon(Icons.login, color: Colors.white),
                              onPressed: () {
                                // Handle Facebook login
                              },
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
