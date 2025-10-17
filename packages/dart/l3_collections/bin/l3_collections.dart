void main() {
  // List
  final numbers = <int>[3, 1, 2, 2, 5, 4];
  numbers.sort();
  print('sorted: $numbers');

  final doubled = numbers.map((n) => n * 2).toList();
  final evens = numbers.where((n) => n.isEven).toList();
  print('doubled: $doubled');
  print('evens: $evens');

  // Set (unique)
  final unique = numbers.toSet();
  print('unique: $unique');

  // Map
  final users = [
    {'id': 1, 'name': 'A'},
    {'id': 2, 'name': 'B'},
    {'id': 3, 'name': 'C'},
  ];
  final byId = {for (final u in users) u['id'] as int: u['name'] as String};
  print('byId: $byId');

  // Fold
  final sum = numbers.fold<int>(0, (acc, n) => acc + n);
  print('sum: $sum');

  // Collection if / spread / for
  final includeExtras = true;
  final view = [
    0,
    ...numbers,
    if (includeExtras) ...[99, 100],
    for (final n in numbers) n * 10,
  ];
  print('view: $view');
}
