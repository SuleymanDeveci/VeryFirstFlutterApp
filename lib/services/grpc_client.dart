import 'package:grpc/grpc.dart';
import '../proto/generated/DemirbasService.pbgrpc.dart';

class GrpcClient {
  static final GrpcClient _instance = GrpcClient._internal();
  late DemirbasServiceClient _client;
  late ClientChannel _channel;
  bool _isInitialized = false;

  // Singleton pattern
  factory GrpcClient() {
    return _instance;
  }

  GrpcClient._internal();

  Future<void> initialize() async {
    if (!_isInitialized) {
      _channel = ClientChannel(
        '10.100.103.62', // gRPC server host
        port: 5290, // gRPC server port
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(), // Güvenli bağlantı için SSL/TLS kurulumu gerekli
          connectionTimeout: Duration(seconds: 100),
        ),
      );
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
      _channel.shutdown();
      _isInitialized = false;
    }
  }
}
