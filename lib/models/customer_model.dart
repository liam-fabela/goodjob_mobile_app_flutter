class Customer {
  String customerId;
  String customerLastName;
  String customerFirstName;
  String customerBirthdate;
  String customerZone;
  String customerBarangay;
  String customerCity;
  String customerUserName;
  

  Customer({
    this.customerId,
    this.customerLastName,
    this.customerFirstName,
    this.customerBirthdate,
    this.customerZone,
    this.customerBarangay,
    this.customerCity,
    this.customerUserName,
   
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer (
      customerId: json['customer_id'] as String,
      customerLastName: json['customer_lname'] as String,
      customerFirstName: json['customer_fname'] as String,
      customerBirthdate: json['customer_dob'] as String,
      customerZone: json['customer_zone'] as String,
      customerBarangay: json['customer_barangay'] as String,
      customerCity: json['customer_city'] as String,
      customerUserName: json['customer_username'] as String,

    );
}
}