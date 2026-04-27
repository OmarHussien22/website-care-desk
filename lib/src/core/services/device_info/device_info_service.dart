import 'dart:io';

import '../lang/translate_extention.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import '../utils/general_utils.dart';

class DeviceInfoService {
  DeviceInfoService._();

  static final DeviceInfoService instance = DeviceInfoService._();

  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<String> getDeviceId() async {
    String deviceId;
    if (Platform.isAndroid) {
      try {
        final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        printDM(
          'Running on ${androidInfo.model} ${androidInfo.id} ${androidInfo.type}',
        );
        deviceId = '${androidInfo.model}-${androidInfo.id}-${androidInfo.type}';
      } catch (_) {
        deviceId = 'Unknown Device Id';
      }
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor.toString();
      printDM('Running on ${iosInfo.identifierForVendor}');
    } else {
      deviceId = 'Unknown Device Id';
    }
    return deviceId;
  }

  Future<String> get type async {
    String deviceType;
    if (Platform.isAndroid) {
      try {
        final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        deviceType = androidInfo.model;
      } catch (_) {
        deviceType = 'Unknown Device Type';
      }
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      deviceType = iosInfo.name;
    } else if (Platform.isWindows) {
      deviceType = '${'windows'.toTr()} ,  ${Platform.operatingSystem}';
    } else {
      deviceType = 'Unknown Device Type';
    }
    return deviceType;
  }

  final List<String> getDeviceList = [
    'blueStacks',
    'blue Stacks',
    'BlueStack',
    'BlueStacks',
    'NoxPlayer',
    'nox',
    'Nox',
    'MAME',
    'Dolphin',
    'Gemu',
    'player',
    'Player',
    'ePSXe',
    'PCSX2',
    'RereoArch',
    'LDPlayer',
    'LD',
    'Ld',
    'ld',
    'play',
    'Play',
    'MEMU Play',
    'MEMUPlay',
    'MEmu',
    'MEmu Play',
    'Memu',
    'Mumu',
    'MuMu',
    'Genymotion',
    'genymotion',
  ];

  Future<void> getDeviceName() async {
    if (!Platform.isAndroid) return;

    final deviceId = await _deviceInfo.androidInfo;
    printDM('My device manufacturer is ${deviceId.manufacturer}');
    printDM('My device fingerprint is ${deviceId.fingerprint}');
    printDM('My device isPhysicalDevice is ${deviceId.isPhysicalDevice}');
    printDM('My device id is ${deviceId.id}');
    printDM('My device type is ${deviceId.type}');
    printDM('My device data is ${deviceId.data}');
    printDM('My device board is ${deviceId.board}');
    printDM('My device bootloader is ${deviceId.bootloader}');
    printDM('My device brand is ${deviceId.brand}');
    printDM('My device device is ${deviceId.device}');
    printDM('My device display is ${deviceId.display}');
    printDM('My device hardware is ${deviceId.hardware}');
    printDM('My device host is ${deviceId.host}');
    printDM('My device isLowRamDevice is ${deviceId.isLowRamDevice}');
    printDM('My device model is ${deviceId.model}');
    printDM('My device product is ${deviceId.product}');
    // printDM('My device serialNumber is ${deviceId.serialNumber}');
    printDM('My device supported32BitAbis is ${deviceId.supported32BitAbis}');
    printDM('My device supportedAbis is ${deviceId.supportedAbis}');
    printDM('My device systemFeatures is ${deviceId.systemFeatures}');
    printDM('My device supported64BitAbis is ${deviceId.supported64BitAbis}');
    printDM('My device tags is ${deviceId.tags}');
    printDM('My device version is ${deviceId.version}');
    for (final element in getDeviceList) {
      if (deviceId.model.contains(element)) {
        printDM('device name is ${deviceId.model}');
        exit(0);
      }
    }
  }

  Future<AndroidOverscrollIndicator> get androidScrollIndicator async {
    final androidInfo = await _deviceInfo.androidInfo;
    final sdkVersion = androidInfo.version.sdkInt;
    return sdkVersion > 30
        ? AndroidOverscrollIndicator.stretch
        : AndroidOverscrollIndicator.glow;
  }
}
