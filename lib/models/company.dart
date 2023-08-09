class Company {
  final String id;
  final String companyName;
  final String address;
  final String email;
  final String phoneNumber;
  final bool isActive;
  // Anda bisa menambahkan atribut lain seperti created_at, updated_at, dsb jika diperlukan.

  Company({
    required this.id,
    required this.companyName,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.isActive,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      companyName: json['company_name'],
      address: json['address'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      isActive: json['is_active'],
    );
  }
}
