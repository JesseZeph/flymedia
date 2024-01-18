class NetworkResponse {
  bool status;
  String message;
  dynamic data;
  NetworkResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory NetworkResponse.fromMap(Map<String, dynamic> map) {
    return NetworkResponse(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
      data: map['data'],
    );
  }

  @override
  String toString() =>
      'NetworkResponse(status: $status, message: $message, data: $data)';
}
