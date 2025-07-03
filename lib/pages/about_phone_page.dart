import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutPhonePage extends StatelessWidget {
  const AboutPhonePage({Key? key}) : super(key: key);

  String _calculateUptime() {
    final startDate = DateTime(2023, 12, 27);
    final currentDate = DateTime.now();
    final difference = currentDate.difference(startDate);
    
    final days = difference.inDays;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;
    
    return '$days days, $hours hours, $minutes minutes';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Color(0xFF121212),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'About phone',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Phone image and basic info
            Container(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  // Phone illustration
                  Container(
                    width: 120,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xFF2A2A2A), width: 2),
                    ),
                    child: Stack(
                      children: [
                        // Screen
                        Positioned.fill(
                          child: Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFF0D47A1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        // Samsung logo
                        Positioned(
                          top: 20,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Text(
                              'SAMSUNG',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Galaxy S24 Ultra',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'SM-S928B',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            // Device information sections
            _buildSection('Device information', [
              _buildInfoRow('Device name', 'Galaxy S24 Ultra'),
              _buildInfoRow('Model number', 'SM-S928B'),
              _buildInfoRow('Serial number', '123456789ABCDEF'),
              _buildInfoRow('IMEI', '123456789012345'),
              _buildInfoRow('IMEI 2', '123456789012346'),
              _buildInfoRow('Uptime', _calculateUptime()),
            ]),
            
            _buildSection('Software information', [
              _buildInfoRow('Android version', '14'),
              _buildInfoRow('One UI version', '6.1'),
              _buildInfoRow('Security patch level', 'January 1, 2025'),
              _buildInfoRow('Baseband version', 'S928BXXU1AXL2'),
              _buildInfoRow('Kernel version', '5.15.123-android13-9-o'),
              _buildInfoRow('Build number', 'TP1A.220624.014.S928BXXU1AXL2'),
              _buildInfoRow('SE for Android status', 'Enforcing'),
              _buildInfoRow('Knox version', 'Knox 3.10.1, API level 37'),
            ]),
            
            _buildSection('Battery information', [
              _buildInfoRow('Status', 'Not charging'),
              _buildInfoRow('Power source', 'Battery'),
              _buildInfoRow('Level', '67%'),
              _buildInfoRow('Health', 'Good'),
              _buildInfoRow('Temperature', '29.0°C'),
              _buildInfoRow('Technology', 'Li-ion'),
            ]),
            
            _buildSection('Connection information', [
              _buildInfoRow('Request date', 'May 3, 2024'),
              _buildInfoRow('Connection date', 'June 27, 2024'),
              _buildInfoRow('Connection ack date', 'July 2, 2025'),
            ]),
            
            _buildSection('Legal information', [
              _buildActionRow('Open source licenses', () {}),
              _buildActionRow('Google Play system update', () {}),
              _buildActionRow('Software update', () {}),
            ]),
            
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              title,
              style: TextStyle(
                color: Color(0xFF4285F4),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFF2A2A2A), width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionRow(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFF2A2A2A), width: 0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

// Usage in your app
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Samsung About Phone',
      theme: ThemeData.dark(),
      home: AboutPhonePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}