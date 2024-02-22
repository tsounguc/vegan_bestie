import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/select_incorrect_information.dart';

import '../../../../core/common/widgets/custom_back_button.dart';
import '../../../../core/constants/size_config.dart';
import '../../../../core/common/widgets/vegan_bestie_logo_widget.dart';

class ReportIssuePage extends StatelessWidget {
  static const String id = "/reportIssuePage";

  const ReportIssuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        toolbarHeight: toolbarHeight,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: CustomBackButton(
          color: Colors.black,
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: VeganBestieLogoWidget(size: 25, fontSize: 35),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "What's the issue?",
                  style: TextStyle(color: Colors.black, fontSize: 20.sp, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(SelectIncorrectInformation.id);
              },
              title: Text(
                "Incorrect product information",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              trailing: Icon(
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
                "Incorrect Product",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
