import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_bloc.dart';
import 'package:lush_app/core/constants/routes.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lush_app/features/auth/presentation/pages/login_screen.dart';
import 'package:lush_app/features/collections/presentation/bloc/collection_bloc.dart';
import 'package:lush_app/features/collections/presentation/pages/collection_screen.dart';
import 'package:lush_app/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<UserBloc>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        //BlocProvider(create: (_) => serviceLocator<ChatBloc>()),
        //BlocProvider(create: (_) => serviceLocator<MessageBloc>()),
        BlocProvider(create: (_) => serviceLocator<CollectionBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Montserrat'),
        title: 'Lush',
        home: CollectionScreen(
            /*BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthErrorState) {
              showSnackBar(context,
                  'An error occurred in the authentication process: ${state.message}');
            } else if (state is AuthLoadedCurrentUserState) {
              Navigator.pushReplacementNamed(context, cCollectionScreen);
            }
          },
          builder: (context, state) {
            if (state is AuthOnLoadingCurrentUserState) {
              return const CustomLoader();
            }

            return LoginScreen();
          },*/
            ),
        routes: routes,
      ),
    );
  }
}
