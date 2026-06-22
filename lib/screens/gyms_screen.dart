import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GymsScreen extends StatelessWidget {
  const GymsScreen({super.key});

  final List<Map<String, String>> _gyms = const [
    {
      'name': 'Powerhouse Fitness Center',
      'address': '123 Main St, New York, NY',
      'contact': '+1 234-567-8901',
    },
    {
      'name': 'Elite Athletics Gym',
      'address': '456 Broadway Ave, New York, NY',
      'contact': '+1 234-567-8902',
    },
    {
      'name': 'Iron Forge Barbell',
      'address': '789 5th Ave, New York, NY',
      'contact': '+1 234-567-8903',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Gyms'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: _gyms.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final gym = _gyms[index];
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryBlue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.location_city,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          gym['name']!,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: 18,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(gym['address']!),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(gym['contact']!),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.primaryBlue,
                        side: const BorderSide(color: AppTheme.primaryBlue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Get Directions'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
