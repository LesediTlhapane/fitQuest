// lib/services/database_service.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DatabaseService {
  Future<void> init();
  Future<String?> saveRun({
    required double distance,
    required int duration,
    required double pace,
    required String type,
    String? path,
  });
  Future<List<Map<String, dynamic>>> getUnsyncedRuns();
  Future<void> markRunAsSynced(String runId);
  Future<List<Map<String, dynamic>>> getAllRuns();
  Future<void> clearAllData();
}

class SharedPrefsDatabaseService implements DatabaseService {
  static const String _runsKey = 'fitquest_runs';
  static const String _pendingOpsKey = 'fitquest_pending_ops';
  
  late SharedPreferences _prefs;
  
  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  @override
  Future<String?> saveRun({
    required double distance,
    required int duration,
    required double pace,
    required String type,
    String? path,
  }) async {
    try {
      final runId = DateTime.now().millisecondsSinceEpoch.toString();
      final runData = {
        'id': runId,
        'distance': distance,
        'duration': duration,
        'pace': pace,
        'type': type,
        'path': path ?? '',
        'date': DateTime.now().toIso8601String(),
        'synced': false,
      };
      
      // Get existing runs
      final runsJson = _prefs.getString(_runsKey);
      final List<Map<String, dynamic>> runs = runsJson != null 
          ? (json.decode(runsJson) as List).cast<Map<String, dynamic>>()
          : [];
      
      // Add new run
      runs.add(runData);
      
      // Save back to shared preferences
      await _prefs.setString(_runsKey, json.encode(runs));
      
      // Also save as pending operation
      await _addPendingOperation('saveRun', runData);
      
      return runId;
    } catch (e) {
      print('Error saving run: $e');
      return null;
    }
  }
  
  Future<void> _addPendingOperation(String type, Map<String, dynamic> data) async {
    try {
      final opsJson = _prefs.getString(_pendingOpsKey);
      final List<Map<String, dynamic>> ops = opsJson != null
          ? (json.decode(opsJson) as List).cast<Map<String, dynamic>>()
          : [];
      
      ops.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'type': type,
        'data': data,
        'created_at': DateTime.now().toIso8601String(),
        'synced': false,
      });
      
      await _prefs.setString(_pendingOpsKey, json.encode(ops));
    } catch (e) {
      print('Error adding pending operation: $e');
    }
  }
  
  @override
  Future<List<Map<String, dynamic>>> getUnsyncedRuns() async {
    try {
      final runsJson = _prefs.getString(_runsKey);
      if (runsJson == null) return [];
      
      final runs = (json.decode(runsJson) as List).cast<Map<String, dynamic>>();
      return runs.where((run) => run['synced'] == false).toList();
    } catch (e) {
      print('Error getting unsynced runs: $e');
      return [];
    }
  }
  
  @override
  Future<void> markRunAsSynced(String runId) async {
    try {
      final runsJson = _prefs.getString(_runsKey);
      if (runsJson == null) return;
      
      final runs = (json.decode(runsJson) as List).cast<Map<String, dynamic>>();
      
      for (int i = 0; i < runs.length; i++) {
        if (runs[i]['id'] == runId) {
          runs[i]['synced'] = true;
          break;
        }
      }
      
      await _prefs.setString(_runsKey, json.encode(runs));
      
      // Also mark pending operations as synced
      await _markPendingOpsAsSynced(runId);
    } catch (e) {
      print('Error marking run as synced: $e');
    }
  }
  
  Future<void> _markPendingOpsAsSynced(String runId) async {
    try {
      final opsJson = _prefs.getString(_pendingOpsKey);
      if (opsJson == null) return;
      
      final ops = (json.decode(opsJson) as List).cast<Map<String, dynamic>>();
      
      for (int i = 0; i < ops.length; i++) {
        if (ops[i]['type'] == 'saveRun' && ops[i]['data']['id'] == runId) {
          ops[i]['synced'] = true;
        }
      }
      
      await _prefs.setString(_pendingOpsKey, json.encode(ops));
    } catch (e) {
      print('Error marking pending ops as synced: $e');
    }
  }
  
  @override
  Future<List<Map<String, dynamic>>> getAllRuns() async {
    try {
      final runsJson = _prefs.getString(_runsKey);
      if (runsJson == null) return [];
      
      return (json.decode(runsJson) as List).cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error getting all runs: $e');
      return [];
    }
  }
  
  @override
  Future<void> clearAllData() async {
    await _prefs.remove(_runsKey);
    await _prefs.remove(_pendingOpsKey);
  }
  
  // Helper method to get pending operations
  Future<List<Map<String, dynamic>>> getUnsyncedOperations() async {
    try {
      final opsJson = _prefs.getString(_pendingOpsKey);
      if (opsJson == null) return [];
      
      final ops = (json.decode(opsJson) as List).cast<Map<String, dynamic>>();
      return ops.where((op) => op['synced'] == false).toList();
    } catch (e) {
      print('Error getting unsynced operations: $e');
      return [];
    }
  }
}