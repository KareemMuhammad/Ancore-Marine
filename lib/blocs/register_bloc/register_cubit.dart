import 'package:bloc/bloc.dart';
import 'package:shop_app/blocs/register_bloc/register_state.dart';
import 'package:shop_app/models/user.dart';
import '../../repositories/user_repo.dart';

class RegisterCubit extends Cubit<RegisterState>{
  final UserRepository? userRepository;
  RegisterCubit({this.userRepository}) : super(RegisterInitial());

  void signUp(String name, String email, String phone,
      String password,String address,String confirm)async{
    emit(LoadingRegistration());
    UserHolder responseModel =  await userRepository!.signUpResponse(
        name,email,phone, password,address,confirm);
    if(responseModel.user!.id != null){
      emit(RegisterSuccessful(responseModel.user!,responseModel.message!));
    }else{
      emit(RegisterFailed(responseModel.message!));
    }
  }
}