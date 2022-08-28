import 'package:flutter/material.dart';
import 'package:sound_recorder/recorder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final recorder = Record();

  @override
  void initState() {
    recorder!.init();
    super.initState();
  }

  @override
  void dispose() {  
    recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sound Recorder App'),
      ),
      body: Center(
        child: buildStartButton(),
      ),
    );
  }

  Widget? buildStartButton() {
    final isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? 'STOP' : 'START';
    final primary = isRecording ? Colors.red : Colors.white;
    final onPrimary = isRecording ? Colors.white : Colors.black;

    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(175, 50),
          primary: primary,
          onPrimary: onPrimary,
        ),
        onPressed: () async {
          final isRecording = await recorder.toggleRecorder();
          setState(() {
            
          });
        },
        icon: Icon(icon),
        label: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ));
  }
}
