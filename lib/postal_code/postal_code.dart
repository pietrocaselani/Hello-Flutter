class PostalCode {
  final String postalCode;

  PostalCode(this.postalCode);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PostalCode &&
              runtimeType == other.runtimeType &&
              postalCode == other.postalCode;

  @override
  int get hashCode => postalCode.hashCode;
}