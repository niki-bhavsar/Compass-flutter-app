import 'package:compass_software/data/entity/announcement_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/utils/intl_utils.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  final AnnouncementInfo announcementDetail;
  const AnnouncementDetailScreen({super.key, required this.announcementDetail});

  @override
  Widget build(BuildContext context) {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);
    controller.loadHtmlString(announcementDetail.description);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.announcementScreen_detail_title),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              announcementDetail.title,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end, // Align to the right
              children: [
                Text(
                  IntlUtil.getFullDate(announcementDetail.createDate, dateFormat: "MM/dd/yyyy") ??
                      "",
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: WebViewWidget(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
