import 'package:blog_app/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signupWithEmailPassword(
      {required String name, required String email, required String password});
  Future<String> loginWithEmailPassword(
      {required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<String> loginWithEmailPassword(
      {required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<String> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  })async {
    try{
       final response=await supabaseClient.auth.signUp(password: password, email: email ,data:{
        'name':name
        //name here is string so that supabase treats it as one  
      } );
      if(response.user==null){
        throw const ServerException("User is null");
      }
      return response.user!.id;
    }
    catch(e){
       throw ServerException(e.toString());

    }
  }
}
