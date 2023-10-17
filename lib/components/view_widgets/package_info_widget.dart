import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoWidget extends StatelessWidget {
  const PackageInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      builder: (context, packageInfoSnapshot) {
        if (packageInfoSnapshot.hasData) {
          final packageInfo = packageInfoSnapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Loco.current.appVersionNumber,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ZSColors.secondaryDark,
                    ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                packageInfo.version,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ZSColors.secondaryDark),
              ),
            ],
          );
        }
        return const Text('');
      },
      future: PackageInfo.fromPlatform(),
    );
  }
}
