import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/widgets/custom_loader.dart';
import 'package:lush_app/core/commons/widgets/custom_text_field.dart';
import 'package:lush_app/core/utils/show_snackbar.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/form_widget_view_model.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/login_screen_view_model.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/registration_header_widget_view_model.dart';
import 'package:lush_app/features/auth/presentation/widgets/form_widget.dart';

class LoginScreen extends StatelessWidget {
  final LoginScreenViewModel viewModel = LoginScreenViewModel();

  LoginScreen({super.key});

  FormWidgetViewModel _createFormWidgetViewMolde(BuildContext context) {
    return FormWidgetViewModel(
      disableSecondaryButton:
          true, //TODO: Correggere la logica di login con Google
      formKey: viewModel.formKey,
      headerViewModel:
          const FormHeaderWidgetViewModel(text: 'Accedi al tuo account'),
      textFields: _getTextFields(),
      primaryButtonText: 'Accedi',
      primaryButtonOnPressed: () => viewModel.onLoginButtonPressed(context),
      useSecondaryButton: true,
      secondaryButtonText: 'Accedi con Google',
      secondaryButtonOnPressed: () =>
          viewModel.onLoginWithGoogleButtonPressed(context),
      useTextButton: true,
      textButtonText: 'Registrati',
      textButtonOnPressed: () =>
          viewModel.onGoToFastRegistrationScreenButtonPressed(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is AuthLoginCompletedState) {
          viewModel.goToMainScreen(context);
        }
        if (state is AuthErrorState) {
          showSnackBar(context, state.message);
          // ? Implementare un sistema di stati di errore che permetta di dare feedback più accurati all'utente
          // ? Ad esempio distinguere quando c'è un errore dovuto alla connessione con il server o quando le credenziali non sono riconosciute
        }
      }, builder: (context, state) {
        if (state is AuthOnLoginState) {
          return const CustomLoader();
        }

        return FormWidget(viewModel: _createFormWidgetViewMolde(context));
      }),
    );
  }

  List<Widget> _getTextFields() {
    return [
      CustomTextField.large(
        hintText: 'La mia email',
        controller: viewModel.emailController,
        validator: viewModel.validateEmail,
      ),
      CustomTextField.large(
        hintText: 'La mia password',
        controller: viewModel.passwordController,
        validator: viewModel.validatePassword,
        obscureText: true,
      ),
    ];
  }
}
