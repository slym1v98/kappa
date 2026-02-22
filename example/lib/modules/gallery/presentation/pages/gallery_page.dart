import 'package:flutter/material.dart';
import 'package:kappa/kappa.dart' hide State;

class GalleryPage extends StatefulWidget with KappaSpacing, KappaResponsive {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  bool _switchValue = true;
  double _sliderValue = 0.5;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KappaAppBar(
        title: Text('Kappa UI Gallery'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(KappaSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Smart Components', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            KappaSpacing.mediumV,
            
            // Buttons
            const Text('Buttons', style: TextStyle(fontWeight: FontWeight.bold)),
            KappaSpacing.smallV,
            Row(
              children: [
                KappaButton(label: 'Active', onPressed: () {}),
                KappaSpacing.smallH,
                KappaButton(label: 'Loading', isLoading: true, onPressed: () {}),
              ],
            ),
            
            KappaSpacing.mediumV,
            
            // TextFields
            const Text('Inputs', style: TextStyle(fontWeight: FontWeight.bold)),
            KappaSpacing.smallV,
            KappaTextField(
              label: 'Username',
              placeholder: 'Enter your name',
              controller: _textController,
            ),
            
            KappaSpacing.mediumV,
            
            // Adaptive Controls
            const Text('Adaptive Controls', style: TextStyle(fontWeight: FontWeight.bold)),
            KappaSpacing.smallV,
            KappaCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Notification Switch'),
                      KappaSwitch(
                        value: _switchValue,
                        onChanged: (val) => setState(() => _switchValue = val),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Icon(Icons.volume_down),
                      Expanded(
                        child: KappaSlider(
                          value: _sliderValue,
                          onChanged: (val) => setState(() => _sliderValue = val),
                        ),
                      ),
                      const Icon(Icons.volume_up),
                    ],
                  ),
                ],
              ),
            ),
            
            KappaSpacing.mediumV,
            
            // List Tiles
            const Text('List Tiles', style: TextStyle(fontWeight: FontWeight.bold)),
            KappaSpacing.smallV,
            KappaListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile Settings'),
              subtitle: const Text('Manage your account info'),
              showChevron: true,
              onTap: () {
                KappaDialog.show(
                  context: context,
                  title: 'Profile',
                  message: 'This is a Kappa native dialog!',
                );
              },
            ),
            
            KappaSpacing.mediumV,
            
            // Loading
            const Text('Loading Indicators', style: TextStyle(fontWeight: FontWeight.bold)),
            KappaSpacing.smallV,
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                KappaLoadingIndicator(),
                KappaLoadingIndicator(radius: 20),
                KappaLoadingIndicator(color: Colors.red),
              ],
            ),

            KappaSpacing.extraLargeV,
            Center(
              child: TextButton(
                onPressed: () => context.go('/settings'),
                child: const Text('Back to Settings'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: KappaBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.palette), label: 'Gallery'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
