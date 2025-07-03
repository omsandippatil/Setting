import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(AppsPage());
}

class AppsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF121212),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF121212),
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      home: AppsSettingsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppsSettingsPage extends StatefulWidget {
  @override
  _AppsSettingsPageState createState() => _AppsSettingsPageState();
}

class _AppsSettingsPageState extends State<AppsSettingsPage> {
  final List<AppItem> systemApps = [
    AppItem('Chrome', 'com.android.chrome', Icons.language, '2.1 GB'),
    AppItem('Samsung Internet', 'com.sec.android.app.sbrowser', Icons.public, '1.2 GB'),
    AppItem('Gallery', 'com.sec.android.gallery3d', Icons.photo_library, '850 MB'),
    AppItem('Camera', 'com.sec.android.app.camera', Icons.camera_alt, '650 MB'),
    AppItem('Phone', 'com.samsung.android.dialer', Icons.phone, '420 MB'),
    AppItem('Messages', 'com.samsung.android.messaging', Icons.message, '380 MB'),
    AppItem('Samsung Health', 'com.sec.android.app.shealth', Icons.favorite, '1.5 GB'),
    AppItem('Samsung Pay', 'com.samsung.android.spay', Icons.payment, '320 MB'),
    AppItem('Samsung Notes', 'com.samsung.android.app.notes', Icons.note, '180 MB'),
    AppItem('Clock', 'com.sec.android.app.clockpackage', Icons.alarm, '95 MB'),
    AppItem('Calculator', 'com.sec.android.app.popupcalculator', Icons.calculate, '45 MB'),
    AppItem('Settings', 'com.android.settings', Icons.settings, '280 MB'),
  ];

  final List<AppItem> downloadedApps = [
    AppItem('WhatsApp', 'com.whatsapp', Icons.chat, '1.8 GB'),
    AppItem('Instagram', 'com.instagram.android', Icons.camera_enhance, '950 MB'),
    AppItem('YouTube', 'com.google.android.youtube', Icons.play_arrow, '1.2 GB'),
    AppItem('Netflix', 'com.netflix.mediaclient', Icons.movie, '750 MB'),
    AppItem('Spotify', 'com.spotify.music', Icons.music_note, '680 MB'),
    AppItem('Twitter', 'com.twitter.android', Icons.alternate_email, '420 MB'),
    AppItem('Telegram', 'org.telegram.messenger', Icons.send, '380 MB'),
    AppItem('Uber', 'com.ubercab', Icons.directions_car, '250 MB'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Apps',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // More options
            },
          ),
        ],
        backgroundColor: Color(0xFF121212),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Quick Actions Section
            Container(
              margin: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildQuickActionCard(
                      'App permissions',
                      Icons.security,
                      () {},
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionCard(
                      'Default apps',
                      Icons.apps,
                      () {},
                    ),
                  ),
                ],
              ),
            ),
            
            // Special Access Section
            _buildSectionHeader('Special access'),
            _buildSettingsItem(
              'Special app access',
              'Manage apps with special system access',
              Icons.admin_panel_settings,
              () {},
            ),
            _buildSettingsItem(
              'App permissions',
              'Control app permissions',
              Icons.security,
              () {},
            ),
            _buildSettingsItem(
              'Default apps',
              'Set default apps for actions',
              Icons.apps,
              () {},
            ),
            
            SizedBox(height: 24),
            
            // System Apps Section
            _buildSectionHeader('System apps (${systemApps.length})'),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: systemApps.length,
              itemBuilder: (context, index) {
                return _buildAppItem(systemApps[index]);
              },
            ),
            
            SizedBox(height: 24),
            
            // Downloaded Apps Section
            _buildSectionHeader('Downloaded apps (${downloadedApps.length})'),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: downloadedApps.length,
              itemBuilder: (context, index) {
                return _buildAppItem(downloadedApps[index]);
              },
            ),
            
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xFF2C2C2C)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Color(0xFF4A90E2), size: 28),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Color(0xFF4A90E2),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSettingsItem(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Color(0xFF4A90E2),
                size: 24,
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
                      color: Color(0xFF9E9E9E),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Color(0xFF9E9E9E),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppItem(AppItem app) {
    return InkWell(
      onTap: () {
        // Navigate to app details
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                app.icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    app.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    app.packageName,
                    style: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  app.size,
                  style: TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4),
                Icon(
                  Icons.chevron_right,
                  color: Color(0xFF9E9E9E),
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppItem {
  final String name;
  final String packageName;
  final IconData icon;
  final String size;

  AppItem(this.name, this.packageName, this.icon, this.size);
}