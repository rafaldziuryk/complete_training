import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation_basic/screens/push_screen.dart';
import 'package:navigation_basic/screens/push_replacement_screen.dart';
import 'package:navigation_basic/screens/push_and_remove_until_screen.dart';
import 'package:navigation_basic/screens/fullscreen_dialog_screen.dart';
import 'package:navigation_basic/screens/value_return_screen.dart';
import 'package:navigation_basic/widgets/custom_dialog.dart';
import 'package:navigation_basic/widgets/custom_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Basic Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Podstawowe metody nawigacji
            _buildNavigationButton(
              context,
              'Push - Dodaj nowy ekran',
              () => _navigateToPushScreen(context),
            ),

            _buildNavigationButton(
              context,
              'Push Replacement - Zamień obecny ekran',
              () => _navigateToPushReplacementScreen(context),
            ),

            _buildNavigationButton(
              context,
              'Push and Remove Until - Usuń poprzednie ekrany',
              () => _navigateToPushAndRemoveUntilScreen(context),
            ),

            _buildNavigationButton(
              context,
              'Value Return - Przekazywanie wartości',
              () => _navigateToValueReturnScreen(context),
            ),

            const SizedBox(height: 20),

            // Modalne ekrany
            const Text(
              'Modalne ekrany',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            _buildNavigationButton(
              context,
              'Modal Bottom Sheet',
              () => _showModalBottomSheet(context),
            ),

            _buildNavigationButton(
              context,
              'Fullscreen Dialog',
              () => _navigateToFullscreenDialog(context),
            ),

            const SizedBox(height: 20),

            // Dialogi
            const Text(
              'Dialogi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            _buildNavigationButton(
              context,
              'Alert Dialog',
              () => _showAlertDialog(context),
            ),

            _buildNavigationButton(
              context,
              'Custom Dialog',
              () => _showCustomDialog(context),
            ),

            _buildNavigationButton(
              context,
              'Snackbar',
              () => _showSnackBar(context),
            ),

            _buildNavigationButton(
              context,
              'Pop',
              () => popScreen(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(
    BuildContext context,
    String title,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }

  // Metody nawigacji
  void _navigateToPushScreen(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const PushScreen(),
      ),
    );
  }

  void _navigateToPushReplacementScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const PushReplacementScreen(),
      ),
    );
  }

  void _navigateToPushAndRemoveUntilScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const PushAndRemoveUntilScreen(),
      ),
      (route) => false, // Usuwa wszystkie poprzednie ekrany
    );
  }

  void _navigateToFullscreenDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FullscreenDialogScreen(),
        fullscreenDialog: true, // Otwiera jako fullscreen dialog
      ),
    );
  }

  // Modalne ekrany
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const CustomBottomSheet(),
    );
  }

  // Dialogi
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert Dialog'),
        content: const Text('To jest przykładowy Alert Dialog.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Anuluj'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Zatwierdzono!')),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CustomDialog(),
    );
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          height: 300,
          child: const Text('To jest przykładowy SnackBar!'),
        ),
        action: SnackBarAction(
          label: 'Cofnij',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cofnięto!')),
            );
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void _navigateToValueReturnScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ValueReturnScreen(),
      ),
    );
  }

  void popScreen(BuildContext context) {
    Navigator.pop(
      context,
    );
  }
}
