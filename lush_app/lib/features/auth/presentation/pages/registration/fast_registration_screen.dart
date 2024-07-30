import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_bloc.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_states.dart';
import 'package:lush_app/core/commons/widgets/custom_loader.dart';
import 'package:lush_app/core/commons/widgets/custom_text_field.dart';
import 'package:lush_app/core/utils/show_snackbar.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/registration/fast_registration_screen_view_model.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/form_widget_view_model.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/registration_header_widget_view_model.dart';
import 'package:lush_app/features/auth/presentation/widgets/form_widget.dart';

class FastRegistrationScreen extends StatelessWidget {
  final FastRegistrationScreenViewModel viewModel =
      FastRegistrationScreenViewModel();

  FastRegistrationScreen({super.key});

  FormWidgetViewModel _createFormWidgetViewModel(BuildContext context) {
    return FormWidgetViewModel(
      disableSecondaryButton:
          true, //TODO: Correggere la logica di registrazione con Google
      formKey: viewModel.formKey,
      headerViewModel:
          const FormHeaderWidgetViewModel(text: 'Registrazione veloce'),
      textFields: _getTextFields(),
      primaryButtonText: 'Registrati',
      primaryButtonOnPressed: () =>
          viewModel.onLoginAnonymouslyButtonPressed(context),
      useSecondaryButton: true,
      secondaryButtonText: 'Registrati con Google',
      secondaryButtonOnPressed: () =>
          viewModel.onLoginWithGoogleButtonPressed(context),
      useTextButton: true,
      textButtonText: 'Accedi',
      textButtonOnPressed: () =>
          viewModel.onGoToLoginPageButtonPressed(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Ascolta i cambiamenti di stato dell'AuthBloc
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            // Se l'AuthBloc va in errore mostra un avviso
            if (state is AuthErrorState) {
              showSnackBar(context, state.message);
              // Se viene completato il processo di registrazione veloce crea un utente parziale
            } else if (state is AuthFastRegistrationCompletedState) {
              viewModel.createPartialUser(context);
            }
          },
        ),
        // Ascolta i cambiamenti di stato dello UserBloc
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            // Se lo UserBloc va in error mostra un evviso
            if (state is UserErrorState) {
              showSnackBar(context, state.message);
              // Se viene completata la creazione parziale dell'utente vai alla schermata successiva
            } else if (state is UserOnPartialCreatedState) {
              viewModel.goToTheMainScreen(context);
            }
          },
        ),
      ],
      // Aggiorna l'interfaccia in tempo reale in base ai cambiamenti di stato dell'AuthBloc
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        // Se l'AuthBloc sta completando la registrazione veloce mostra un caricamento
        if (state is AuthOnFastRegistrationState) {
          const CustomLoader();
        }

        // Altrimenti mostra l'interfaccia standard
        return FormWidget(viewModel: _createFormWidgetViewModel(context));
      }),
    );
  }

  List<Widget> _getTextFields() {
    return [
      CustomTextField.large(
        hintText: 'Il mio username',
        controller: viewModel.usernameController,
        validator: viewModel.validateUsername,
      ),
    ];
  }
}
