/// Supported environment flavors for the application.
enum KappaFlavor { dev, staging, prod }

/// A container for environment-specific configuration.
class KappaEnv {
  final KappaFlavor flavor;
  final String baseUrl;
  final String? apiKey;
  final String? sentryDsn;
  final Map<String, dynamic> extra;

  const KappaEnv({
    required this.flavor,
    required this.baseUrl,
    this.apiKey,
    this.sentryDsn,
    this.extra = const {},
  });

  bool get isDev => flavor == KappaFlavor.dev;
  bool get isStaging => flavor == KappaFlavor.staging;
  bool get isProd => flavor == KappaFlavor.prod;

  @override
  String toString() => 'KappaEnv(flavor: $flavor, baseUrl: $baseUrl)';
}
