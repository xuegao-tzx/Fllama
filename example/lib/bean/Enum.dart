import 'package:flutter/cupertino.dart';
import 'package:material_symbols_icons/symbols.dart';

enum RouteEntry {
  splash("/"),
  home("/home"),
  about("/about"),
  modelManager("/modelManager");

  const RouteEntry(this.label);

  final String label;
}

enum MenuEntry {
  modelManager("ModelManager", Symbols.folder_managed_rounded),
  about("About App", Symbols.info_rounded);

  const MenuEntry(this.traLabel, this.icon);

  final String traLabel;
  final IconData icon;
}
