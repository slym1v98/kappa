import 'package:flutter/material.dart';
import 'package:fkappa/fkappa.dart' hide State;

class GalleryPage extends StatefulWidget with FKappaSpacing, FKappaResponsive {
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
      appBar: const FKappaAppBar(
        title: Text('fkappa UI Gallery'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(FKappaSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Smart Components', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            FKappaSpacing.mediumV,
            
            // Buttons
            const Text('Buttons', style: TextStyle(fontWeight: FontWeight.bold)),
            FKappaSpacing.smallV,
            Row(
              children: [
                FKappaButton(label: 'Active', onPressed: () {}),
                FKappaSpacing.smallH,
                FKappaButton(label: 'Loading', isLoading: true, onPressed: () {}),
              ],
            ),
            
            FKappaSpacing.mediumV,
            
            // TextFields
            const Text('Inputs', style: TextStyle(fontWeight: FontWeight.bold)),
            FKappaSpacing.smallV,
            FKappaTextField(
              label: 'Username',
              placeholder: 'Enter your name',
              controller: _textController,
            ),
            
            FKappaSpacing.mediumV,
            
            // Adaptive Controls
            const Text('Adaptive Controls', style: TextStyle(fontWeight: FontWeight.bold)),
            FKappaSpacing.smallV,
            FKappaCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Notification Switch'),
                      FKappaSwitch(
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
                        child: FKappaSlider(
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
            
            FKappaSpacing.mediumV,
            
            // List Tiles
            const Text('List Tiles', style: TextStyle(fontWeight: FontWeight.bold)),
            FKappaSpacing.smallV,
            FKappaListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile Settings'),
              subtitle: const Text('Manage your account info'),
              showChevron: true,
              onTap: () {
                FKappaDialog.show(
                  context: context,
                  title: 'Profile',
                  message: 'This is a FKappa native dialog!',
                );
              },
            ),
            
            FKappaSpacing.mediumV,
            
            // Loading
            const Text('Loading Indicators', style: TextStyle(fontWeight: FontWeight.bold)),
            FKappaSpacing.smallV,
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FKappaLoadingIndicator(),
                FKappaLoadingIndicator(radius: 20),
                FKappaLoadingIndicator(color: Colors.red),
              ],
            ),

            FKappaSpacing.extraLargeV,
            Center(
              child: TextButton(
                onPressed: () => context.go('/settings'),
                child: const Text('Back to Settings'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FKappaBottomNavigationBar(
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
