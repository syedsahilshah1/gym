import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'exercise_detail_screen.dart';

class ExerciseListScreen extends StatelessWidget {
  final String categoryTitle;

  const ExerciseListScreen({super.key, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    // Dummy data for exercises
    final List<Map<String, String>> exercises = [
      {
        'title': 'Pushups',
        'reps': '3 sets of 10',
        'videoId': 'IODxDxX7oi4', // Dummy Youtube video ID
        'description': 'A classic exercise to build upper body strength.',
      },
      {
        'title': 'Dumbbell Press',
        'reps': '3 sets of 12',
        'videoId': 'xUm0BiZCWlQ',
        'description': 'Great for targeting the chest muscles.',
      },
      {
        'title': 'Chest Fly',
        'reps': '3 sets of 15',
        'videoId': 'eozdVDA78K0',
        'description': 'Helps to stretch and strengthen the pectoral muscles.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryTitle Exercises'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: exercises.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://img.youtube.com/vi/${exercise['videoId']}/0.jpg',
                  width: 80,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 80,
                    height: 60,
                    color: Colors.grey[300],
                    child: const Icon(Icons.video_library, color: Colors.grey),
                  ),
                ),
              ),
              title: Text(
                exercise['title']!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(exercise['reps']!),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExerciseDetailScreen(
                      title: exercise['title']!,
                      description: exercise['description']!,
                      reps: exercise['reps']!,
                      videoId: exercise['videoId']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
