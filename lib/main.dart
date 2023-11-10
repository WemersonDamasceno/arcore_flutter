// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableTapRecognizer: true,
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    _addCylindre();
    _addCube();
    _addObject3DInInternet();
  }

  void _addCylindre() {
    final material = ArCoreMaterial(
      color: Colors.red,
    );
    final cylindre = ArCoreCylinder(
      materials: [material],
      radius: 0.5,
      height: 0.3,
    );
    final node = ArCoreNode(
      shape: cylindre,
      position: vector.Vector3(0.0, -0.5, -2.0),
    );
    arCoreController.addArCoreNode(node);
  }

  void _addCube() {
    final material = ArCoreMaterial(
      color: Colors.red,
      metallic: 1.0,
    );
    final cube = ArCoreCube(
      materials: [material],
      size: vector.Vector3(0.5, 0.5, 0.5),
    );
    final node = ArCoreNode(
      shape: cube,
      position: vector.Vector3(-0.5, 0.5, -3.5),
    );
    arCoreController.addArCoreNode(node);
  }

  void _addObject3DInInternet() {
    final node = ArCoreReferenceNode(
      objectUrl:
          'https://github.com/KhronosGroup/glTF-Sample-Models/blob/master/2.0/SheenChair/glTF/SheenChair.gltf',
      name: 'object3D',
      position: vector.Vector3(0.0, 0.0, -1.0),
      scale: vector.Vector3(0.2, 0.2, 0.2),
      object3DFileName: 'object3D',
    );

    arCoreController.addArCoreNode(node);
  }
}
