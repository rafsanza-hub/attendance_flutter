import 'package:attendance_flutter/app/modules/login/controllers/login_controller.dart';
import 'package:attendance_flutter/core/constants/sizes.dart';
import 'package:attendance_flutter/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final LoginController _loginController = Get.find<LoginController>();
  String _selectedLanguage = 'Bahasa Indonesia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  // Body widget
  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace).copyWith(top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profil
            _buildProfileSection(context),
            const SizedBox(height: AppSizes.spaceBtwSections),
            // Pengaturan
            _buildSettingsSection(context),
            const SizedBox(height: AppSizes.spaceBtwSections),
            // Logout
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  // Profile section
  Widget _buildProfileSection(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                _loginController.currentUser.value?.photoURL ??
                    'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Text(
            _loginController.currentUser.value?.displayName ?? 'User',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            _loginController.currentUser.value?.email ?? 'user',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          SizedBox(
            width: 150,
            child: OutlinedButton(
              onPressed: () {},
              child: const Text('Edit Profil'),
            ),
          ),
        ],
      ),
    );
  }

  // Settings section
  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pengaturan',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        _buildLanguageTile(context),
        _buildDarkModeTile(context),
        _buildNotificationTile(context),
      ],
    );
  }

  // Language selection tile
  Widget _buildLanguageTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Iconsax.language_square),
      title: const Text('Bahasa'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_selectedLanguage),
          const SizedBox(width: AppSizes.sm),
          const Icon(Iconsax.arrow_right_3),
        ],
      ),
      onTap: _selectLanguage,
    );
  }

  // Dark mode toggle tile
  Widget _buildDarkModeTile(BuildContext context) {
    // Menggunakan GetX untuk mendeteksi tema saat ini
    final isDarkMode = Get.isDarkMode;

    return ListTile(
      leading: const Icon(Iconsax.moon),
      title: const Text('Mode Gelap'),
      trailing: Switch(
        value: isDarkMode,
        onChanged: _toggleTheme,
        activeColor: AppTheme.primaryDark,
      ),
    );
  }

  // Notification settings tile
  Widget _buildNotificationTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Iconsax.notification),
      title: const Text('Notifikasi'),
      trailing: const Icon(Iconsax.arrow_right_3),
      onTap: () {},
    );
  }

  // Logout button
  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: _logout,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red),
        ),
        child: const Text(
          'Logout',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  // Pilih bahasa method
  Future<void> _selectLanguage() async {
    final languages = ['Bahasa Indonesia', 'English', 'Español'];
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Pilih Bahasa'),
          children: languages.map((language) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, language);
              },
              child: Text(language),
            );
          }).toList(),
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedLanguage = result;
      });
    }
  }

  // Toggle theme method - menggunakan GetX untuk mengubah tema
  void _toggleTheme(bool value) {
    // Mengubah tema menggunakan GetX
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);

    // Tidak perlu menyimpan state karena GetX menghandle tema
    setState(() {
      // Dipanggil hanya untuk memperbarui UI
    });
  }

  // Logout method
  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _loginController.logout();
              print('User logged out');
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
