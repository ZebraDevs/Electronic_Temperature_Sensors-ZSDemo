import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void openLink(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    debugPrint("Failed to launch uri: $uri (parsed from url: $url)");
  }
}

String getMacAddress(String macAddress) {
  if (macAddress.contains(":")) {
    return macAddress;
  }
  return macAddress.replaceAllMapped(RegExp("(.{2})"), (match) => "${match.group(0)}:").substring(0, 17);
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}
