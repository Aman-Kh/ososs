class User {
  String id;
  String name;

  User({required this.id, required this.name});

  User.empty({
    this.id = '',
    this.name = '',
  });
}
