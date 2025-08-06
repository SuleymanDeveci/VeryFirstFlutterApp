import 'package:grpc/grpc.dart';

ClientChannel? _ioChannel;

dynamic createChannel() {
  _ioChannel = ClientChannel(
    '10.100.103.62',
    port: 5290,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
      connectionTimeout: Duration(seconds: 100),
    ),
  );
  return _ioChannel!;
}

void disposeChannel() {
  _ioChannel?.shutdown();
  _ioChannel = null;
}