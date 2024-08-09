import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/commons/services/translation/generated/l10n.dart';

extension BuildContextHelper on BuildContext {
  Translation get trl {
    return Translation.of(this);
  }
}
