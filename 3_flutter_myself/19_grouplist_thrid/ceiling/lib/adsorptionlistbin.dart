import 'adsorptiondatabin.dart';

class AdsorptionListBin extends AdsorptionData {
  AdsorptionListBin(this.headerName);

  String headerName;

  @override
  String toString() {
    return 'AdsorptionListBin{headerName: $headerName, isHeader: $isHeader}';
  }
}
