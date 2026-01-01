class MerchantKycModel {
  String? status;
  String? message;
  List<MerchantKycData>? data;

  MerchantKycModel({this.status, this.message, this.data});

  MerchantKycModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MerchantKycData>[];
      json['data'].forEach((v) {
        data!.add(MerchantKycData.fromJson(v));
      });
    }
  }
}

class MerchantKycData {
  int? id;
  String? name;
  List<Fields>? fields;
  int? status;
  String? createdAt;
  String? updatedAt;

  MerchantKycData({
    this.id,
    this.name,
    this.fields,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  MerchantKycData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['fields'] != null) {
      fields = <Fields>[];
      json['fields'].forEach((v) {
        fields!.add(Fields.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Fields {
  String? name;
  String? type;
  String? validation;
  String? instructions;

  Fields({this.name, this.type, this.validation, this.instructions});

  Fields.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    validation = json['validation'];
    instructions = json['instructions'];
  }
}
