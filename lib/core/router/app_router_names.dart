/// Keep route paths (URL) and names (for goNamed) separate.
class AppRouteNames {
  const AppRouteNames._();

  static const String initialLocation = '/';

  /// State provider screen: path for URL / deep link
  static const String stateProviderScreenPath = '/state_provider_screen';
  /// State provider screen: name for context.goNamed('stateProviderScreen')
  static const String stateProviderScreen = 'stateProviderScreen';
}
