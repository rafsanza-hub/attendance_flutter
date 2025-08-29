import 'package:attendance_flutter/app/core/logger/logger.dart';
import 'package:attendance_flutter/app/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends GetxService {
  final SupabaseClient _client = Supabase.instance.client;

  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isInitialized = RxBool(true);

  @override
  void onInit() {
    super.onInit();
    isInitialized.value = true;

    _client.auth.onAuthStateChange.listen((event) async {
      final session = event.session;
      if (session?.user != null) {
        final authUser = session!.user;
        final response = await _client
            .from('users')
            .select()
            .eq('id', authUser.id)
            .maybeSingle();
        if (response != null) {
          currentUser.value = UserModel(
            uid: authUser.id,
            email: response['email'] ?? authUser.email ?? '',
            tenantId: response['tenantId'] as String?,
            role: response['role'] as String?,
          );
        } else {
          currentUser.value =
              UserModel(uid: authUser.id, email: authUser.email ?? '');
        }
      } else {
        currentUser.value = null;
      }
      isInitialized.value = false;
    });
  }

  Future<void> waitUntilUserLoaded() async {
    while (isInitialized.value) {
      AppLogger.instance.d('Waiting for user to be initialized...');
      await Future.delayed(Duration(milliseconds: 50));
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final authUser = response.user;

      if (authUser == null) {
        throw Exception('Login failed: No user found');
      }
      AppLogger.instance.d(response.user!.id);
      final profile = await _client
          .from('users')
          .select()
          .eq('id', authUser.id)
          .maybeSingle();
      AppLogger.instance.d(profile);
      if (profile == null) {
        await _client.auth.signOut();
        throw Exception('User not registered. Contact your admin  .');
      }
      AppLogger.instance.d(profile['tenantid']);
      if (profile['role'] != 'superadmin' && profile['tenantId'] == null) {
        await _client.auth.signOut();
        throw Exception('No tenant assigned. Contact your admi.');
      }
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(UserModel user, String password) async {
    try {
      final response = await _client.auth.signUp(
        email: user.email,
        password: password,
        data: {
          'role': user.role,
        },
      );
      final created = response.user;
      if (created != null) {
        await _client.from('users').insert({
          'id': created.id,
          'email': user.email,
          'tenantId': user.tenantId,
          'role': user.role,
        });
      }
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  String? getTenantId() => currentUser.value?.tenantId;

  String? getRole() => currentUser.value?.role;

  bool isSuperAdmin() => getRole() == 'superadmin';

  bool isAdmin() => getRole() == 'admin';
}
