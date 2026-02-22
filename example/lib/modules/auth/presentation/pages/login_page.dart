import 'package:flutter/material.dart';
import 'package:fkappa/fkappa.dart';

class LoginPage extends StatelessWidget with FKappaSpacing {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FKappaAppBar(title: Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(FKappaSpacing.medium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_outline, size: 80, color: Colors.blue),
              FKappaSpacing.mediumV,
              const Text('Welcome to FKappa!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              FKappaSpacing.mediumV,
              const FKappaTextField(label: 'Email', placeholder: 'user@kappa.io'),
              FKappaSpacing.smallV,
              const FKappaTextField(label: 'Password', obscureText: true),
              FKappaSpacing.largeV,
              FKappaButton(
                label: 'Login',
                onPressed: () async {
                  // 1. Show Global Loader
                  FKappaLoading.show();

                  // 2. Simulate Network Request
                  await Future.delayed(const Duration(seconds: 2));

                  // 3. Hide Global Loader
                  FKappaLoading.hide();

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
