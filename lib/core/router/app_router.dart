import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screen/enter_code_screen.dart';
import '../../features/auth/presentation/screen/forgot_password_screen.dart';
import '../../features/auth/presentation/screen/sign_in_screen.dart';
import '../../features/auth/presentation/screen/sign_up_screen.dart';
import '../../features/auth/presentation/screen/welcome_screen2.dart';
import '../../features/item/presentation/ItemsFound.dart';
import '../../features/item/presentation/ItemsLost.dart';
import '../../features/item/presentation/ItemDetails.dart';
import '../../features/item/presentation/ReportItem.dart';
import '../../features/profile/presentation/Profile.dart';
import '../../features/profile/presentation/Editprofile.dart';
import '../../features/profile/presentation/MyItems.dart';
import '../../features/profile/presentation/MyItem.dart';
import '../../features/profile/presentation/DeleteAccount.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    // Welcome route
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen2(),
    ),
    // Auth routes
    GoRoute(
      path: '/login',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const SignUpScreen(),
    ),
    // Item routes
    GoRoute(
      path: '/items-found',
      builder: (context, state) => const ItemFound(),
    ),
    GoRoute(
      path: '/items-lost',
      builder: (context, state) => const ItemsLost(),
    ),
    GoRoute(
      path: '/item-details/:id',
      builder: (context, state) => ItemDetailsFound(
        id: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/report-item',
      builder: (context, state) => ReportItemFound(),
    ),
    // Profile routes
    GoRoute(
      path: '/my-items',
      builder: (context, state) => const MyItems(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const Profile(),
    ),
    GoRoute(
      path: '/edit-profile',
      builder: (context, state) => const EditProfile(),
    ),
    GoRoute(
      path: '/my-item/:id',
      builder: (context, state) => MyItemDetail(
        id: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/delete-account',
      builder: (context, state) => const DeleteAccount(),
    ),
  ],
);