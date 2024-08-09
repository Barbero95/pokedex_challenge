import 'dart:math';

class ShinyRandom {
  static bool get isShiny {
    final random = Random();
    // Probability of being shiny: 1 / 4096
    // Augmented probability to test shiny outcome
    return random.nextInt(3) == 0;
  }
}
