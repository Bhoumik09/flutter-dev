import 'package:bloc/bloc.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';
// bloc decides ki error aayega ki nahi
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({required UserSignUp userSignUp}) :_userSignUp=userSignUp, super(AuthInitial()) {
    on<AuthSignUp>((event, emit)async {
      
      final res =await  _userSignUp(UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ));
      res.fold((l)=>emit(AuthFailure(l.message)),(uid)=>emit(AuthSuccess(uid)));
    });
  }
}
