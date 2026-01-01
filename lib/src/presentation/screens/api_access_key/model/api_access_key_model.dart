class ApiAccessKeyModel {
  bool? status;
  ApiAccessKeyData? data;

  ApiAccessKeyModel({this.status, this.data});

  ApiAccessKeyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? ApiAccessKeyData.fromJson(json['data']) : null;
  }
}

class ApiAccessKeyData {
  String? publicKey;
  String? secretKey;

  ApiAccessKeyData({this.publicKey, this.secretKey});

  ApiAccessKeyData.fromJson(Map<String, dynamic> json) {
    publicKey = json['public_key'];
    secretKey = json['secret_key'];
  }
}
