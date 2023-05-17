import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/custom_appbar_title_widget.dart';
import 'package:sheveegan/core/custom_back_button.dart';

import '../../../../core/constants/size_config.dart';
import '../../../../core/vegan_bestie_logo_widget.dart';
import '../../../auth/presentation/auth_cubit/auth_cubit.dart';

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
          children: [
            Row(
              children: [
                Text(
                  "What's the issue?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            ListTile(
              onTap: () {},
              title: Text(
                "Product information is incorrect",
                style: TextStyle(color: Colors.black, fontSize: 14.sp),
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
                "Wrong product",
                style: TextStyle(color: Colors.black, fontSize: 14.sp),
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
