import 'package:blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository{
  // must implements all methids , tabhi interface diya 
  Future<Either<Failure, String>>signUpWithEmail({
    required String name,
    required String password,
    required String email
  });
  Future<Either<Failure, String>> loginWithEmail({
    required String password,
    required String email
  });
  
}