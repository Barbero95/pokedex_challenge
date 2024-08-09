enum Environment {
  dev,
  prod;

  bool get isDev => this == dev;
  bool get isProd => this == prod;
}
