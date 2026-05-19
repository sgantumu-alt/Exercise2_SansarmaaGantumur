# Exercise2_SansarmaaGantumur
# MEMORY MATCHING FLUTTER GAME

## Overview
This project presents the design and implementation of a Memory Matching Game developed using Flutter and Dart.

The application is a mobile-based game where players flip cards and try to find matching image pairs within the least number of moves possible.

---

## Features
- Functional memory matching gameplay
- Interactive card-flipping animations
- Move counter tracking
- Winning popup dialog
- Restart functionality
- Responsive UI design
- Android device compatibility

---

## Technology Stack

| Technology | Purpose |
|------------|----------|
| Flutter | Cross-platform mobile framework |
| Dart | Programming language |
| Android Studio | Development environment |
| Material Design | UI components and styling |

---

## Requirements
- Flutter SDK
- Dart SDK
- Android Studio
- Android Emulator or Android device

---

## Game Logic

The following logic is implemented:

1. Create image pairs
2. Shuffle cards randomly
3. Detect player taps
4. Compare selected cards
5. Update matched status
6. Track move count
7. Detect game completion
8. Show winning dialog

---

## Functionalities

### Card Matching
- Matching cards remain opened
- Incorrect cards automatically flip back

### Move Counter
- Every move increases the counter

### Winning Detection
When all cards are matched:
- Winning popup appears
- Total moves displayed
- Replay option available

### Restart Feature
The restart button resets:
- Move count
- Matched cards
- Shuffled board

---

## Project Structure

```text
lib/
├── main.dart
├── screens/
│   └── game_screen.dart
├── widgets/
│   └── memory_card.dart
├── models/
│   └── card_model.dart
└── assets/
    └── images/
```

---

## Responsive Design
The application uses:
- GridView
- Expanded widgets
- MediaQuery
- Flexible spacing

Compatible with:
- Android phones
- Tablets
- Different screen resolutions

---

## Testing
Tested using:
- Android Emulator (Pixel 9 Pro)
- Flutter Hot Reload
- Multiple screen sizes

---

## Challenges Faced
- Managing asynchronous card flipping
- Preventing rapid taps
- Updating game state correctly
- Creating responsive layouts

---

## Future Improvements
- Difficulty levels
- Timer mode
- Sound effects
- Leaderboard
- Multiplayer support
- Additional themes

---

## Conclusion
This project demonstrates Flutter and Dart mobile application development through an interactive and responsive Memory Matching Game.

The application satisfies assignment requirements by providing:
- Functional Flutter implementation
- Responsive UI
- Interactive gameplay
- Android compatibility
- Professional application structure

---

## GitHub Repository
[View Project on GitHub](https://github.com/sgantumu-alt/Exercise2_SansarmaaGantumur/tree/main)

---

## Author
Sansarmaa Gantumur