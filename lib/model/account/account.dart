enum Genders {
  male,
  female,
  others;

  @override
  String toString() {
    switch (this) {
      case male:
        return 'Male';
      case female:
        return 'Female';
      case others:
        return 'Others';
    }
  }
}
