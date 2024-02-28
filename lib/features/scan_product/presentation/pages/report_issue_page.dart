import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/common/widgets/vegan_bestie_logo_widget.dart';
import 'package:sheveegan/core/utils/size_config.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/select_incorrect_information.dart';

class ReportIssuePage extends StatelessWidget {
  const ReportIssuePage({super.key});

  static const String id = '/reportIssuePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        toolbarHeight: toolbarHeight,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: const CustomBackButton(
          color: Colors.black,
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: VeganBestieLogoWidget(size: 25, fontSize: 35),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "What's the issue?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(SelectIncorrectInformation.id);
              },
              title: Text(
                'Incorrect product information',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
            // ListTile(
            //   onTap: () {},
            //   title: Text(
            //     "Product not found",
            //     style: TextStyle(color: Colors.black, fontSize: 14.sp),
            //   ),
            //   trailing: Icon(
            //     Icons.arrow_forward_ios,
            //     size: 16,
            //   ),
            // ),
            ListTile(
              onTap: () {},
              title: Text(
                'Incorrect Product',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
