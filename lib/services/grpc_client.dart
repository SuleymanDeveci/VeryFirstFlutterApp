import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_web.dart';
import '../proto/generated/DemirbasService.pbgrpc.dart';

class GrpcClient {
  static final GrpcClient _instance = GrpcClient._internal();
  late DemirbasServiceClient _client;
  dynamic _channel;
  bool _isInitialized = false;

  // Singleton pattern
  factory GrpcClient() {
    return _instance;
  }

  GrpcClient._internal();

  dynamic _createChannel() {
    if (kIsWeb) {
      return GrpcWebClientChannel.xhr(
        Uri.parse("http://10.100.103.62:8080"), // Web için proxy veya gRPC-Web endpoint
      );
    } else if (Platform.isWindows || Platform.isAndroid || Platform.isIOS) {
      return ClientChannel(
        '10.100.103.62',
        port: 5290,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          connectionTimeout: Duration(seconds: 100),
        ),
      );
    } else {
      throw UnsupportedError('Desteklenmeyen platform');
    }
  }

  Future<void> initialize() async {
    if (!_isInitialized) {
      _channel = _createChannel();
      _client = DemirbasServiceClient(_channel);
      _isInitialized = true;
    }
  }

  Future<InsertDemirbasResponse> insertDemirbas({
    required String demirbasNum,
    required String ipAddress,
    required String os,
    required String hardwareInfo,
  }) async {
    if (!_isInitialized) await initialize();

    final request = InsertDemirbasRequest()
      ..demirbasNum = demirbasNum
      ..ipAddress = ipAddress
      ..os = os
      ..hardwareInfo = hardwareInfo;

    try {
      final response = await _client.insertDemirbas(request);
      return response;
    } catch (e) {
      print('Hata oluştu: $e');
      return InsertDemirbasResponse()
        ..success = false
        ..message = 'Bağlantı hatası: $e';
    }
  }

  Future<SearchDemirbasResponse> searchDemirbas({
    String? ipAddress,
    String? demirbasNum,
  }) async {
    if (!_isInitialized) await initialize();

    final request = SearchDemirbasRequest();
    if (ipAddress != null && ipAddress.isNotEmpty) {
      request.ipAddress = ipAddress;
    }
    if (demirbasNum != null && demirbasNum.isNotEmpty) {
      request.demirbasNum = demirbasNum;
    }

    try {
      final response = await _client.searchDemirbas(request);
      return response;
    } catch (e) {
      print('Arama hatası: $e');
      throw Exception('gRPC hatası: $e');
    }
  }

  void dispose() {
    if (_isInitialized) {
      if (!kIsWeb) {
        (_channel as ClientChannel).shutdown();
      }
      _isInitialized = false;
    }
  }
}