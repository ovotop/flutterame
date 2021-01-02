class EnvironmentConfig {
  static const IS_RUN_ALONE =
      bool.fromEnvironment('IS_RUN_ALONE', defaultValue: false);
}
