import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:ecommerce_app_huma_volve/core/deep_links/deep_link_parser.dart';
import 'package:ecommerce_app_huma_volve/features/details/screens/deep_linked_product_screen.dart';
import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'features/splash/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  // Tracks the last handled product id to avoid stacking duplicate screens.
  int? _lastNavigatedProductId;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    _initDeepLinks();
  }

  Future<void> _initDeepLinks() async {
    // Cold start: the app was launched by a link.
    final initialUri = await _appLinks.getInitialLink();
    _handleLink(initialUri);

    // Warm start: the app is already running and receives a link.
    _linkSubscription = _appLinks.uriLinkStream.listen(_handleLink);
  }

  void _handleLink(Uri? uri) {
    final productId = DeepLinkParser.parseProductId(uri);
    if (productId == null) return;

    // Don't push a duplicate screen for the same id that is already on top.
    if (_lastNavigatedProductId == productId) return;
    _lastNavigatedProductId = productId;

    // Push on top of whatever is currently shown (main nav or login).
    _navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => DeepLinkedProductScreen(productId: productId),
        // Reset the guard once the user navigates back.
      ),
    ).then((_) {
      _lastNavigatedProductId = null;
    });
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      navigatorKey: _navigatorKey,
      home: const SplashScreen(),
    );
  }
}
