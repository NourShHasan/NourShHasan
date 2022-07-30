extension StringExtensions on String {
  String get getFirstName {
    return this.split(' ').first;
  }
}
