class UserAuth {
  final String? uid;
  UserAuth({required this.uid});
}

class UserData {
  final String? uid;
  final String? name;
  final String? sugars;
  final int? strength;

  UserData({
    required this.name,
    required this.sugars,
    required this.strength,
    required this.uid,
  });
}
