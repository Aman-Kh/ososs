class Shape {
  String name;
  String id;

  Shape({required this.id, required this.name});

  Shape.empty({
    this.id = '',
    this.name = '',
  });
}
