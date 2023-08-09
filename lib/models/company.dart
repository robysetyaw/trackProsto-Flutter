class Company {
  final String companyName;
  final String address;
  final String email;
  final String phoneNumber;
  // Anda bisa menambahkan atribut lain seperti created_at, updated_at, dsb jika diperlukan.

  Company({
    required this.companyName,
    required this.address,
    required this.email,
    required this.phoneNumber,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyName: json['company_name'],
      address: json['address'],
      email: json['email'],
      phoneNumber: json['phone_number'],
    );
  }
}
