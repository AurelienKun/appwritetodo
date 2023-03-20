import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:appwritetodo/app/view/app.dart';

class AuthHelper {
  final Account account = Account(client);

  Future<model.Account> createUserAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      return response;
    } on AppwriteException {
      rethrow;
    }
  }

  Future<bool> logout() async {
    try {
      await account.deleteSessions();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<model.Session> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await account.createEmailSession(
        email: email,
        password: password,
      );
      return response;
    } on AppwriteException {
      rethrow;
    }
  }

}
