import 'package:compass_software/data/entity/technique_library_entity.dart';
import 'package:compass_software/data/shared_pref/session_pref.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TechniqueLibraryDetailScreen extends StatelessWidget {
  final TechniqueLibraryInfo techniqueLibraryDetail;
  const TechniqueLibraryDetailScreen({
    super.key,
    required this.techniqueLibraryDetail,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
    final sessionPref = GetIt.instance.get<SessionPref>();

    return Scaffold(
      appBar: AppBar(
        title: Text(techniqueLibraryDetail.title),
        centerTitle: false,
      ),
      body: SfPdfViewer.network(
        techniqueLibraryDetail.fileUrl,
        key: pdfViewerKey,
        headers: {
          'authtoken': sessionPref.getAuthToken(),
        },
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(context.l10n.techniqueLibraryDetailScreen_failed_alert_title),
                content: Text(context.l10n.techniqueLibraryDetailScreen_failed_document_message),
                actions: [
                  TextButton(
                    onPressed: () => {Navigator.pop(context), Navigator.pop(context)},
                    child: Text(context.l10n.back_button_title),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
