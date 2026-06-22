import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'exercise_list_screen.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {
      'title': 'Chest',
      'icon': Icons.sports_gymnastics,
      'color': Colors.blueAccent,
    },
    {
      'title': 'Arms',
      'icon': Icons.fitness_center,
      'color': Colors.redAccent,
    },
    {
      'title': 'Legs',
      'icon': Icons.directions_walk,
      'color': Colors.green,
    },
    {
      'title': 'Cardio',
      'icon': Icons.directions_run,
      'color': Colors.orange,
    },
    {
      'title': 'Full Body',
      'icon': Icons.accessibility_new,
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Categories'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ExerciseListScreen(
                    categoryTitle: category['title'],
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Card(
              elevation: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (category['color'] as Color).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      category['icon'],
                      size: 40,
                      color: category['color'],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    category['title'],
                    style: Theme.of(context).textTheme.titleMedium,
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
