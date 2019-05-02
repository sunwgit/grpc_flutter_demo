import 'package:flutter/material.dart';
import 'dart:async';
import 'package:grpc/grpc.dart';
import 'package:flutter_demo/api/hello.pb.dart';
import 'package:flutter_demo/api/hello.pbgrpc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<HelloReply> _callServer(List<String> args) async {
  final channel = ClientChannel('192.168.1.64',
      port: 50051,
      options: const ChannelOptions(
          credentials: const ChannelCredentials.insecure()));
  final stub = GretterClient(channel);

  final name = args.isNotEmpty ? args[0] : 'world';

  try {
    final response = await stub.sayHello(HelloRequest()..name = name);
    print('Greeter client received: ${response.message}');
    return response;
  } catch (e) {
    print('Caught error: $e');
  } finally {
    await channel.shutdown();
  }
  return HelloReply();
}

class _MyHomePageState extends State<MyHomePage> {
  String msg = 'Init';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: Text(msg)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _callServer(['HelloRequest']).then((_) {
            setState(() {
              msg = msg == 'Init' ? _.message : 'Init';
            });
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.change_history),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
