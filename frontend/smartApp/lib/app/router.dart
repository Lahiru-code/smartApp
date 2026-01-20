/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/auth/state/auth_controller.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == '/login';
      final isAuthed = authState.valueOrNull?.isAuthenticated ?? false;

      if (!isAuthed && !isLoggingIn) return '/login';
      if (isAuthed && isLoggingIn) return '/home';

      return null;
    },
  );
});
*/