import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/features/home/data/models/test_results_model.dart';
import 'package:healr/features/home/presentation/views/widgets/view_pdf.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class TestResultsContainer extends StatelessWidget {
  final TestResultModel result;

  const TestResultsContainer({super.key, required this.result});

  Future<void> downloadPdf(
      String assetPath, String fileName, BuildContext context) async {
    try {
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission denied')),
        );
        return;
      }

      final byteData = await rootBundle.load(assetPath);
      final bytes = byteData.buffer.asUint8List();

      final dir = Platform.isAndroid
          ? Directory('/storage/emulated/0/Download')
          : await getApplicationDocumentsDirectory();

      if (!await dir.exists()) await dir.create(recursive: true);

      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(bytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved to ${file.path}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xffEFF6FF),
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.1),
              blurRadius: 10.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SvgPicture.asset(
            //   'assets/images/test.svg',
            //   height: 32.h,
            //   width: 32.w,
            // ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.title,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    result.date,
                    style: TextStyle(
                        fontSize: 12.sp, color: const Color(0xff666666)),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    result.result,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff1A1A1A)),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PDFViewer(
                        assetPath: 'assets/test-results-form.pdf'),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffA1A1AA)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    const Icon(HugeIcons.strokeRoundedView,
                        color: Color(0xff1A1A1A)),
                    SizedBox(width: 8.w),
                    Text(
                      'PDF',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff1A1A1A)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
