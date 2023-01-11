import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: ref.watch(goRouterProvider),
    );
  }
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('home'),
              TextButton(
                onPressed: () => context.push('/family/123'),
                child: const Text('family'),
              ),
              TextButton(
                onPressed: () => context.push('/family/123/member/456'),
                child: const Text('family'),
              ),
            ],
          ),
        ),
        routes: <GoRoute>[
          GoRoute(
            name: 'family',
            path: 'family/:fid',
            builder: (BuildContext context, GoRouterState state) {
              return Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('family: ${state.params['fid']}'),
                    Text('family: ${state.queryParams['fid']}'),
                  ],
                ),
              );
            },
            routes: <GoRoute>[
              GoRoute(
                name: 'family_member',
                path: 'member/:mid',
                builder: (BuildContext context, GoRouterState state) {
                  return Scaffold(
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('family: ${state.params['fid']}'),
                        Text('family: ${state.queryParams['fid']}'),
                        Text('member: ${state.params['mid']}'),
                        Text('member: ${state.queryParams['mid']}'),
                        Text('fullpath: ${state.fullpath}'),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
