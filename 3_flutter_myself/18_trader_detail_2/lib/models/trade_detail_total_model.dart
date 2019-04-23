import 'trade_detail_model.dart';

class TradeDetailTotalModel {
  int code;
  String message;
  TradeDetailListModel data;

  TradeDetailTotalModel({this.code, this.message, this.data});

  TradeDetailTotalModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = TradeDetailListModel.fromJson(json['data']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class TradeDetailListModel {
  String endTime;
  String startTime;
  bool hasMonthlyBill;
  List<TradeDetailModel> list;
  List<TradeCategoryModel> tradeCategory;
  PageModel page;

  TradeDetailListModel({
    this.startTime,
    this.endTime,
    this.hasMonthlyBill,
    this.list,
    this.tradeCategory,
    this.page,
  });

  TradeDetailListModel.fromJson(Map<String, dynamic> json) {
    endTime = json['endTime'];
    startTime = json['startTime'];
    hasMonthlyBill = json['hasMonthlyBill'];

    if (json['list'] != null) {
      list = new List<TradeDetailModel>();
      json['list'].forEach((v) {
        list.add(new TradeDetailModel.fromJson(v));
      });
    }

    if (json['tradeCategory'] != null) {
      tradeCategory = new List<TradeCategoryModel>();
      json['tradeCategory'].forEach((v) {
        tradeCategory.add(new TradeCategoryModel.fromJson(v));
      });
    }

    if (json['page'] != null) {
      page = PageModel.fromJson(json['page']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['endTime'] = this.endTime;
    data['startTime'] = this.startTime;
    if (this.list != null) {
      data['data'] = this.list.map((v) => v.toJson()).toList();
    }
    if (this.tradeCategory != null) {
      data['tradeCategory'] =
          this.tradeCategory.map((v) => v.toJson()).toList();
    }
    if (this.page != null) {
      data['page'] = this.page.toJson();
    }
    return data;
  }
}

/// page数据
class PageModel {
  int pageNum;
  int pages;
  int totalRecords;

  PageModel({
    this.pageNum,
    this.pages,
    this.totalRecords,
  });

  PageModel.fromJson(Map<String, dynamic> json) {
    pageNum = json['pageNum'];
    pages = json['pages'];
    totalRecords = json['totalRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNum'] = this.pageNum;
    data['pages'] = this.pages;
    data['totalRecords'] = this.totalRecords;
    return data;
  }
}

/// 分类数据 便于进行数据查询
class TradeCategoryModel {
  int tradeType;
  String tradeTypeDesc;

  TradeCategoryModel.fromJson(Map<String, dynamic> json) {
    tradeType = json['tradeType'];
    tradeTypeDesc = json['tradeTypeDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tradeTypeDesc'] = this.tradeTypeDesc;
    data['tradeType'] = this.tradeType;
    return data;
  }
}
