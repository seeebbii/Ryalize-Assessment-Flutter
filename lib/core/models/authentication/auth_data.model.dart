class AuthData {
  String? sId;
  String? email;
  String? password;
  String? name;
  String? countryCode;
  String? phone;
  bool? verified;
  String? completePhone;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AuthData(
      {this.sId,
        this.email,
        this.password,
        this.name,
        this.countryCode,
        this.phone,
        this.verified,
        this.completePhone,
        this.createdAt,
        this.updatedAt,
        this.iV});

  AuthData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    countryCode = json['country_code'];
    phone = json['phone'];
    verified = json['verified'];
    completePhone = json['complete_phone'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['_id'] = sId;
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['country_code'] = countryCode;
    data['phone'] = phone;
    data['verified'] = verified;
    data['complete_phone'] = completePhone;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}