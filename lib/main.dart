import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MemoryMatchApp());
}

class MemoryMatchApp extends StatelessWidget {
  const MemoryMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memory Match',
      theme: ThemeData(useMaterial3: true),
      home: const MemoryGameScreen(),
    );
  }
}

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  State<MemoryGameScreen> createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  final List<String> icons = [
    '🍓', '🍓',
    '🍋', '🍋',
    '🍉', '🍉',
    '🥝', '🥝',
    '🍇', '🍇',
    '🍍', '🍍',
    '🥥', '🥥',
    '🍒', '🍒',
  ];

  late List<String> cards;
  late List<bool> flipped;
  late List<bool> matched;

  int? firstIndex;
  int? secondIndex;
  int moves = 0;
  int matches = 0;
  bool busy = false;

  @override
  void initState() {
    super.initState();
    restartGame();
  }

  void restartGame() {
    cards = List.from(icons)..shuffle(Random());
    flipped = List.filled(cards.length, false);
    matched = List.filled(cards.length, false);
    firstIndex = null;
    secondIndex = null;
    moves = 0;
    matches = 0;
    busy = false;
    setState(() {});
  }

  void flipCard(int index) {
    if (busy || flipped[index] || matched[index]) return;

    setState(() {
      flipped[index] = true;
    });

    if (firstIndex == null) {
      firstIndex = index;
    } else {
      secondIndex = index;
      moves++;
      checkMatch();
    }
  }

  void checkMatch() {
    busy = true;

    if (cards[firstIndex!] == cards[secondIndex!]) {
      Future.delayed(const Duration(milliseconds: 450), () {
        setState(() {
          matched[firstIndex!] = true;
          matched[secondIndex!] = true;
          matches++;
          firstIndex = null;
          secondIndex = null;
          busy = false;
        });

        if (matches == icons.length ~/ 2) {
          showWinDialog();
        }
      });
    } else {
      Future.delayed(const Duration(milliseconds: 850), () {
        setState(() {
          flipped[firstIndex!] = false;
          flipped[secondIndex!] = false;
          firstIndex = null;
          secondIndex = null;
          busy = false;
        });
      });
    }
  }

  void showWinDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('🎉 You Won!'),
        content: Text('Great job! You completed the game in $moves moves.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              restartGame();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFDE68A),
              Color(0xFFFBCFE8),
              Color(0xFFC4B5FD),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: restartGame,
                          icon: const Icon(Icons.refresh_rounded),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.65),
                          ),
                        ),
                        const Column(
                          children: [
                            Text(
                              'Memory Match',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF4C1D95),
                              ),
                            ),
                            Text(
                              'Find all matching pairs',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6D28D9),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.touch_app_rounded, size: 18),
                              const SizedBox(width: 5),
                              Text(
                                '$moves',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Expanded(
                      child: GridView.builder(
                        itemCount: cards.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => flipCard(index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOutBack,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                gradient: flipped[index] || matched[index]
                                    ? const LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Color(0xFFFFFBEB),
                                  ],
                                )
                                    : const LinearGradient(
                                  colors: [
                                    Color(0xFF8B5CF6),
                                    Color(0xFFEC4899),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.18),
                                    blurRadius: 10,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  child: flipped[index] || matched[index]
                                      ? Text(
                                    cards[index],
                                    key: ValueKey(cards[index] + '$index'),
                                    style: const TextStyle(fontSize: 38),
                                  )
                                      : const Text(
                                    '?',
                                    key: ValueKey('hidden'),
                                    style: TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.65),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Matches: $matches / ${icons.length ~/ 2}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF4C1D95),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}