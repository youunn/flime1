import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flime/api/native.dart';
import 'package:flime/input/core/engine.dart';
import 'package:flime/input/core/processors/post_filter.dart';
import 'package:flime/input/schemas/options.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_android/path_provider_android.dart';

class OpenCCFilter extends PostFilter {
  static OpenCCFilter? _filter;

  OpenCCFilter._();

  factory OpenCCFilter() => _filter ??= OpenCCFilter._();

  final Map<String, Enum> _options = {
    Options.opencc: OpenCCOption.off,
  };

  @override
  Map<String, Enum> get options => _options;

  static Future<OpenCCFilter> createAsync() async {
    await loadAssets();
    return _filter ??= OpenCCFilter._();
  }

  @override
  Future<List<String>> process(List<String> candidates, Engine engine) async {
    final option = engine.getOption(Options.opencc);
    if (option == OpenCCOption.off) return candidates.toList();
    final opencc = NativeOpenCC();
    final currentConfig = _optionMap[option];
    if (opencc.convertConfig != currentConfig && currentConfig != null) {
      opencc.convertConfig = currentConfig;
    }
    return await opencc.convertList(candidates);
  }

  static Future<bool> loadAssets() async {
    if (!Platform.isAndroid) return false;
    PathProviderAndroid.registerWith();
    final parent = await getApplicationDocumentsDirectory();
    final outputPath = join(parent.path, 'opencc');
    final s2hkPath = join(outputPath, 's2hk.json');
    final loaded = await File(s2hkPath).exists();
    if (loaded) return true;

    final directory = Directory(outputPath);
    await directory.create(recursive: true);

    final List<String> paths = json
        .decode(await rootBundle.loadString('AssetManifest.json'))
        .keys
        .where((String k) => k.startsWith(join('assets', 'opencc')))
        .toList();

    for (final path in paths) {
      final data = await rootBundle.load(path);
      final bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      final output = join(directory.path, basename(path));
      await File(output).writeAsBytes(bytes);
    }

    return true;
  }
}

class NativeOpenCC {
  static NativeOpenCC? _opencc;

  NativeOpenCC._() {
    _convertConfig = ConvertConfig.s2hk;
    _convertConfigPath = getApplicationDocumentsDirectory()
        .then((d) => join(join(d.path, 'opencc'), _configMap[_convertConfig]))
        .then((s) => s.toNativeUtf8());
  }

  factory NativeOpenCC() => _opencc ??= NativeOpenCC._();

  final _nativeConvert = Convert(DynamicLibrary.open('libconvert.so'));
  late ConvertConfig _convertConfig;
  late Future<Pointer<Utf8>> _convertConfigPath;

  ConvertConfig get convertConfig => _convertConfig;

  set convertConfig(ConvertConfig value) {
    _convertConfig = value;
    _convertConfigPath = getApplicationDocumentsDirectory()
        .then((d) => join(join(d.path, 'opencc'), _configMap[_convertConfig]))
        .then((s) => s.toNativeUtf8());
  }

  Future<String> convert(String input) async {
    final inputPointer = input.toNativeUtf8();
    final outputPointer = _nativeConvert.convert(
        (await _convertConfigPath).cast(), inputPointer.cast());
    final output = outputPointer.cast<Utf8>().toDartString();
    malloc
      ..free(inputPointer)
      ..free(outputPointer);
    return output;
  }

  Future<List<String>> convertList(List<String> inputs) async {
    final pointers = inputs.map((s) => s.toNativeUtf8()).toList();
    final pointerPointer = malloc<Pointer<Utf8>>(inputs.length);

    for (var i = 0; i < inputs.length; i++) {
      pointerPointer[i] = pointers[i];
    }

    final outputPointerPointer = _nativeConvert.convertList(
        (await _convertConfigPath).cast(),
        pointerPointer.cast(),
        inputs.length);

    final result = _toDartString(outputPointerPointer.cast()).toList();

    pointers.forEach(calloc.free);
    malloc
      ..free(pointerPointer)
      ..free(outputPointerPointer);

    return result;
  }

  Iterable<String> _toDartString(
      Pointer<Pointer<Utf8>> charPointerPointer) sync* {
    if (charPointerPointer == nullptr) return;
    for (var i = 0; i < 200; i++) {
      final charPointer = charPointerPointer[i];
      if (charPointer == nullptr) return;
      final s = charPointer.toDartString();
      yield s;
      malloc.free(charPointer);
    }
  }
}

enum ConvertConfig {
  hk2s, //hk2s.json
  hk2t, //hk2t.json
  jp2t, //jp2t.json
  s2hk, //s2hk.json
  s2t, //s2t.json
  s2tw, //s2tw.json
  s2twp, //s2twp.json
  t2hk, //t2hk.json
  t2s, //t2s.json
  t2tw, //t2tw.json
  t2jp, //t2jp.json
  tw2s, //tw2s.json
  tw2t, //tw2t.json
  tw2sp, //tw2sp.json
}

final _configMap = <ConvertConfig, String>{
  ConvertConfig.hk2s: 'hk2s.json',
  ConvertConfig.hk2t: 'hk2t.json',
  ConvertConfig.jp2t: 'jp2t.json',
  ConvertConfig.s2hk: 's2hk.json',
  ConvertConfig.s2t: 's2t.json',
  ConvertConfig.s2tw: 's2tw.json',
  ConvertConfig.s2twp: 's2twp.json',
  ConvertConfig.t2hk: 't2hk.json',
  ConvertConfig.t2s: 't2s.json',
  ConvertConfig.t2tw: 't2tw.json',
  ConvertConfig.t2jp: 't2jp.json',
  ConvertConfig.tw2s: 'tw2s.json',
  ConvertConfig.tw2t: 'tw2t.json',
  ConvertConfig.tw2sp: 'tw2sp.json',
};

final _optionMap = <OpenCCOption, ConvertConfig>{
  OpenCCOption.hk: ConvertConfig.s2hk,
  OpenCCOption.t: ConvertConfig.s2t,
  OpenCCOption.tw: ConvertConfig.s2tw,
  OpenCCOption.twp: ConvertConfig.s2twp,
};
