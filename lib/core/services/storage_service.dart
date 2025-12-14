import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:sof_task/core/storage/shared_pref_utils.dart';
import 'package:sof_task/features/users/model/user_model.dart';

@lazySingleton
class StorageService {
  // Keys
  final String _bookmarkedUsersKey = 'bookmarked_users';

  List<UserModel> _bookmarkedUsers = [];

  List<UserModel> get bookmarkedUsers => _bookmarkedUsers;

  /// Initialize local storage
  Future<void> init() async {
    _bookmarkedUsers = await getBookmarkedUsers();
  }

  /// Save bookmarked user IDs
  Future<bool> saveBookmarkedUsers(List<UserModel> users) async {
    try {
      final jsonString = jsonEncode(users);
      return await SharedPrefUtils.setCommon(_bookmarkedUsersKey, jsonString);
    } catch (e) {
      debugPrint('Error saving bookmarked users: $e');
      return false;
    }
  }

  /// Get bookmarked user IDs
  Future<List<UserModel>> getBookmarkedUsers() async {
    try {
      String? jsonString = await SharedPrefUtils.getCommon(_bookmarkedUsersKey);
      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }
      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded.map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error loading bookmarked users: $e');
      return [];
    }
  }

  /// Clear all data
  static Future<bool> clearAll() {
    return SharedPrefUtils.clearCommon();
  }
}
