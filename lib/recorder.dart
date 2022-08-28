import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

final String pathToSaveAudio = 'audio_sample.aac';

class Record {
  FlutterSoundRecorder? _flutterSoundRecorder;
  bool _isRecorderInitialised = false;

  bool get isRecording => _flutterSoundRecorder!.isRecording;

  Future init() async {
    _flutterSoundRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException(
          'Microphone permission is not enabled');
    }

    await _flutterSoundRecorder!.openAudioSession();
    _isRecorderInitialised = true;
  }

  void dispose() {
    _flutterSoundRecorder!.closeAudioSession();
    _flutterSoundRecorder = null;
    _isRecorderInitialised = false;
  }

  // start voice recording
  Future _startRecording() async {
    if (!_isRecorderInitialised) return;
    await _flutterSoundRecorder!.startRecorder(toFile: pathToSaveAudio);
  }

  // stop voice recording
  Future _stopRecording() async {
    if (!_isRecorderInitialised) return;

    await _flutterSoundRecorder!.stopRecorder();
  }

  Future toggleRecorder() async {
    if (_flutterSoundRecorder!.isStopped) {
      await _startRecording();
    } else {
      await _stopRecording();
    }
  }
}
