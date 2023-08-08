class Customer {
  final String fullname;
  final String address;
  final String companyId;
  final String phoneNumber;
  final String createdAt;
  final String updatedAt;
  final String createdBy;
  final String updatedBy;
  final int debt;

  Customer({
    required this.fullname,
    required this.address,
    required this.companyId,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.debt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      fullname: json['fullname'],
      address: json['address'],
      companyId: json['company_id'],
      phoneNumber: json['phone_number'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      debt: json['debt'],
    );
  }
}
