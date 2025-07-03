import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Samsung Settings',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF000000),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF000000),
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          // Profile Section
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0xFF1976D2),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Samsung Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'user@samsung.com',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                    ],
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
          
          Divider(
            color: Colors.grey[800],
            thickness: 1,
            height: 1,
          ),
          
          // Settings Items
          _buildSettingsItem(
            icon: Icons.wifi,
            title: 'Connections',
            subtitle: 'Wi-Fi, Bluetooth, Mobile networks',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.volume_up,
            title: 'Sounds and vibration',
            subtitle: 'Sound mode, Ringtone, System sounds',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'App notifications, Do not disturb',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.visibility,
            title: 'Display',
            subtitle: 'Brightness, Blue light filter, Screen timeout',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.wallpaper,
            title: 'Wallpaper and style',
            subtitle: 'Wallpapers, Themes, Icons',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.security,
            title: 'Security and privacy',
            subtitle: 'Screen lock, Face recognition, Fingerprints',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.location_on,
            title: 'Location',
            subtitle: 'App permissions, Location services',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.smartphone,
            title: 'Digital wellbeing',
            subtitle: 'Screen time, App limits, Focus mode',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.accessibility,
            title: 'Accessibility',
            subtitle: 'Vision, Hearing, Interaction and dexterity',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.battery_full,
            title: 'Battery',
            subtitle: 'Power saving, Battery usage',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.storage,
            title: 'Device care',
            subtitle: 'Battery, Storage, Memory, Security',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.apps,
            title: 'Apps',
            subtitle: 'App info, Default apps, App permissions',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.settings_backup_restore,
            title: 'Accounts and backup',
            subtitle: 'Samsung Cloud, Google, Smart Switch',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.update,
            title: 'Software update',
            subtitle: 'Download and install, Auto download',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.info,
            title: 'About phone',
            subtitle: 'Status, Legal information, Software information',
            onTap: () {},
          ),
          
          SizedBox(height: 20),
        ],
      ),
    );
  }
  
  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[800]!,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              child: Icon(
                icon,
                color: Colors.white,
                size: 22,
              ),
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
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
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