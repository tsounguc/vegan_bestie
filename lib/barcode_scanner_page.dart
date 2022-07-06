import 'package:flutter/material.dart';
// import 'package:scan/scan.dart';

class VBBarcodeScanner extends StatefulWidget {
  const VBBarcodeScanner({Key? key}) : super(key: key);

  @override
  State<VBBarcodeScanner> createState() => _VBBarcodeScannerState();
}

class _VBBarcodeScannerState extends State<VBBarcodeScanner> {
  var _scanResult = '';
  // ScanController controller = ScanController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.transparent,
            height: 4.0,
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Text('Scan Your Barcode'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 350,
                // width: 250,
                // child: ScanView(
                //   controller: controller,
                //   scanAreaScale: 1.0,
                //   scanLineColor: Colors.green.shade800,
                //   onCapture: (data) {
                //     setState(() {
                //       _scanResult = data;
                //       debugPrint("Barcode: " + _scanResult);
                //       Navigator.of(context).pop();
                //     });
                //   },
                // ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.cancel, color: Colors.white, size: 48,),
                    ),
                  ),
                  Container(
                    // alignment: Alignment.center,
                    // padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      // onTap: () => controller.toggleTorchMode(),
                      child: const Icon(Icons.flash_on, color: Colors.white, size: 48,),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
