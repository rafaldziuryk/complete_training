sealed class Token {
  const Token();
}
final class NumberToken extends Token {
  final int value;
  const NumberToken(this.value) : super();
}
final class OpToken extends Token {
  final String op;
  const OpToken(this.op) : super();
}

(String, int) parse(String input) {
  // record return: (op, value)
  switch (input) {
    case '+':
      return ('op', 1);
    case '-':
      return ('op', -1);
    default:
      final v = int.tryParse(input) ?? 0;
      return ('num', v);
  }
}

String describe(Token t) => switch (t) {
  NumberToken(value: final v) when v > 0 => 'positive number: $v',
  NumberToken(value: final v) => 'number: $v',
  OpToken(op: '+' || '-') => 'operator: ${t.op}',
  _ => 'unknown',
};

void main() {
  final inputs = ['+', '-', '10', 'x'];
  for (final i in inputs) {
    final rec = parse(i);
    print('parse($i) => $rec');
  }

  final tokens = <Token>[const NumberToken(5), const NumberToken(-2), const OpToken('+')];
  for (final t in tokens) {
    print(describe(t));
  }
}
