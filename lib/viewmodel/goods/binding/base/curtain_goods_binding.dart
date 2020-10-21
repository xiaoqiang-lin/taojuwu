/*
 * @Description: 窗帘 商品 多了测装数据
 * @Author: iamsmiling
 * @Date: 2020-09-27 16:19:01
 * @LastEditTime: 2020-10-15 09:39:41
 */
import 'dart:async';

import 'package:taojuwu/application.dart';
import 'package:taojuwu/event_bus/events/select_product_event.dart';
import 'package:taojuwu/repository/order/measure_data_model.dart';
import 'package:taojuwu/repository/order/order_detail_model.dart';
import 'package:taojuwu/repository/shop/sku_attr/window_style_sku_option.dart';
import 'package:taojuwu/services/otp_service.dart';
import 'package:taojuwu/viewmodel/goods/binding/base/base_goods_viewmodel.dart';

enum CurtainType {
  WindowSunblind, //普通窗帘

  WindowGauzeType, //窗纱

  WindowRollerType //卷帘
}

abstract class CurtainGoodsBinding extends BaseGoodsViewModel {
  OrderGoodsMeasureData measureData; //测装数据
  int orderGoodsId; // 测量单选品时多有一个  ordergoodsId
  WindowStyleSkuOption styleSkuOption;

  CurtainType get curtainType {
    if (bean?.goodsSpecialType == 3) return CurtainType.WindowGauzeType;
    if (bean?.goodsSpecialType == 2) return CurtainType.WindowRollerType;
    return CurtainType.WindowSunblind;
  }

  bool get isWindowGauze => curtainType == CurtainType.WindowGauzeType;
  bool get isWindowRoller => curtainType == CurtainType.WindowRollerType;
  bool get isWindowSunblind => curtainType == CurtainType.WindowSunblind;

  bool get isMeasureOrder => orderGoodsId != null; //是否为测量单选品

  bool hasConfirmSize = false; //对于测量单而言,是否确认过测装数据

  // 从接口获取测装数据
  Future<MeasureDataModelResp> getMeasureData() {
    return OTPService.getMeasureData(context,
        params: {'order_goods_id': orderGoodsId});
  }

  StreamSubscription _streamSubscription;

  // 监听去选品事件
  @override
  void addListener(listener) {
    _streamSubscription =
        Application.eventBus.on<SelectProductEvent>().listen((event) {
      orderGoodsId = event.orderGoodsId;
    });
    super.addListener(listener);
  }

  // 释放资源
  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}