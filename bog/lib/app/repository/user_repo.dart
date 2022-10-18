import '../data/providers/api.dart';
import '../data/providers/api_response.dart';

class UserRepository {
  final Api api;

  UserRepository(this.api);

  Future<ApiResponse> signup(dynamic body) async {
    final response = await api.postData('/user/signup', body: body);
    return response;
  }

  Future<ApiResponse> signIn(dynamic body) async {
    final response = await api.postData('/user/login', body: body);
    return response;
  }

  Future<ApiResponse> forgotPassword(String email) async {
    final response = await api.getData('/user/forgot-password/$email');
    return response;
  }

}
