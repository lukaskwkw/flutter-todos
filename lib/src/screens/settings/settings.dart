import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:whisper_flutter/whisper_flutter.dart';
import "package:cool_alert/cool_alert.dart";

class SettingsPage extends StatefulWidget {
  final String title;
  const SettingsPage({
    super.key,
    required this.title,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String model = "";
  String audio = "";
  String result = "";
  bool is_procces = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: !is_procces,
                replacement: const CircularProgressIndicator(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        late XFile? file;

                        try {
                          const XTypeGroup typeGroup = XTypeGroup(
                              // label: 'images',
                              // extensions: <String>['jpg', 'png'],
                              );
                          file = await openFile(
                              acceptedTypeGroups: <XTypeGroup>[typeGroup]);
                          print(file);
                          // ?.files;
                        } on PlatformException catch (e) {
                          print('Unsupported operation' + e.toString());
                        } catch (e) {
                          print(e.toString());
                        }

                        print("test");
                        // await FilePicker.platform.pickFiles();
                        if (file != null && file.path.isNotEmpty) {
                          setState(() {
                            model = file!.path;
                          });
                        }
                      },
                      child: const Text("set model"),
                    ).padding(all: 10),
                    ElevatedButton(
                      onPressed: () async {
                        late XFile? file;

                        try {
                          const XTypeGroup typeGroup = XTypeGroup(
                              // label: 'images',
                              // extensions: <String>['jpg', 'png'],
                              );
                          file = await openFile(
                              acceptedTypeGroups: <XTypeGroup>[typeGroup]);
                          print(file);
                          // ?.files;
                        } on PlatformException catch (e) {
                          print('Unsupported operation' + e.toString());
                        } catch (e) {
                          print(e.toString());
                        }

                        print("test");
                        // await FilePicker.platform.pickFiles();
                        if (file != null && file.path.isNotEmpty) {
                          setState(() {
                            audio = file!.path;
                          });
                        }
                      },
                      child: const Text("set audio"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (is_procces) {
                          return await CoolAlert.show(
                            context: context,
                            type: CoolAlertType.info,
                            text: "Please wait for the process to finish",
                          );
                        }
                        if (audio.isEmpty) {
                          await CoolAlert.show(
                            context: context,
                            type: CoolAlertType.info,
                            text:
                                "Sorry, the audio is empty, please set it first",
                          );
                          if (kDebugMode) {
                            print("audio is empty");
                          }
                          return;
                        }
                        if (model.isEmpty) {
                          await CoolAlert.show(
                              context: context,
                              type: CoolAlertType.info,
                              text:
                                  "Sorry, the model is empty, please set it first");
                          if (kDebugMode) {
                            print("model is empty");
                          }
                          return;
                        }

                        Future(() async {
                          print("Started transcribe");

                          Whisper whisper = Whisper(
                            whisperLib: "libwhisper.so",
                          );
                          var res = await whisper.request(
                            whisperRequest: WhisperRequest.fromWavFile(
                                audio: File(audio),
                                model: File(model),
                                threads: 16,
                                language: "pl"),
                          );
                          setState(() {
                            result = res.toString();
                            is_procces = false;
                          });
                        });
                        setState(() {
                          is_procces = true;
                        });
                      },
                      child: const Text("Start"),
                    ),
                  ],
                ),
              ),
              Text("model: ${model}").padding(all: 10),
              Text("audio: ${audio}").padding(all: 10),
              Text("Result: ${result}").padding(all: 10),
            ],
          ),
        ),
      ),
    );
  }
}
