import 'dart:io';

import 'package:dio/dio.dart';
import 'package:coursaty/src/core/network_structure/networking/src/interfaces/methods/get_method.dart';
import 'package:coursaty/src/core/network_structure/networking/src/interfaces/methods/post_method.dart';
import 'package:coursaty/src/core/network_structure/networking/src/resources/dio_service/handler/dio_response_handler.dart';
import 'package:coursaty/src/core/network_structure/networking/src/utils/header_handler.dart';
import 'package:coursaty/src/core/network_structure/networking/src/utils/network_logger.dart';
import 'package:coursaty/src/core/network_structure/networking/src/utils/network_utils.dart';
import 'package:coursaty/src/core/utils/general_utils.dart';
import 'package:coursaty/src/core/utils/utils.dart';

import '../../../../../data_source/service_interface.dart';

part 'dio_get.dart';
part 'dio_post.dart';
