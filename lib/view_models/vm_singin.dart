import 'package:firebase_auth/firebase_auth.dart';
import 'package:thesis_project/models/provider_dataset.dart';
import 'package:thesis_project/repository/repo_singIn.dart';
import 'package:thesis_project/view_models/vm_signup.dart';

class SignInViewModel {
  SignUpViewModel _signUpViewModel = SignUpViewModel();
  SignInRepository signInRepository = SignInRepository();

  Future<List<ProviderDataset>> mGenerateProviderDataset() async {
    return await _signUpViewModel.mGenerateProviderDataset();
  }

  Future<void> mSignin(
      {required String email, required String password}) async {
     await signInRepository.mSignIn(
         email: email, password: password);
  }
}
