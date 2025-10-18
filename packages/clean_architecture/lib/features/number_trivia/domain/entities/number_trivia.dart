/// Domain entity representing number trivia
class NumberTrivia {
  final String text;
  final int number;
  
  const NumberTrivia({
    required this.text,
    required this.number,
  });
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NumberTrivia && 
           other.text == text && 
           other.number == number;
  }
  
  @override
  int get hashCode => text.hashCode ^ number.hashCode;
  
  @override
  String toString() => 'NumberTrivia(text: $text, number: $number)';
}
