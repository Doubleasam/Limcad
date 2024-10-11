import 'package:flutter/material.dart';

enum Flavor { dev, prod }

extension EnumExtention on Flavor {
  String get enumValue {
    switch (this) {
      case Flavor.dev:
        return "Dev";
      case Flavor.prod:
        return "Prod";
    }
  }
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final Color? color;
  final Env values;
  static FlavorConfig? _instance;

  factory FlavorConfig({
    required Flavor flavor,
    Color? color = Colors.blue,
    required Env values,
  }) {
    _instance ??=
        FlavorConfig._internal(flavor, flavor.enumValue, color, values);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.color, this.values);
  static FlavorConfig? get instance {
    return _instance;
  }

  Env envConfig() {
    return values;
  }

  static bool isMobileProd() => _instance!.flavor == Flavor.prod;
  static bool isMobileDev() => _instance!.flavor == Flavor.dev;

  static bool isMobileDevice() => isMobileProd() || isMobileDev();


  ///** isProd when it uses production url. i.e both mobileProd and PosProd */
  static bool isProd() => isMobileProd();
  static bool isDev() => isMobileDev();

  static int getFlavorValue() {
    switch (_instance!.flavor) {
      case Flavor.prod:
        return 1;
      case Flavor.dev:
        return 2;
    }
  }

  static FlavorConfig? getCurrentConfig(int flavorValue) {
    switch (flavorValue) {
      case 1:
        return FlavorConfig(
            flavor: Flavor.prod, color: Colors.red, values: ProdEnv());
      case 2:
        return FlavorConfig(flavor: Flavor.dev, color: Colors.red, values: DevEnv());
      default:
        return null;
    }
  }
}



abstract class Env {
  late String baseUrl;
  late int connectionTimeout;
  late int readTimeout;
  late String googleAPIKey;
}


class ProdEnv implements Env {
  @override
  String baseUrl = "http://167.71.185.95/api";//"http://localhost:8080/api";//

  @override
  int connectionTimeout = 30000;

  @override
  int readTimeout = 120000;

  @override
  String googleAPIKey = "AIzaSyDmq2C1vmDwUr0cnIAX6djCFspyIHJ5V48";

}

class DevEnv implements Env {
  @override
  String baseUrl = "http://167.71.185.95/api";


  @override
  int connectionTimeout = 30000;

  @override
  int readTimeout = 180000;


  @override
  String googleAPIKey =  "AIzaSyDmq2C1vmDwUr0cnIAX6djCFspyIHJ5V48";


}