import 'package:flutter/material.dart';
import 'package:fkappa/kappa.dart';

class LoginPage extends StatelessWidget with KappaSpacing {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KappaAppBar(title: Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(KappaSpacing.medium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_outline, size: 80, color: Colors.blue),
              KappaSpacing.mediumV,
              const Text('Welcome to Kappa!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              KappaSpacing.mediumV,
              const KappaTextField(label: 'Email', placeholder: 'user@kappa.io'),
              KappaSpacing.smallV,
              const KappaTextField(label: 'Password', obscureText: true),
              KappaSpacing.largeV,
              KappaButton(
                label: 'Login',
                onPressed: () async {
                  // 1. Show Global Loader
                  KappaLoading.show();

                  // 2. Simulate Network Request
                  await Future.delayed(const Duration(seconds: 2));

                  // 3. Hide Global Loader
                  KappaLoading.hide();

                  // 4. Navigate
                  if (context.mounted) context.go('/settings');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
