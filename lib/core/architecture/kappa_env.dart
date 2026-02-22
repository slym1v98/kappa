/// Supported environment flavors for the application.
enum FKappaFlavor { dev, staging, prod }

/// A container for environment-specific configuration.
class FKappaEnv {
  final FKappaFlavor flavor;
  final String baseUrl;
  final String? apiKey;
  final String? sentryDsn;
  final Map<String, dynamic> extra;

  const FKappaEnv({
    required this.flavor,
    required this.baseUrl,
    this.apiKey,
    this.sentryDsn,
    this.extra = const {},
  });

  bool get isDev => flavor == FKappaFlavor.dev;
  bool get isStaging => flavor == FKappaFlavor.staging;
  bool get isProd => flavor == FKappaFlavor.prod;

  @override
  String toString() => 'FKappaEnv(flavor: $flavor, baseUrl: $baseUrl)';
}
