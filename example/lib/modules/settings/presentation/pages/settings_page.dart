import 'package:flutter/material.dart';
import 'package:fkappa/kappa.dart';
import '../bloc/settings_bloc.dart';
import '../../../../shared/services/i_auth_service.dart';

class SettingsPage extends StatelessWidget with KappaSpacing, KappaResponsive {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. LOOKUP public service from another module
    final auth = KappaServiceRegistry.get<IAuthService>();
    final userName = auth.getCurrentUserName();

    // 2. RESPONSIVE variables
    final fontSize = KappaResponsive.valueByBreakpoint(context, mobile: 18.0, tablet: 32.0);
    final isMobile = KappaResponsive.isMobile(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(KappaSpacing.medium),
        child: Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Text('Welcome, $userName!', style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
            KappaSpacing.mediumV,
            const Text('Persistence Demo (Tắt app mở lại vẫn lưu)'),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return SwitchListTile(
                  title: const Text('Dark Mode'),
                  value: state.isDarkMode,
                  onChanged: (val) => context.read<SettingsBloc>().add(val),
                );
              },
            ),
            KappaSpacing.largeV,
            KappaButton(
              label: 'Go to Counter',
              onPressed: () => context.go('/counter'),
            ),
            KappaSpacing.mediumV,
            KappaButton(
              label: 'View UI Gallery',
              color: Colors.blueGrey,
              onPressed: () => context.go('/gallery'),
            ),
            KappaSpacing.mediumV,
            KappaButton(
              label: 'Open Dashboard (Grid Layout)',
              color: Colors.indigo,
              onPressed: () => context.go('/dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
