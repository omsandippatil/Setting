import 'package:flutter/material.dart';

class AccountsAndBackupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Accounts and backup',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            
            // Main title section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Accounts and backup',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Keep your information synced across your devices',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 32),
            
            // Accounts section
            _buildSection(
              title: 'Accounts',
              children: [
                _buildAccountItem(
                  icon: Icons.person_outline,
                  title: 'Samsung account',
                  subtitle: 'example@samsung.com',
                  hasSwitch: false,
                ),
                _buildAccountItem(
                  icon: Icons.email_outlined,
                  title: 'Google',
                  subtitle: 'example@gmail.com',
                  hasSwitch: false,
                ),
                _buildAccountItem(
                  icon: Icons.add_circle_outline,
                  title: 'Add account',
                  subtitle: null,
                  hasSwitch: false,
                ),
              ],
            ),
            
            SizedBox(height: 24),
            
            // Backup section
            _buildSection(
              title: 'Backup and restore',
              children: [
                _buildSettingItem(
                  icon: Icons.backup_outlined,
                  title: 'Back up data',
                  subtitle: 'Samsung Cloud',
                  hasSwitch: false,
                ),
                _buildSettingItem(
                  icon: Icons.restore_outlined,
                  title: 'Restore data',
                  subtitle: null,
                  hasSwitch: false,
                ),
              ],
            ),
            
            SizedBox(height: 24),
            
            // Samsung Cloud section
            _buildSection(
              title: 'Samsung Cloud',
              children: [
                _buildSettingItem(
                  icon: Icons.cloud_outlined,
                  title: 'Samsung Cloud',
                  subtitle: '2.1 GB of 15 GB used',
                  hasSwitch: false,
                ),
                _buildSettingItem(
                  icon: Icons.sync_outlined,
                  title: 'Sync and auto-backup settings',
                  subtitle: 'Contacts, Calendar, Samsung Notes',
                  hasSwitch: false,
                ),
              ],
            ),
            
            SizedBox(height: 24),
            
            // Google section
            _buildSection(
              title: 'Google',
              children: [
                _buildSettingItem(
                  icon: Icons.backup_outlined,
                  title: 'Back up to Google Drive',
                  subtitle: 'Last backup: Today, 2:30 PM',
                  hasSwitch: true,
                  switchValue: true,
                ),
                _buildSettingItem(
                  icon: Icons.restore_outlined,
                  title: 'Restore from Google Drive',
                  subtitle: null,
                  hasSwitch: false,
                ),
              ],
            ),
            
            SizedBox(height: 24),
            
            // Smart Switch section
            _buildSection(
              title: 'Smart Switch',
              children: [
                _buildSettingItem(
                  icon: Icons.swap_horiz_outlined,
                  title: 'Smart Switch',
                  subtitle: 'Transfer data from old device',
                  hasSwitch: false,
                ),
              ],
            ),
            
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildAccountItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required bool hasSwitch,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFF3A3A3A),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: Colors.white70, size: 22),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.grey[500],
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required bool hasSwitch,
    bool switchValue = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFF3A3A3A),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: Colors.white70, size: 22),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (hasSwitch)
            Switch(
              value: switchValue,
              onChanged: (value) {
                // Handle switch change
              },
              activeColor: Color(0xFF1976D2),
              inactiveTrackColor: Colors.grey[600],
            )
          else
            Icon(
              Icons.chevron_right,
              color: Colors.grey[500],
              size: 20,
            ),
        ],
      ),
    );
  }
}

// Usage example:
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Samsung Settings',
      theme: ThemeData.dark(),
      home: AccountsAndBackupPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void main() {
  runApp(MyApp());
}