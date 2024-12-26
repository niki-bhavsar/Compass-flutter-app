import 'package:compass_software/data/repository/auth_repository.dart';
import 'package:compass_software/data/repository/auth_repository_impl.dart';
import 'package:compass_software/data/repository/favourite_repository.dart';
import 'package:compass_software/data/repository/profiles_repository.dart';
import 'package:compass_software/data/service/auth_service.dart';
import 'package:compass_software/data/service/favourite_service.dart';

import 'package:compass_software/data/repository/settings_repository.dart';
import 'package:compass_software/data/service/profiles_service.dart';
import 'package:compass_software/data/service/settings_service.dart';
import 'package:compass_software/data/shared_pref/session_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../data/repository/my_profile_repository.dart';
import '../data/service/my_profile_service.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;

  const AppBlocProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SessionPref>(
          create: (context) => GetIt.instance.get<SessionPref>(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            authService: AuthService(),
            sessionPref: context.read<SessionPref>(),
          ),
        ),
        RepositoryProvider<MyProfileRepository>(
          create: (context) => MyProfileRepositoryImpl(
            myProfileService: MyProfileService(),
            sessionPref: context.read<SessionPref>(),
          ),
        ),
        RepositoryProvider<FavouriteRepository>(
          create: (context) => FavouriteRepositoryImpl(
            favouriteService: FavouriteService(),
            sessionPref: context.read<SessionPref>(),
          ),
        ),
        RepositoryProvider<SettingsRepository>(
          create: (context) => SettingsRepositoryImp(
            settingService: SettingsService(),
            sessionPref: context.read<SessionPref>(),
          ),
        ),
        RepositoryProvider<ProfilesRepository>(
          create: (context) => ProfilesRepositoryImpl(
            profilesService: ProfilesService(),
            sessionPref: context.read<SessionPref>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
