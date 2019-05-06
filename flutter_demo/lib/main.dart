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

Future<Person> _callServer(List<String> args) async {
  final channel = ClientChannel('192.168.10.15',
      port: 50051,
      options: const ChannelOptions(
          credentials: const ChannelCredentials.insecure()));
  final stub = GretterClient(channel);

  final name = args.isNotEmpty ? args[0] : 'world';

  try {
    final response = await stub.sayHello(HelloRequest()..name = name);
    print('Greeter client received: \n');
    print(response);
    return response;
  } catch (e) {
    print('Caught error: $e');
  } finally {
    await channel.shutdown();
  }
  return Person();
}

class _MyHomePageState extends State<MyHomePage> {
  Person _person = Person()
    ..name = 'init'
    ..age = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '姓名:${_person.name}',
          ),
          Text(
            '年龄:${_person.age}',
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _callServer(['HelloRequest']).then((_) {
            setState(() {
              _person = _;
            });
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.change_history),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
