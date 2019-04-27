/// 目前是手动写的
/// model
/// 网络数据转换为model
/// 数据组装
/// 数据填充
class TradeDetailModel {
  /// 交易时间
  String dealTime;

  /// 交易类型
  String typeDetail;

  /// 收入
  var inCome;

  /// 支出
  var outCome;

  /// 可用余额： 用来进行布局 ， 如果大于0就显示可用余额
  var availableBalance;

  /// 交易时间
  String remain;

  TradeDetailModel({
    this.dealTime,
    this.typeDetail,
    this.inCome,
    this.outCome,
    this.availableBalance,
    this.remain,
  });

  TradeDetailModel.fromJson(Map<String, dynamic> json) {
    dealTime = json["dealTime"];
    typeDetail = json["typeDetail"];
    inCome = json["inCome"];
    outCome = json["outCome"];
    availableBalance = json["availableBalance"];
    remain = json["remain"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['dealTime'] = this.dealTime;
    data['typeDetail'] = this.typeDetail;
    data['inCome'] = this.inCome;
    data['outCome'] = this.outCome;
    data['availableBalance'] = this.availableBalance;
    data['remain'] = this.remain;
  }

  @override
  String toString() {
    return 'TradeDetailModel :\n\t{dealTime:${this.dealTime},\n\ttypeDetail:${this.typeDetail}, \n\tinCome:${this.inCome}, \n\toutCome:${this.outCome}, \n\tavailableBalance:${this.availableBalance}, \n\tremian:${this.remain}}';
  }
}
