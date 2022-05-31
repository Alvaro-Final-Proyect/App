import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:padel/data/models/user_response.dart';
import 'package:padel/res/constants.dart';

extension ImageExtensions on Image {
  static ImageProvider fromUser(UserModel userModel) {
    return userModel.image == null
        ? Image.network(userImageUrl).image
        : Image.memory(base64Decode(userModel.image!)).image;
  }
}