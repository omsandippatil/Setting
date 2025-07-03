// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'face_scanner.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailController.text = prefs.getString('saved_email') ?? '';
      _rememberMe = prefs.getBool('remember_me') ?? false;
    });
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        await _saveUserData(userCredential.user!);
        
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', _emailController.text.trim());
        await prefs.setString('userId', userCredential.user!.uid);
        
        if (_rememberMe) {
          await prefs.setString('saved_email', _emailController.text.trim());
          await prefs.setBool('remember_me', true);
        } else {
          await prefs.remove('saved_email');
          await prefs.setBool('remember_me', false);
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FaceScannerScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Authentication failed';
      if (e.code == 'user-not-found') {
        message = 'Account not found';
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect password';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format';
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Color(0xFFCF6679),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('System error occurred'),
          backgroundColor: Color(0xFFCF6679),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveUserData(User user) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': user.email,
        'lastLogin': FieldValue.serverTimestamp(),
        'uid': user.uid,
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  
                  // System Header
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF2196F3),
                                Color(0xFF1976D2),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF1976D2).withOpacity(0.3),
                                blurRadius: 20,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.security,
                            size: 48,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          'System Authentication',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFFE0E0E0),
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Secure access portal',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF9E9E9E),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 64),
                  
                  // Email Field
                  Text(
                    'Email Address',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFE0E0E0),
                      letterSpacing: 0.25,
                    ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Color(0xFFE0E0E0),
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Color(0xFF757575)),
                      filled: true,
                      fillColor: Color(0xFF1E1E1E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFF333333)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFF333333)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFF2196F3), width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFFCF6679)),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Color(0xFF757575),
                        size: 20,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email address is required';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Password Field
                  Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFE0E0E0),
                      letterSpacing: 0.25,
                    ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: TextStyle(
                      color: Color(0xFFE0E0E0),
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Color(0xFF757575)),
                      filled: true,
                      fillColor: Color(0xFF1E1E1E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFF333333)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFF333333)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFF2196F3), width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFFCF6679)),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Color(0xFF757575),
                        size: 20,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: Color(0xFF757575),
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Remember Me
                  Row(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _rememberMe = !_rememberMe;
                            });
                          },
                          borderRadius: BorderRadius.circular(4),
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: _rememberMe ? Color(0xFF2196F3) : Color(0xFF757575),
                                      width: 2,
                                    ),
                                    color: _rememberMe ? Color(0xFF2196F3) : Colors.transparent,
                                  ),
                                  child: _rememberMe
                                      ? Icon(
                                          Icons.check,
                                          size: 14,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Remember credentials',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF9E9E9E),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 40),
                  
                  // Login Button
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: _isLoading
                            ? [Color(0xFF424242), Color(0xFF424242)]
                            : [Color(0xFF2196F3), Color(0xFF1976D2)],
                      ),
                      boxShadow: _isLoading
                          ? []
                          : [
                              BoxShadow(
                                color: Color(0xFF1976D2).withOpacity(0.4),
                                blurRadius: 12,
                                offset: Offset(0, 6),
                              ),
                            ],
                    ),
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF9E9E9E)),
                              ),
                            )
                          : Text(
                              'Authenticate',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                    ),
                  ),
                  
                  SizedBox(height: 32),
                  
                  // System Links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Implement password recovery
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Color(0xFF2196F3),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: Text(
                          'Reset Password',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 16,
                        color: Color(0xFF424242),
                      ),
                      TextButton(
                        onPressed: () {
                          // Implement account creation
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Color(0xFF2196F3),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 48),
                  
                  // System Info
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFF333333)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.shield_outlined,
                                size: 16,
                                color: Color(0xFF757575),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Secure Connection',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF757575),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'System v2.1.0 • Build 2025.07.03',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF616161),
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}