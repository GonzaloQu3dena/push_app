import 'package:go_router/go_router.dart';
import 'package:push_app/notifier/presentation/screens/details_screen.dart';
import 'package:push_app/public/home/screens/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/push-details/:messageId',
      builder: (context, state) => DetailsScreen(
        pushMessageId: state.pathParameters['messageId'] ?? '',
      ),
    ),
  ],
);
