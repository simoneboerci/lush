import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_bloc.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_events.dart';
import 'package:lush_app/core/constants/routes.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_events.dart';

class FastRegistrationScreenViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();

  FastRegistrationScreenViewModel();

  // Valida la text field username
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Inserisci un unsername valido';
    }
    return null;
  }

  // Funzione chiamata quando l'utente preme sul pulsante di registrazione veloce (login anonimo)
  void onLoginAnonymouslyButtonPressed(BuildContext context) {
    // Assicurati che il form sia validato
    if (formKey.currentState!.validate()) {
      // Procedi con il login anonimo
      _loginAnonymously(context, usernameController.text.trim());
    }
  }

  // Funzione chiamata quando l'utente preme sul pulsante di registrazione tramite Google
  void onLoginWithGoogleButtonPressed(BuildContext context) {
    // Esegui la registrazione con Google
    _loginWithGoogle(context);
  }

  // Funzione chiamata quando l'utente parziale viene creato
  void goToTheMainScreen(BuildContext context) {
    // Vai alla schermata principale
    Navigator.pushReplacementNamed(context, cCompleteRegistrationScreen);
  }

  // Funzione chiamata quando l'utente preme sul pulsante per andare alla pagina di login
  void onGoToLoginPageButtonPressed(BuildContext context) {
    // Vai alla pagina di login
    _goToTheLoginScreen(context);
  }

  // Funzione chiamata dopo che l'AuthBloc ha registrato l'utente in anonimo
  void createPartialUser(BuildContext context) {
    // Crea un utente parziale nello UserBloc
    context
        .read<UserBloc>()
        .add(CreatePartialUserEvent(usernameController.text));
  }

  void _loginAnonymously(BuildContext context, String username) {
    context.read<AuthBloc>().add(AuthLoginAnonymouslyEvent(username: username));
  }

  void _loginWithGoogle(BuildContext context) {
    context.read<AuthBloc>().add(const AuthLoginWithGoogleEvent());
  }

  void _goToTheLoginScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, cLoginScreen);
  }
}
