import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart'; // Import share package
import 'package:provider/provider.dart';
import 'package:alzimerapp/provider/provider.dart'; // Import the theme provider
import 'package:google_fonts/google_fonts.dart';
import 'package:alzimerapp/provider/fontprovider.dart'; // Import the FontProvider

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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
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
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                  context: context,
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
                  context: context,
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
                  context: context,
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
                  context: context,
                  label: 'Rate Us',
                  icon: Icons.star_rate,
                  onPressed: () {
                    _rateUs();
                  },
                ),

                // Share with Friends Button
                buildButton(
                  context: context,
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
  Widget buildButton({
    required String label,
    required IconData icon,
    BuildContext? context,
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
                style: Theme.of(context!).textTheme.bodyLarge?.copyWith(
                      fontSize: 22,
                      color: Colors.deepPurple,
                    ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20),
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
        title: Consumer<FontProvider>(
          builder: (context, fontProvider, child) {
            return Text(
              'Notification Settings',
              style: GoogleFonts.getFont(
                fontProvider.currentFont,
                fontSize: 20,
                fontWeight: FontWeight.bold, // Or any other style you prefer
              ),
            );
          },
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Consumer<FontProvider>(
                builder: (context, fontProvider, child) {
                  return Text(
                    'Enable Notifications',
                    style: GoogleFonts.getFont(
                      fontProvider.currentFont,
                      fontSize: 18,
                    ),
                  );
                },
              ),
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
              child: Consumer<FontProvider>(
                builder: (context, fontProvider, child) {
                  return Text(
                    'Save Settings',
                    style: GoogleFonts.getFont(
                      fontProvider.currentFont,
                      fontSize: 18,
                    ),
                  );
                },
              ),
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
        title: Consumer<FontProvider>(
          builder: (context, fontProvider, child) {
            return Text(
              'Terms and Conditions',
              style: GoogleFonts.getFont(
                fontProvider.currentFont,
                fontSize: 20,
                fontWeight:
                    FontWeight.bold, // You can adjust the style as needed
              ),
            );
          },
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<FontProvider>(
          builder: (context, fontProvider, child) {
            return Text(
              'These are the terms and conditions for using this app. By using this app, you agree to all the terms stated here. [Insert detailed text here].',
              style: GoogleFonts.getFont(
                fontProvider.currentFont,
                fontSize: 16,
              ),
            );
          },
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
        title: Consumer<FontProvider>(
          builder: (context, fontProvider, child) {
            return Text(
              'Settings',
              style: GoogleFonts.getFont(
                fontProvider.currentFont,
                fontSize: 20,
                fontWeight:
                    FontWeight.bold, // You can adjust the style as needed
              ),
            );
          },
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                  // Update the theme based on dark mode setting
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                });
              },
            ),
            ListTile(
              title: Text('Change Font'),
              trailing: Icon(Icons.font_download),
              onTap: () {
                // Show a dialog to select a font
                _showFontDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Dialog to select a font
  void _showFontDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Font'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Roboto'),
                onTap: () {
                  Provider.of<FontProvider>(context, listen: false)
                      .setFont('Roboto');

//show snakbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Font changed to Roboto')),
                  );

                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Lato'),
                onTap: () {
                  Provider.of<FontProvider>(context, listen: false)
                      .setFont('Lato');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Font changed to Lato')),
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Poppins'),
                onTap: () {
                  Provider.of<FontProvider>(context, listen: false)
                      .setFont('Poppins');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Font changed to Poppins')),
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
