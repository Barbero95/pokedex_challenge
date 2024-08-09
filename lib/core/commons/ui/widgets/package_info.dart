import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class _Constants {
  static const double versionFontSize = 12;
}

class PackageInfoWidget extends StatelessWidget {
  const PackageInfoWidget({super.key});

  Future<PackageInfo> _getPackageInfo() async => PackageInfo.fromPlatform();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: _getPackageInfo(),
      builder: (context, AsyncSnapshot<PackageInfo> snapshot) {
        if (snapshot.hasData) {
          return Text(
            'v${snapshot.requireData.version}+${snapshot.requireData.buildNumber}',
            style: const TextStyle(
              fontSize: _Constants.versionFontSize,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
