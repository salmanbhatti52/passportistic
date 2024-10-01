import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:scanguard/main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ScreenshotService {
  // Capture screenshot and share it as an image
  static Future<void> captureAndShareScreenshot() async {
    final image = await screenshotController.capture();
    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/screenshot.png').create();
      await imagePath.writeAsBytes(image);

      // Share the image file
      await Share.shareXFiles([XFile(imagePath.path)], text: 'Check out my passport');
    }
  }

  // Capture screenshot and save it as a PDF
  static Future<void> captureAndSaveAsPDF() async {
    final image = await screenshotController.capture();
    if (image != null) {
      final pdf = pw.Document();
      final imagePdf = pw.MemoryImage(image);
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(child: pw.Image(imagePdf));
          },
        ),
      );

      final directory = await getApplicationDocumentsDirectory();
      final pdfPath = File('${directory.path}/screenshot.pdf');
      await pdfPath.writeAsBytes(await pdf.save());

      // Share or print the PDF file
      await Printing.sharePdf(bytes: await pdf.save(), filename: 'screenshot.pdf');
    }
  }
}
