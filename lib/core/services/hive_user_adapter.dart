import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0; // Unique ID for User class

  @override
  User read(BinaryReader reader) {
    try {

      // print(requiredBytes());
      // print(reader.availableBytes.toString());
      // // Ensure there are enough bytes to read a complete User object
      // if (reader.availableBytes < requiredBytes()) {
      //   throw RangeError('Not enough bytes available');
      // }
      //
      // print('Available bytes: ${reader.availableBytes}');

      return User(
        id: reader.readInt(),
        firstName: reader.readString(),
        lastName: reader.readString(),
        username: reader.readString(),
        email: reader.readString(),
        profile: reader.readString()
      );
    } catch (e) {
      print('Error reading user: $e');
      rethrow; // Rethrow the exception if caught
    }
  }

  @override
  void write(BinaryWriter writer, User obj) {
    if (obj == null || !obj.isValid()) {
      throw Exception('Invalid User object');
    }
    writer.writeInt(obj.id);
    writer.writeString(obj.firstName ?? "");
    writer.writeString(obj.lastName ?? "");
    writer.writeString(obj.username ?? "");
    writer.writeString(obj.email ?? "");
    writer.writeString(obj.profile);
  }

  int requiredBytes() {
    // Calculate the minimum bytes needed for a complete User object
    // Assuming fixed length for int (4 bytes) and bool (1 byte)
    return 4 + // id
        1 + // isVerified
        5 * 50; // Approximation for string fields (adjust if necessary)
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