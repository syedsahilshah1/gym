import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import '../theme/app_theme.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Mini-Games'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _GameCard(
            title: '30-Second Tap Challenge',
            description: 'Test your speed! Tap as fast as you can.',
            icon: Icons.touch_app,
            color: Colors.blueAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const _TapGameScreen()),
              );
            },
          ),
          const SizedBox(height: 16),
          _GameCard(
            title: 'Reaction Color Tap',
            description: 'Tap when the screen turns green!',
            icon: Icons.speed,
            color: Colors.purpleAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const _ReactionGameScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _GameCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _GameCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 40, color: color),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 20,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- TAP GAME ---

class _TapGameScreen extends StatefulWidget {
  const _TapGameScreen();

  @override
  State<_TapGameScreen> createState() => _TapGameScreenState();
}

class _TapGameScreenState extends State<_TapGameScreen> {
  int score = 0;
  int timeLeft = 30;
  Timer? timer;
  bool isPlaying = false;

  void startGame() {
    setState(() {
      score = 0;
      timeLeft = 30;
      isPlaying = true;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        t.cancel();
        setState(() {
          isPlaying = false;
        });
        _showResultDialog();
      }
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Time\'s up!'),
        content: Text('You tapped $score times!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              startGame();
            },
            child: const Text('Play Again'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tap Challenge')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Time: $timeLeft',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 20),
            Text(
              'Score: $score',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppTheme.primaryBlue,
                  ),
            ),
            const SizedBox(height: 60),
            if (!isPlaying && timeLeft == 30)
              ElevatedButton(
                onPressed: startGame,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                ),
                child: const Text('START'),
              )
            else if (isPlaying)
              GestureDetector(
                onTap: () {
                  setState(() {
                    score++;
                  });
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'TAP!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            else
              ElevatedButton(
                onPressed: startGame,
                child: const Text('Play Again'),
              )
          ],
        ),
      ),
    );
  }
}

// --- REACTION GAME ---

class _ReactionGameScreen extends StatefulWidget {
  const _ReactionGameScreen();

  @override
  State<_ReactionGameScreen> createState() => _ReactionGameScreenState();
}

class _ReactionGameScreenState extends State<_ReactionGameScreen> {
  Color currentColor = Colors.redAccent;
  String message = 'Wait for green...';
  bool isPlaying = false;
  bool isReady = false;
  Timer? waitTimer;
  DateTime? startTime;
  String result = '';

  void startGame() {
    setState(() {
      currentColor = Colors.redAccent;
      message = 'Wait for green...';
      isPlaying = true;
      isReady = false;
      result = '';
    });
    
    final randomWait = Random().nextInt(4000) + 1000; // 1-5 seconds
    waitTimer = Timer(Duration(milliseconds: randomWait), () {
      setState(() {
        currentColor = AppTheme.primaryGreen;
        message = 'TAP NOW!';
        isReady = true;
        startTime = DateTime.now();
      });
    });
  }

  void handleTap() {
    if (!isPlaying) {
      startGame();
      return;
    }

    if (!isReady) {
      // Tapped too early
      waitTimer?.cancel();
      setState(() {
        isPlaying = false;
        currentColor = Colors.redAccent;
        message = 'Too early! Tap to retry.';
      });
    } else {
      // Tapped correctly
      final reactionTime = DateTime.now().difference(startTime!).inMilliseconds;
      setState(() {
        isPlaying = false;
        currentColor = Colors.blueAccent;
        message = 'Reaction time: $reactionTime ms\nTap to play again.';
      });
    }
  }

  @override
  void dispose() {
    waitTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reaction Game')),
      body: GestureDetector(
        onTap: handleTap,
        child: Container(
          color: isPlaying ? currentColor : Colors.white,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: isPlaying
              ? Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (message.contains('Reaction time'))
                      Icon(Icons.timer, size: 64, color: AppTheme.primaryBlue),
                    const SizedBox(height: 20),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: startGame,
                      child: const Text('Start'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
