class AppConfig {
  final String name;
  final String baseUrl;
  final int port;
  final String aesKey;
  final String aesIv;

  const AppConfig({
    required this.name,
    required this.baseUrl,
    required this.port,
    required this.aesKey,
    required this.aesIv,
  });

  const AppConfig.prod()
      : this(
          name: 'production',
          baseUrl: 'https://android.edupay.info',
          port: 9101,
          aesKey: '&%yhdk()83h\$#ksP',
          aesIv: 'L&hgYr)\$!&nxbTH&',
        );

  const AppConfig.dev()
      : this(
          name: 'dev',
          baseUrl: 'http://45.64.96.45',
          port: 8100,
          aesKey: '1234567890123456',
          aesIv: '1234567890123456',
        );
}
