import 'channels/channel_stub.dart'
if (dart.library.io) 'channels/channel_io.dart'
if (dart.library.html) 'channels/channel_web.dart';

import '../proto/generated/DemirbasService.pbgrpc.dart';

class GrpcClient {
  static final GrpcClient _instance = GrpcClient._internal();
  late DemirbasServiceClient _client;
  dynamic _channel;
  bool _isInitialized = false;

  factory GrpcClient() => _instance;
  GrpcClient._internal();

  Future<void> initialize() async {
    if (!_isInitialized) {
      _channel = createChannel();
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
      return await _client.insertDemirbas(request);
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
    if (ipAddress?.isNotEmpty ?? false) request.ipAddress = ipAddress!;
    if (demirbasNum?.isNotEmpty ?? false) request.demirbasNum = demirbasNum!;

    try {
      return await _client.searchDemirbas(request);
    } catch (e) {
      print('Arama hatası: $e');
      throw Exception('gRPC hatası: $e');
    }
  }

  void dispose() {
    if (_isInitialized) {
      disposeChannel();
      _isInitialized = false;
    }
  }
}
