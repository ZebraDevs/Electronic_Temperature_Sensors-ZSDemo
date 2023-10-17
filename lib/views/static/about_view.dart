import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/constants/constants.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/utils/app_utils.dart';
import 'package:zsdemo_app/components/view_widgets/package_info_widget.dart';
import 'package:zsdemo_app/generated/l10n.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PackageInfoWidget(),
            ZSAboutListTile(
              label: Loco.of(context).zsFinderVersion,
              value: 'v0.3.730 or newer',
            ),
            const DeviceInfoWidget(),
            ...[
              const SizedBox(
                height: 16,
              ),
              Text(Loco.of(context).dataAPIs),
              const SizedBox(
                height: 4,
              ),
              Text(
                'V2',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ZSColors.secondaryDark),
              ),
              const SizedBox(
                height: 4,
              ),
            ],
            ZSAboutListTile(
              label: Loco.of(context).sensorFWVersion,
              value: 'D01_0_1_779 or newer',
            ),
            ZSAboutListTile(
              label: Loco.of(context).copyrightDate,
              value: '${DateTime.now().year}',
            ),
            const SizedBox(
              height: 36,
            ),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Loco.of(context).ossAttributions),
                  const Icon(Icons.arrow_forward_ios, color: ZSColors.primary),
                ],
              ),
              onTap: () => openLink(urlOSSAttributions),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class ZSAboutListTile extends StatelessWidget {
  final String label;
  final String value;

  const ZSAboutListTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(label),
        const SizedBox(
          height: 4,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ZSColors.secondaryDark),
        ),
      ],
    );
  }
}

class DeviceInfoWidget extends StatefulWidget {
  const DeviceInfoWidget({super.key});

  @override
  State<DeviceInfoWidget> createState() => _DeviceInfoWidgetState();
}

class _DeviceInfoWidgetState extends State<DeviceInfoWidget> {
  String? version;

  @override
  void initState() {
    super.initState();
    getDeviceInfo();
  }

  Future<void> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    final androidInfo = await deviceInfo.androidInfo;
    final _version = '${androidInfo.version.release} (${androidInfo.id})';
    setState(() {
      version = _version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZSAboutListTile(
      label: Loco.of(context).androidVersion,
      value: version ?? '',
    );
  }
}
