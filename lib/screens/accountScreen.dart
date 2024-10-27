import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart'; // Import share package
import 'package:provider/provider.dart';
import 'package:alzimerapp/provider/provider.dart'; // Import the theme provider

class AccountInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: Color(0xFFEADDFF),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Color(0xFF4F378A),
                        child:
                            Icon(Icons.person, size: 50, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(
                                  fontFamily: 'Belleza',
                                  fontSize: 20,
                                  color: Color(0xFF26093F),
                                ),
                              ),
                              Spacer(),
                              PopupMenuButton<String>(
                                icon: Icon(Icons.more_vert),
                                onSelected: (value) {
                                  if (value == 'delete') {
                                    _showDeleteConfirmationDialog(context);
                                  } else if (value == 'logout') {
                                    _showLogoutConfirmationDialog(context);
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem<String>(
                                      value: 'delete',
                                      child: Text('Delete Account'),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'logout',
                                      child: Text('Log Out'),
                                    ),
                                  ];
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Email Address',
                            style: TextStyle(
                              fontFamily: 'Belleza',
                              fontSize: 20,
                              color: Color(0xFF26093F),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),

                // Set Notifications Button
                buildButton(
                  label: 'Set Notifications',
                  icon: Icons.notifications,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SetNotificationsPage()),
                    );
                  },
                ),

                // Terms & Conditions Button
                buildButton(
                  label: 'Terms & Conditions',
                  icon: Icons.article,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsConditionsPage()),
                    );
                  },
                ),

                // Settings Button
                buildButton(
                  label: 'Settings',
                  icon: Icons.settings,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),

                // Rate Us Button
                buildButton(
                  label: 'Rate Us',
                  icon: Icons.star_rate,
                  onPressed: () {
                    _rateUs();
                  },
                ),

                // Share with Friends Button
                buildButton(
                  label: 'Share with Friends',
                  icon: Icons.share,
                  onPressed: () {
                    _shareApp();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper Method to Create Each Button
  // Helper Method to Create Each Button
  Widget buildButton({
    required String label,
    required IconData icon,
    Function()? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F3),
            borderRadius: BorderRadius.circular(10), // Reduced border radius
            border: Border.all(
              // Outline border
              color: Colors.purple.withOpacity(0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Belleza',
                  fontSize: 22,
                  color: Colors.deepPurple,
                ),
              ),
              Spacer(),
              Padding(
                padding:
                    const EdgeInsets.only(right: 20), // Added right padding
                child: Icon(
                  icon,
                  size: 35,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _shareApp() {
    Share.share('Check out this amazing app! [Insert App Link]');
  }

  void _rateUs() {
    // This would open the app store or play store link for rating the app
    // Replace '[Insert App Store Link]' with your app store link
    print('Redirecting to App Store/Play Store...');
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text(
              'Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle account deletion logic here
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Account deleted')),
                );
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logged out')),
                );
              },
              child: Text('Log Out'),
            ),
          ],
        );
      },
    );
  }
}

class SetNotificationsPage extends StatefulWidget {
  @override
  _SetNotificationsPageState createState() => _SetNotificationsPageState();
}

class _SetNotificationsPageState extends State<SetNotificationsPage> {
  bool _notificationsEnabled = true; // Default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Enable Notifications'),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            // Add more notification settings options if needed
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to save notification settings can be added here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Notification settings saved')),
                );
                Navigator.of(context).pop(); // Go back after saving
              },
              child: Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class TermsConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'These are the terms and conditions for using this app. By using this app, you agree to all the terms stated here. [Insert detailed text here].',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Dark Mode'),
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value;
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                });
              },
            ),
            ListTile(
              title: Text('Fonts'),
              trailing: Icon(Icons.font_download),
              onTap: () {
                // Handle font changes
              },
            ),
          ],
        ),
      ),
    );
  }
}
