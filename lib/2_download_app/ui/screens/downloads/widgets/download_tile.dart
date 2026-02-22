import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  IconData get statusIcon {
    if (controller.status == DownloadStatus.notDownloaded) {
      return Icons.download;
    }
    if (controller.status == DownloadStatus.downloading) {
      return Icons.downloading;
    }
    return Icons.folder;
  }

  bool get showProgress =>
      controller.status == DownloadStatus.downloading ||
      controller.status == DownloadStatus.downloaded;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        final double percent = controller.progress * 100;
        final double downloadedSize = controller.ressource.size * controller.progress;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: GestureDetector(
            onTap: () {
              controller.startDownload();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.ressource.name,
                          style: AppTextStyles.label.copyWith(color: AppColors.text),
                        ),
                        if (showProgress) ...[
                          SizedBox(height: 6),
                          Text(
                            "${percent.toStringAsFixed(1)} % completed - "
                            "${downloadedSize.toStringAsFixed(1)} of ${controller.ressource.size} MB",
                            style: AppTextStyles.label.copyWith(
                              color: AppColors.textLight,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(statusIcon, color: AppColors.iconNormal),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
