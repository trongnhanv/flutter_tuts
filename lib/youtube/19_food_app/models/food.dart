import 'dart:math';

enum Complexity { simple, medium, hard }

class Food {
  final int id;
  final String name;
  final String url;
  int categoryId;
  final Duration? duration;
  final Complexity? complexity;
  final List<String>? ingredients;

  Food({
    required this.name,
    required this.categoryId,
    this.duration,
    this.complexity,
    this.ingredients,
  })  : id = randomId,
        url = 'https://picsum.photos/id/$randomId/500/500';

  static int get randomId => Random().nextInt(100);

  String get complexityString {
    switch (complexity) {
      case Complexity.simple:
        return "Simple";
      case Complexity.medium:
        return "Medium";
      case Complexity.hard:
        return "Hard";
      default:
        return "";
    }
  }
}
