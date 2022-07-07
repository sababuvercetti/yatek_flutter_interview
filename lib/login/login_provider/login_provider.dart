import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yatek_interview/login/login_provider/login_state.dart';

final loginProvider = StateNotifierProvider<Loginprovider, LoginState>((_) {
  return Loginprovider();
});

class Loginprovider extends StateNotifier<LoginState> {
  Loginprovider() : super(LoginState.initial());
  void login({required String email, required String password}) async {
    state = LoginState.loading();
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) {
        state = LoginState.success();
      });
    } on FirebaseException catch (e) {
      state = LoginState.error(e.message!);
    } catch (e) {
      state = LoginState.error(e.toString());
    }
  }
}
