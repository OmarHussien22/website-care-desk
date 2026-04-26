import 'dart:io';

import 'package:coursaty/src/core/constants/strings/app_strings.dart';
import 'package:coursaty/src/core/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../utils/snack_utils/src/constants/snack_constants.dart';
import '../package_info/package_info.dart';

class LauncherServices {
  LauncherServices._();

  static final LauncherServices instance = LauncherServices._();

  Future<void> launchToMail(String email) async {
    await launchUrl(Uri.parse('mailto:$email'));
  }

  Future<void> launchToSite(String site) async {
    final Uri uri = Uri.parse(site);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Utils.showToast(
        title: 'this_site_is_not_valid',
        state: UtilState.error,
      );
      throw 'Could not launch $site';
    }
  }

  Future<void> launchToWhatsApp(String phone) async {
    final Uri url = Uri.parse('https://wa.me/$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchWhatsAppUri(String phone) async {
    final link = WhatsAppUnilink(
      phoneNumber: phone,
      text: '${AppStrings.appName} تواصل مع الدعم الفني لابلكيشن ',
    );
    await launchUrl(link.asUri(), mode: LaunchMode.externalApplication);
  }

  Future<void> launchToPhone(String phone) async {
    final Uri url = Uri.parse('tel:$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> openAppInAllStore({String? linkStore}) async {
    final Uri url = checkLinkStore(linkStore: linkStore);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchYoutube({required String url}) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchMapApp({required String lat, required String lng}) async {
    final Uri uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $uri';
    }
  }

  Uri checkLinkStore({String? linkStore}) {
    final String packageName = PackageInfoGetter.packageName;
    final String safeLink = linkStore ?? '';

    if (Platform.isAndroid) {
      return Uri.parse(
        safeLink.isEmpty
            ? 'https://play.google.com/store/apps/details?id=$packageName'
            : safeLink,
      );
    }

    return Uri.parse(
      safeLink.isEmpty ? 'https://www.apple.com/' : safeLink,
    );
  }
}
