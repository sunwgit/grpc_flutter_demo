import 'dart:async';
import 'dart:math';

import 'package:grpc/grpc.dart';

import './api/hello.pb.dart';
import './api/hello.pbgrpc.dart';

class GreeterService extends GretterServiceBase {
  @override
  Future<Person> sayHello(ServiceCall call, HelloRequest request) async {
    return Person()
      ..name = 'jack${Random().nextInt(10)}'
      ..age = Random().nextInt(10);
  }
}

Future<void> main(List<String> args) async {
  final server = Server([GreeterService()]);
  await server.serve(port: 50051);
  print('Server listening on port ${server.port}...');
}
