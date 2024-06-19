import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepoImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, String>> loginWithEmail(
      {required String password, required String email}) {
    // TODO: implement loginWithEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmail({
    required String name,
    required String password,
    required String email,
  }) async{
    try{
      
      final userId=await remoteDataSource.signupWithEmailPassword(name: name, email: email, password: password);
      return right(userId);
      // this is the success, return the userid 
    }on ServerException catch(e){
      return left(Failure(e.message));
    }
  }
}
