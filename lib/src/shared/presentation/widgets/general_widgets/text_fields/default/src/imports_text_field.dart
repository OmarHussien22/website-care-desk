import 'dart:async';

import 'package:coursaty/src/core/styles/colors/app_colors.dart';
import 'package:coursaty/src/core/utils/extensions/basic_op_extensions.dart';
import 'package:coursaty/src/core/utils/extensions/screen_spaces_extension.dart';
import 'package:coursaty/src/core/utils/validation/app_validator.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text_fields/default/src/default/components/decoration/abstract/input_decoration_imp.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text_fields/default/src/default/components/prefix/abstract/prefix_imp.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text_fields/default/src/default/components/suffix/abstract/suffix_imp.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text_fields/default/src/default/components/text/abstract/tff_text_imp.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/services/lang/translate_extention.dart';
import '../../../../../../../core/utils/general_utils.dart' show printDM;
import '../../../../builders/conditional_builder.dart';
import 'default/components/decoration/imports_decoration.dart';
import 'default/components/prefix/implementation/imports_prefix.dart';
import 'default/components/suffix/implementation/imports_suffix.dart';
import 'default/components/text/implementation/imports_text.dart';
import 'default/widgets/imports_widgets_tff.dart';
import 'options/imports_options.dart';

part 'text_field_default.dart';
