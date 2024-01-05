import 'package:flutter/material.dart';

enum EIngrType {
  spirits,
  liqueurs,
  mixers,
  fruitJuices,
  bitters,
  sodaandCola,
  herbsandSpices,
  sweeteners,
  garnishes
}

class Ingredient {
  String? name;
  EIngrType? type;

  Ingredient({
    this.name,
    this.type,
  });
}
