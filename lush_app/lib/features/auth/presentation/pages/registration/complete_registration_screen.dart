import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_bloc.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_states.dart';
import 'package:lush_app/core/commons/widgets/custom_loader.dart';
import 'package:lush_app/core/commons/widgets/custom_text_field.dart';
import 'package:lush_app/core/utils/show_snackbar.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/registration/complete_registration_screen_view_model.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/form_widget_view_model.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/registration_header_widget_view_model.dart';
import 'package:lush_app/features/auth/presentation/widgets/form_widget.dart';

class CompleteRegistrationScreen extends StatefulWidget {
  const CompleteRegistrationScreen({super.key});

  @override
  State<CompleteRegistrationScreen> createState() =>
      _CompleteRegistrationScreenState();
}

class _CompleteRegistrationScreenState
    extends State<CompleteRegistrationScreen> {
  final CompleteRegistrationScreenViewModel viewModel =
      CompleteRegistrationScreenViewModel();

  FormWidgetViewModel _createSingleStepFormWidgetViewModel(
      BuildContext context) {
    return FormWidgetViewModel(
      formKey: viewModel.formKey,
      headerViewModel: const FormHeaderWidgetViewModel(
        showButton: true,
        hintText: 'Clicca qui per inserire\n la tua immagine profilo',
        text: 'Completa il tuo profilo per continuare',
      ),
      textFields: _getTextFields(),
      primaryButtonText: 'Completa Profilo',
      primaryButtonOnPressed: () =>
          viewModel.onCompleteRegistrationButtonPressed(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Ascolta gli eventi dell'AuthBloc
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            // Se l'AuthBloc va in error mostra un avviso
            if (state is AuthErrorState) {
              showSnackBar(context, state.message);
            }
            // Se l'AuthBloc ha completato la registrazione con email e password completa la creazione dell'utente nel database
            if (state is AuthCompleteRegistrationCompletedState) {
              viewModel.createUserOnTheDatabase(context, state.user);
            }
          },
        ),
        // Ascolta gli eventi dello UserBloc
        BlocListener<UserBloc, UserState>(listener: (context, state) {
          // Se lo UserBloc va in error mostra un avviso
          if (state is UserErrorState) {
            showSnackBar(context, state.message);
          }
          // Se lo UserBloc ha completato la creazione dell'utente nel database vai alla schermata principale
          if (state is UserCreatedState) {
            viewModel.goToMainScreen(context);
          }
        }),
      ],
      // Aggiorna l'interfaccia in tempo reale in base ai cambiamenti dello UserBloc
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          // Se l'utente è stato creato parzialmente aggiorna il form inserendo i dati già presenti
          if (userState is UserOnPartialCreatedState) {
            viewModel.initializeTextFieldsWithCurrentUserData(userState.user);
            // Se lo UserBloc sta completando la creazione dell'utente mostra un caricamento
          } else if (userState is UserOnCreateState) {
            const CustomLoader();
          }

          // Altrimenti mostra l'interfaccia standard
          return FormWidget(
            viewModel: _createSingleStepFormWidgetViewModel(context),
          );
        },
      ),
    );
  }

  List<Widget> _getTextFields() {
    return [
      CustomTextField.large(
        hintText: 'Il mio nome',
        controller: viewModel.nameController,
        validator: viewModel.validateName,
      ),
      CustomTextField.large(
        hintText: 'Il mio username',
        controller: viewModel.usernameController,
        validator: viewModel.validateUsername,
      ),
      CustomTextField.large(
        hintText: 'La mia email',
        controller: viewModel.emailController,
        validator: viewModel.validateEmail,
      ),
      CustomTextField.large(
        hintText: 'La mia password',
        controller: viewModel.passwordController,
        obscureText: true,
        validator: viewModel.validatePassword,
      ),
      CustomTextField.large(
        hintText: 'Conferma password',
        controller: viewModel.passowordConfirmationController,
        obscureText: true,
        validator: viewModel.validatePasswordConfirmation,
      ),
    ];
  }
}
