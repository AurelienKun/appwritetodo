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
      await account.deleteSession(sessionId: storage.getSession());
      storage.setSession('');
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> logoutEverywhere() async {
    try {
      await account.deleteSessions();
      storage.setSession('');
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
      storage.setSession(response.$id);
      return response;
    } on AppwriteException {
      rethrow;
    }
  }

  Future<model.Session> loginWithSession({required String session}) async {
    try {
      final sessionId = storage.getSession();
      final response = await account.getSession(sessionId: sessionId);
      return response;
    } on AppwriteException {
      rethrow;
    }
  }
}
