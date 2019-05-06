///
//  Generated code. Do not modify.
//  source: hello.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'package:grpc/service_api.dart' as $grpc;

import 'dart:core' as $core show int, String, List;

import 'hello.pb.dart';
export 'hello.pb.dart';

class GretterClient extends $grpc.Client {
  static final _$sayHello = $grpc.ClientMethod<HelloRequest, Person>(
      '/Gretter/SayHello',
      (HelloRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => Person.fromBuffer(value));

  GretterClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<Person> sayHello(HelloRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$sayHello, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class GretterServiceBase extends $grpc.Service {
  $core.String get $name => 'Gretter';

  GretterServiceBase() {
    $addMethod($grpc.ServiceMethod<HelloRequest, Person>(
        'SayHello',
        sayHello_Pre,
        false,
        false,
        ($core.List<$core.int> value) => HelloRequest.fromBuffer(value),
        (Person value) => value.writeToBuffer()));
  }

  $async.Future<Person> sayHello_Pre(
      $grpc.ServiceCall call, $async.Future request) async {
    return sayHello(call, await request);
  }

  $async.Future<Person> sayHello($grpc.ServiceCall call, HelloRequest request);
}
