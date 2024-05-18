import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0; // Unique ID for User class

  @override
  User read(BinaryReader reader) {
    return User(
      id: reader.read(),
      uuid: reader.read(),
      name: reader.read(),
      username: reader.read(),
      email: reader.read(),
      tel: reader.read(),
      role: reader.read(),
      profile: reader.read(),
      otp: reader.read(),
      isVerified: reader.read(),
      googleToken: reader.read(),
      emailVerifiedAt: reader.read(),
      createdAt: reader.read(),
      updatedAt: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.write(obj.id);
    writer.write(obj.uuid);
    writer.write(obj.name);
    writer.write(obj.username);
    writer.write(obj.email);
    writer.write(obj.tel);
    writer.write(obj.role);
    writer.write(obj.profile);
    writer.write(obj.otp);
    writer.write(obj.isVerified);
    writer.write(obj.googleToken);
    writer.write(obj.emailVerifiedAt);
    writer.write(obj.createdAt);
    writer.write(obj.updatedAt);
  }
}


class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  final typeId = 123; // Choose a unique ID for your adapter

  @override
  ThemeMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        throw Exception('Unsupported ThemeMode value');
    }
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    switch (obj) {
      case ThemeMode.system:
        writer.writeByte(0);
        break;
      case ThemeMode.light:
        writer.writeByte(1);
        break;
      case ThemeMode.dark:
        writer.writeByte(2);
        break;
    }
  }
}