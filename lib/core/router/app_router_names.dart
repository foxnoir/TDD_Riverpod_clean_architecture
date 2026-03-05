/// Keep route paths (URL) and names (for goNamed) separate.
class AppRouteNames {
  const AppRouteNames._();

  static const String initialLocation = '/';

  /// Paths for URL / deep link
  static const String startScreenPath = '/start_screen';
  /// Nested under start: full path /start_screen/state_provider_screen
  static const String stateProviderScreenPath = 'state_provider_screen';

  /// State provider screen: name for context.goNamed('stateProviderScreen')
  static const String startScreen = 'startScreen';
  static const String stateProviderScreen = 'stateProviderScreen';
}
