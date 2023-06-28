import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String BASE_URL = "http://192.168.1.7:5000/api";
const Map<String, dynamic> DEFAULT_HEADERS = {
  "Content-Type": "application/json"
};

// Api để gửi các yêu cầu HTTP đến API backend
class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = BASE_URL;
    _dio.options.headers = DEFAULT_HEADERS;
    _dio.interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
  }

  Dio get sendRequest => _dio;
}

//ApiResponse để xử lý phản hồi từ API.
class ApiResponse {
  bool success;
  dynamic data;
  String? message;

  ApiResponse({required this.success, this.data, this.message});

  factory ApiResponse.fromResponse(Response response) {
    final data = response.data as Map<String, dynamic>;
    return ApiResponse(
        success: data["success"],
        data: data["data"],
        message: data["message"] ?? "Unexpected error");
  }
}
