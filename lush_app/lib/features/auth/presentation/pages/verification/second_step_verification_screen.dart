import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_bloc.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_states.dart';
import 'package:lush_app/core/commons/widgets/custom_loader.dart';
import 'package:lush_app/core/commons/widgets/custom_text_field.dart';
import 'package:lush_app/core/constants/colors.dart';
import 'package:lush_app/core/utils/show_snackbar.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/form_widget_view_model.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/logo_widget_view_model.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/registration_header_widget_view_model.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/verification/second_step_verification_screen_view_model.dart';
import 'package:lush_app/features/auth/presentation/widgets/form_widget.dart';
import 'package:lush_app/core/commons/widgets/custom_google_places_text_field.dart';

class SecondStepVerificationScreen extends StatelessWidget {
  final SecondStepVerificationScreenViewModel viewModel =
      SecondStepVerificationScreenViewModel();

  SecondStepVerificationScreen({super.key});

  FormWidgetViewModel _createFormWidgetViewModel(
      BuildContext context, String userId) {
    return FormWidgetViewModel(
      formKey: viewModel.formKey,
      headerViewModel: const FormHeaderWidgetViewModel(
        logoType: LogoType.lightBlue,
        text: 'Compila il form\nperverificare il tuo profilo',
      ),
      textFields: _getTextFields(),
      primaryButtonText: 'Procedi',
      primaryButtonOnPressed: () =>
          viewModel.onSecondStepCompletedButtonPressed(context, userId),
      primaryButtonBackgroundColor: cSecondaryColor,
      primaryButtonTextColor: cSurfaceColor,
      useTextButton: true,
      textButtonText: 'Passaggio 2 di 3',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Ascolta i cambiamenti dell'AuthBloc
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            // Se l'AuthBloc va in errore mostra un avviso
            if (state is AuthErrorState) {
              showSnackBar(context, state.message);
            }
          },
        ),
        // Ascolta i cambiamenti dello UserBloc
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            // Se l'UserBloc va in errore mostra un avviso
            if (state is UserErrorState) {
              showSnackBar(context, state.message);
              // Se i dati dell'utente corrente sono stati caricati aggiorna le textfields con i dati aggiornati
            } else if (state is UserLoadedState) {
              viewModel.initializeTextFieldsWithCurrentUserData(state.user);
              // Se i dati inseriti nel secondo step di verifica sono staiti salvati nel database vai al terzo step di verifica
            } else if (state is UserSecondStepVerificationCompletedState) {
              viewModel.goToThirdStepVerificationScreen(context);
            }
          },
        ),
      ],
      // Aggiorna l'interfaccia in tempo reale in base agli stati dell'AuthBloc
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          // Se l'AuthBloc sta caricando l'id dell'utente corrente mostra un caricamento
          if (authState is AuthOnLoadingCurrentUserState) {
            return const CustomLoader();
            // Se l'AuthBloc ha finito di caricare l'id dell'utente corrente continua a costruire l'interfaccia
          } else if (authState is AuthLoadedCurrentUserState) {
            // Ottieni l'utente corrente in base all'id
            viewModel.getCurrentUser(context, authState.currentUserId);

            // Aggiorna l'interfaccia in tempo reale in base agli stati dello UserBloc
            return BlocBuilder<UserBloc, UserState>(
              builder: (context, userState) {
                // Se lo UserBloc sta caricando i dati dell'utente corrente mostra un caricamento
                if (userState is UserLoadingState) {
                  const CustomLoader();
                  // Se lo UserBloc sta caricando i dati inseriti nello step di verifica corrente mostra un caricamento
                } else if (userState is UserOnSecondStepVerificationState) {
                  return const CustomLoader();
                }

                // Altrimenti mostra il widget standard
                return FormWidget(
                  viewModel: _createFormWidgetViewModel(
                    context,
                    authState.currentUserId,
                  ),
                );
              },
            );
          } else {
            // Gestisci altri stati dell'AuthBloc se necessario
            return const Center(child: Text('Errore di autenticazione utente'));
          }
        },
      ),
    );
  }

  List<Widget> _getTextFields() {
    return [
      CustomGooglePlacesTextField(
        controller: viewModel.residenceAddressController,
        itemClick: viewModel.residenceAddressItemClick,
        hintText: 'Il mio indirizzo di residenza',
      ),
      CustomTextField.large(
        controller: viewModel.emailController,
        hintText: 'La mia email',
      ),
      CustomTextField.large(
        controller: viewModel.phoneNumberController,
        hintText: 'Il mio numero di telefono',
      ),
    ];
  }
}
