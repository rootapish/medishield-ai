import 'package:mobile_scanner/mobile_scanner.dart';

String barcodeFormatLabel(BarcodeFormat format) {
  return switch (format) {
    BarcodeFormat.qrCode => 'QR Code',
    BarcodeFormat.ean13 => 'EAN-13',
    BarcodeFormat.ean8 => 'EAN-8',
    BarcodeFormat.code128 => 'Code 128',
    BarcodeFormat.code39 => 'Code 39',
    BarcodeFormat.code93 => 'Code 93',
    BarcodeFormat.upcA => 'UPC-A',
    BarcodeFormat.upcE => 'UPC-E',
    BarcodeFormat.dataMatrix => 'Data Matrix',
    BarcodeFormat.pdf417 => 'PDF417',
    BarcodeFormat.aztec => 'Aztec',
    BarcodeFormat.itf14 => 'ITF-14',
    BarcodeFormat.codabar => 'Codabar',
    _ => 'Barcode',
  };
}
