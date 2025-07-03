// lib/login/face_scanner.dart
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'samsung_account_page.dart'; // Uncomment and fix path if needed

class FaceScannerScreen extends StatefulWidget {
  @override
  _FaceScannerScreenState createState() => _FaceScannerScreenState();
}

class _FaceScannerScreenState extends State<FaceScannerScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isScanning = false;
  String _userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userEmail = prefs.getString('userEmail') ?? '';
    });
  }

  Future<void> _authenticateWithBiometrics() async {
    try {
      setState(() {
        _isScanning = true;
      });

      final bool isAvailable = await _localAuth.canCheckBiometrics;
      if (!isAvailable) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Biometric authentication is not available on this device')),
        );
        return;
      }

      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access your account',
        options: AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (didAuthenticate) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Authentication successful!'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication failed: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        _isScanning = false;
      });
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('userEmail');
    await prefs.remove('userId');
    
    // Navigate back to previous screen or replace with your login screen
    Navigator.pop(context);
    // Alternative: Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Face Scanner',
          style: TextStyle(color: Color(0xFF1976D2)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Color(0xFF1976D2)),
            onPressed: _logout,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              
              // Welcome Message
              Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF1976D2),
                ),
              ),
              SizedBox(height: 8),
              Text(
                _userEmail,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                ),
              ),
              
              SizedBox(height: 80),
              
              // Face Scanner Animation
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _isScanning ? Color(0xFF4CAF50) : Color(0xFF1976D2),
                    width: 4,
                  ),
                ),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isScanning ? Color(0xFF4CAF50).withOpacity(0.1) : Color(0xFF1976D2).withOpacity(0.1),
                  ),
                  child: Icon(
                    _isScanning ? Icons.face_retouching_natural : Icons.face,
                    size: 120,
                    color: _isScanning ? Color(0xFF4CAF50) : Color(0xFF1976D2),
                  ),
                ),
              ),
              
              SizedBox(height: 40),
              
              // Status Text
              Text(
                _isScanning ? 'Scanning your face...' : 'Ready to scan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: _isScanning ? Color(0xFF4CAF50) : Color(0xFF1976D2),
                ),
              ),
              
              SizedBox(height: 8),
              
              Text(
                _isScanning ? 'Please look at the camera' : 'Tap the button below to authenticate',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                ),
              ),
              
              Spacer(),
              
              // Scan Button
              Container(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isScanning ? null : _authenticateWithBiometrics,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1976D2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: _isScanning
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          'Authenticate with Face',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              ),
              
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}