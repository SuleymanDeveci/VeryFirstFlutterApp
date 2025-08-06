import 'package:grpc/grpc_web.dart';

GrpcWebClientChannel? _webChannel;

dynamic createChannel() {
  _webChannel = GrpcWebClientChannel.xhr(
    Uri.parse("http://10.100.103.62:8080"),
  );
  return _webChannel!;
}

void disposeChannel() {
  _webChannel = null;
}