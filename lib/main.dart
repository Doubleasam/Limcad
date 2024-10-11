import 'package:flutter/material.dart';
import 'package:limcad/config/flavor.dart';
import 'package:limcad/setup.dart';

void main() {
  FlavorConfig(flavor: Flavor.prod, color: Colors.red, values: ProdEnv());
  doSetup();
}