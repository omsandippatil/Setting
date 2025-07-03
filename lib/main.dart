import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Import all pages (you'll need to create these files)
// import 'pages/search_page.dart';
// import 'pages/more_menu_page.dart';
  import 'login/samsung_account_page.dart';
// import 'pages/connections_page.dart';
// import 'pages/sounds_and_vibration_page.dart';
// import 'pages/notifications_page.dart';
// import 'pages/display_page.dart';
// import 'pages/wallpaper_and_style_page.dart';
// import 'pages/home_screen_page.dart';
// import 'pages/lock_screen_page.dart';
// import 'pages/biometrics_and_security_page.dart';
// import 'pages/privacy_page.dart';
// import 'pages/location_page.dart';
   import 'pages/accounts_and_backup_page.dart';
// import 'pages/samsung_cloud_page.dart';
// import 'pages/general_management_page.dart';
   import 'pages/accessibility_page.dart';
// import 'pages/software_update_page.dart';
// import 'pages/developer_options_page.dart';
  import 'pages/about_phone_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(primary: Colors.blue),
        scaffoldBackgroundColor: Color(0xFF000000),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF000000),
          foregroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Color(0xFF000000),
          shadowColor: Colors.transparent,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xFF000000),
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),
      ),
      home: SettingsPage(),
      debugShowCheckedModeBanner: false,
      // Add routes here when you create the page files
      routes: {
        '/search': (context) => PlaceholderPage(title: 'Search'),
        '/more_menu': (context) => PlaceholderPage(title: 'More Menu'),
        '/samsung_account': (context) => LoginScreen(),
        '/connections': (context) => PlaceholderPage(title: 'Connections'),
        '/sounds_and_vibration': (context) => PlaceholderPage(title: 'Sounds and Vibration'),
        '/notifications': (context) => PlaceholderPage(title: 'Notifications'),
        '/display': (context) => PlaceholderPage(title: 'Display'),
        '/wallpaper_and_style': (context) => PlaceholderPage(title: 'Wallpaper and Style'),
        '/home_screen': (context) => PlaceholderPage(title: 'Home Screen'),
        '/lock_screen': (context) => PlaceholderPage(title: 'Lock Screen'),
        '/biometrics_and_security': (context) => PlaceholderPage(title: 'Biometrics and Security'),
        '/privacy': (context) => PlaceholderPage(title: 'Privacy'),
        '/location': (context) => PlaceholderPage(title: 'Location'),
        '/accounts_and_backup': (context) => AccountsAndBackupPage(),
        '/samsung_cloud': (context) => PlaceholderPage(title: 'Samsung Cloud'),
        '/general_management': (context) => PlaceholderPage(title: 'General Management'),
        '/accessibility': (context) => const AccessibilityPage(),
        '/software_update': (context) => PlaceholderPage(title: 'Software Update'),
        '/developer_options': (context) => PlaceholderPage(title: 'Developer Options'),
        '/about_phone': (context) => const AboutPhonePage(),
      },
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<SettingsItem> _filteredItems = [];
  List<SettingsItem> _allItems = [];

  @override
  void initState() {
    super.initState();
    _initializeItems();
    _filteredItems = _allItems;
  }

  void _initializeItems() {
    _allItems = [
      SettingsItem(
        icon: Icons.wifi,
        title: 'Connections',
        subtitle: 'Wi-Fi, Bluetooth, Mobile networks',
        color: Color(0xFF4CAF50),
        route: '/connections',
      ),
      SettingsItem(
        icon: Icons.volume_up,
        title: 'Sounds and vibration',
        subtitle: 'Sound mode, Ringtone, Vibration',
        color: Color(0xFF2196F3),
        route: '/sounds_and_vibration',
      ),
      SettingsItem(
        icon: Icons.notifications,
        title: 'Notifications',
        subtitle: 'App notifications, Do not disturb',
        color: Color(0xFFFF9800),
        route: '/notifications',
      ),
      SettingsItem(
        icon: Icons.smartphone,
        title: 'Display',
        subtitle: 'Screen brightness, Dark mode, Font',
        color: Color(0xFF9C27B0),
        route: '/display',
      ),
      SettingsItem(
        icon: Icons.wallpaper,
        title: 'Wallpaper and style',
        subtitle: 'Wallpapers, Themes, Icons',
        color: Color(0xFFE91E63),
        route: '/wallpaper_and_style',
      ),
      SettingsItem(
        icon: Icons.home,
        title: 'Home screen',
        subtitle: 'Layout, App drawer, Widgets',
        color: Color(0xFF00BCD4),
        route: '/home_screen',
      ),
      SettingsItem(
        icon: Icons.lock,
        title: 'Lock screen',
        subtitle: 'Screen lock, Always on display',
        color: Color(0xFF607D8B),
        route: '/lock_screen',
      ),
      SettingsItem(
        icon: Icons.fingerprint,
        title: 'Biometrics and security',
        subtitle: 'Face unlock, Fingerprint, Security',
        color: Color(0xFFFF5722),
        route: '/biometrics_and_security',
      ),
      SettingsItem(
        icon: Icons.privacy_tip,
        title: 'Privacy',
        subtitle: 'Permissions, Account privacy',
        color: Color(0xFF3F51B5),
        route: '/privacy',
      ),
      SettingsItem(
        icon: Icons.location_on,
        title: 'Location',
        subtitle: 'App location permissions',
        color: Color(0xFFF44336),
        route: '/location',
      ),
      SettingsItem(
        icon: Icons.account_circle,
        title: 'Accounts and backup',
        subtitle: 'Manage accounts, Backup data',
        color: Color(0xFF795548),
        route: '/accounts_and_backup',
      ),
      SettingsItem(
        icon: Icons.cloud,
        title: 'Samsung Cloud',
        subtitle: 'Sync and backup data',
        color: Color(0xFF03A9F4),
        route: '/samsung_cloud',
      ),
      SettingsItem(
        icon: Icons.language,
        title: 'General management',
        subtitle: 'Language, Time, Factory reset',
        color: Color(0xFF9E9E9E),
        route: '/general_management',
      ),
      SettingsItem(
        icon: Icons.accessibility,
        title: 'Accessibility',
        subtitle: 'Screen reader, Interaction control',
        color: Color(0xFF4CAF50),
        route: '/accessibility',
      ),
      SettingsItem(
        icon: Icons.system_update,
        title: 'Software update',
        subtitle: 'Download and install',
        color: Color(0xFF2196F3),
        route: '/software_update',
      ),
      SettingsItem(
        icon: Icons.developer_mode,
        title: 'Developer options',
        subtitle: 'USB debugging, Animation scale',
        color: Color(0xFFFF9800),
        route: '/developer_options',
      ),
      SettingsItem(
        icon: Icons.phone_android,
        title: 'About phone',
        subtitle: 'Status, Legal information',
        color: Color(0xFF607D8B),
        route: '/about_phone',
      ),
    ];
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = _allItems;
      } else {
        _filteredItems = _allItems.where((item) {
          return item.title.toLowerCase().contains(query.toLowerCase()) ||
                 item.subtitle.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _navigateToPage(String route) {
    Navigator.pushNamed(context, route);
  }

  void _showMoreMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF1C1C1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.help_outline, color: Colors.white),
              title: Text('Help', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                // Add help functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback, color: Colors.white),
              title: Text('Send feedback', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                // Add feedback functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.white),
              title: Text('About', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                // Add about functionality
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xFF000000),
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Color(0xFF000000),
        shadowColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xFF000000),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () => _navigateToPage('/search'),
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: _showMoreMenu,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _filterItems,
              decoration: InputDecoration(
                hintText: 'Search settings',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          
          // Samsung account section
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () => _navigateToPage('/samsung_account'),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(Icons.person, color: Colors.white, size: 28),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Samsung account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Sign in to sync your data',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey[400]),
                ],
              ),
            ),
          ),

          // Settings items list
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return _buildSettingsItem(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(SettingsItem item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: item.color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            item.icon,
            color: item.color,
            size: 24,
          ),
        ),
        title: Text(
          item.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 2),
          child: Text(
            item.subtitle,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 13,
            ),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.grey[500],
          size: 18,
        ),
        onTap: () => _navigateToPage(item.route),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

// Settings item model
class SettingsItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final String route;

  SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.route,
  });
}

// Placeholder page for routes that haven't been implemented yet
class PlaceholderPage extends StatelessWidget {
  final String title;

  const PlaceholderPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color(0xFF000000),
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Color(0xFF000000),
        shadowColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xFF000000),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              '$title Page',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'This page is under construction',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}