class Answer {
  final String text;
  final int score;

  Answer({required this.text, required this.score});
}

class QA {
  final String question;
  final List<Answer> answers;

  QA({required this.question, required this.answers});
}
