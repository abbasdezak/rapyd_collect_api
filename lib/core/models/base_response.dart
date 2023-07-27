class BaseResponse {
  Status? status;
  dynamic? data;

  BaseResponse({this.status, this.data});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    if (json['data'] != null) {
      data = json['data'];
    }
  }
}

class Status {
  String? errorCode;
  String? status;
  String? message;
  String? responseCode;
  String? operationId;

  Status(
      {this.errorCode,
      this.status,
      this.message,
      this.responseCode,
      this.operationId});

  Status.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    status = json['status'];
    message = json['message'];
    responseCode = json['response_code'];
    operationId = json['operation_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error_code'] = this.errorCode;
    data['status'] = this.status;
    data['message'] = this.message;
    data['response_code'] = this.responseCode;
    data['operation_id'] = this.operationId;
    return data;
  }
}
