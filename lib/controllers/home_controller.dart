import 'package:news/models/user_model.dart';
import 'package:news/services/api_service.dart';

class HomeController {
  Future<List<UserModel>> fetchUsers() async {
    final data = await ApiService.fetchUsers();
    return data.map((json) => UserModel.fromJson(json)).toList();
  }
}
