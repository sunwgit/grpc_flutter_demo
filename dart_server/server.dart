import 'dart:async';

import 'package:grpc/grpc.dart';

import './api/hello.pb.dart';
import './api/hello.pbgrpc.dart';

class GreeterService extends GretterServiceBase {
  @override
  Future<HelloReply> sayHello(ServiceCall call, HelloRequest request) async {
    return new HelloReply()..message = 'Hello, ${request.name}!';
  }
}

Future<void> main(List<String> args) async {
  final server = new Server([new GreeterService()]);
  print('server.....');
  await server.serve(port: 50051);
  print('Server listening on port ${server.port}...');
}
