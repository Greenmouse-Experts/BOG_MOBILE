import '../data/providers/api.dart';
import '../data/providers/api_response.dart';

class UserRepository {
  final Api api;

  UserRepository(this.api);

  Future<ApiResponse> signup(dynamic body) async {
    final response = await api.postData('/user/signup', body: body);
    return response;
  }

   Future<ApiResponse> googleSignUp(dynamic body) async {
    final response = await api.postData('/users/auth/google', body: body);
    return response;
  }

  Future<ApiResponse> signIn(dynamic body) async {
    final response = await api.postData('/user/login', body: body);
    return response;
  }

  Future<ApiResponse> forgotPassword(String email) async {
    final response = await api.getData('/user/forgot-password?email=$email');
    return response;
  }

  Future<ApiResponse> verifyOTPForSignUp(String email, String token) async {
    final response =
        await api.postData('/user/verify', hasHeader: true, body: {
          'email': email,
          'token': token
        });
    return response;
  }

  Future<ApiResponse> getBanks() async {
    final response = await api.getData('/bank/allbanks');
    return response;
  }

  Future<ApiResponse> postData(String url, dynamic body,
      {hasHeader = true}) async {
    final response = await api.postData(url, hasHeader: hasHeader, body: body);
    return response;
  }

  Future<ApiResponse> getData(String url, {hasHeader = true}) async {
    final response = await api.getData(url, hasHeader: hasHeader);
    return response;
  }

  Future<ApiResponse> deleteData(String url, {hasHeader = true}) async {
    final response = await api.deleteData(url, hasHeader: hasHeader);
    return response;
  }

  Future<ApiResponse> putData(String url, dynamic body,
      {hasHeader = true, sso = true}) async {
    final response = await api.putData(url, hasHeader: hasHeader, body: body);
    return response;
  }

  Future<ApiResponse> patchData(String url, dynamic body,
      {hasHeader = true, sso = true}) async {
    final response = await api.patchData(url, hasHeader: hasHeader, body: body);
    return response;
  }
}
