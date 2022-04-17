
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//UI
part 'package:client/common/home.dart';
part 'package:client/common/login.dart';

//Admin UI
part 'package:client/admin/partner/partner_form.dart';
part 'package:client/admin/user/user_form.dart';
part 'package:client/admin/map_form.dart';

//Model
part 'package:client/models/Product.dart';
part 'package:client/models/User.dart';

//Controller
part 'package:client/controllers/user_controller.dart';

//Function
part 'functions.dart';

//Constants
part 'constants.dart';
