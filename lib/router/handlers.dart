import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:taojuwu/application.dart';
import 'package:taojuwu/export/export_pages.dart';
import 'package:taojuwu/pages/cart/cart_page.dart';
import 'package:taojuwu/pages/curtain/curtain_detail_page.dart';
import 'package:taojuwu/pages/curtain/curtain_mall_page.dart';
import 'package:taojuwu/pages/curtain/subPages/pre_measure_data_page.dart';
import 'package:taojuwu/pages/customer/customer_detail_page.dart';
import 'package:taojuwu/pages/customer/customer_edit_page.dart';
import 'package:taojuwu/pages/customer/customer_manage_page.dart';
import 'package:taojuwu/pages/customer/customer_table_page.dart';
import 'package:taojuwu/pages/customer/subPages/customer_search_page.dart';

import 'package:taojuwu/pages/data_center/data_center_page.dart';
import 'package:taojuwu/pages/edit_address/edit_address_page.dart';
import 'package:taojuwu/pages/login/login_page.dart';
import 'package:taojuwu/pages/order/commit_order_page.dart';
import 'package:taojuwu/pages/order/measure_order_page.dart';
import 'package:taojuwu/pages/order/order_detail_page.dart';

import 'package:taojuwu/pages/order/order_page.dart';
import 'package:taojuwu/pages/order/subPages/order_commit_success_page.dart';
import 'package:taojuwu/pages/order/subPages/order_search_page.dart';
import 'package:taojuwu/pages/profile/profile_page.dart';
import 'package:taojuwu/pages/profile/subPages/submit_success_page.dart';
import 'package:taojuwu/pages/profile/subPages/switch_account_page.dart';
import 'package:taojuwu/pages/profile/subPages/feedback_page.dart';
import 'package:taojuwu/pages/search/search_page.dart';
import 'package:taojuwu/pages/splash/splash_page.dart';
import 'package:taojuwu/utils/common_kit.dart';
import 'routes.dart';

class RouteHandler {
  static _jumpTo(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder transitionBuilder}) {
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder,
        transition: TransitionType.cupertino);
  }

  static Handler splash = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    return SplashPage();
  });

  static Handler home = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    return HomePage();
  });
  static goHomePage(BuildContext context) {
    _jumpTo(context, Routes.home);
  }

  static Handler login = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    return LoginPage();
  });

  static goLoginPage(BuildContext context) {
    _jumpTo(context, Routes.login);
  }

  static Handler curtain = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    // return CurtainPage();
    return;
  });

  static Handler curtainDetail = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    return CurtainDetailPage(int.parse(params['id']?.first));
  });

  static goCurtainDetailPage(BuildContext context, int id) {
    _jumpTo(context, '${Routes.curtainDetail}?id=$id');
  }

  static goCurtainPage(BuildContext context) {
    _jumpTo(context, Routes.curtain);
  }

  static Handler order = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    return OrderPage();
  });

  static goOrderPage(BuildContext context) {
    _jumpTo(context, Routes.order);
  }

  static Handler orderDetail = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    int id = int.parse(params['id']?.first);
    return OrderDetailPage(id);
  });

  static goOrderDetailPage(BuildContext context, int id) {
    _jumpTo(context, '${Routes.orderDetail}?id=$id');
  }

  static Handler measureOrder = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    return MeasureOrderPage();
  });

  static goMeasureOrderPage(BuildContext context) {
    _jumpTo(context, Routes.measureOrder);
  }

  static Handler customer = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    return CustomerManagePage();
  });
  static goCustomerPage(BuildContext context) {
    _jumpTo(context, Routes.customer);
  }

  static Handler customerDetail = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    int id = int.parse(params['id']?.first);
    return CustomerDetailPage(id);
  });
  static goCustomerDetailPage(BuildContext context, int id) {
    _jumpTo(context, '${Routes.customerDetail}?id=$id');
  }

  static Handler customerEdit = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    String title =
        FluroConvertUtils.fluroCnParamsDecode(params['title']?.first);
    int id =
        params['id']?.first != 'null' ? int.parse(params['id']?.first) : null;
    return CustomerEditPage(
      title: title,
      id: id,
    );
  });
  static goCustomerEditPage(BuildContext context, {String title, int id}) {
    title =
        title != null ? FluroConvertUtils.fluroCnParamsEncode(title) : title;
    _jumpTo(context, '${Routes.customerEdit}?title=$title&id=$id');
  }

  static Handler customerTable = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    int type = int.parse(params['type']?.first);
    return CustomerTablePage(type: type);
  });
  static goCustomerTablePage(BuildContext context, int type) {
    _jumpTo(context, '${Routes.customerTable}?type=$type');
  }

  static Handler dataCenter = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    return DataCenterPage();
  });

  static goDataCenterPage(BuildContext context) {
    _jumpTo(context, Routes.dataCenter);
  }

  static Handler combo = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    // return ComboPage();
    return;
  });

  static goComboPage(BuildContext context) {
    _jumpTo(context, Routes.combo);
  }

  static Handler setting = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    // return SettingPage();
    return;
  });

  static goSettingPage(BuildContext context) {
    _jumpTo(context, Routes.setting);
  }

  static Handler profile = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    return ProfilePage();
    // return;
  });

  static goProfilePage(BuildContext context) {
    _jumpTo(context, Routes.profile);
  }

  static Handler curtainMall = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    String keyword =
        FluroConvertUtils.fluroCnParamsDecode(params['keyword']?.first);
    return CurtainMallPage(
      keyword: keyword,
    );
    // return;
  });

  static goCurtainMallPage(BuildContext context, {String keyword: ''}) {
    keyword = FluroConvertUtils.fluroCnParamsEncode(keyword);
    _jumpTo(context, '${Routes.curtainMall}?keyword=$keyword');
  }

  static Handler switchAccount = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    return SwitchAccountPage();
    // return;
  });

  static goSwitchAccountPage(BuildContext context) {
    _jumpTo(context, Routes.switchAccount);
  }

  static Handler feedback = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    return FeedbackPage();
    // return;
  });

  static goFeedbackPage(BuildContext context) {
    _jumpTo(context, Routes.feedback);
  }

  static Handler commitSuccess = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    return CommitSuccessPage();
    // return;
  });

  static goCommitSuccessPage(BuildContext context) {
    _jumpTo(context, Routes.commitSuccess);
  }

  static Handler editAddress = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    return EditAddressPage();
  });

  static goEditAddressPage(BuildContext context) {
    _jumpTo(context, Routes.editAddress);
  }

  static Handler search = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    int type = int.parse(params['type']?.first);
    return SearchPage(
      type: type,
    );
  });

  static goSearchPage(BuildContext context, int type) {
    _jumpTo(context, '${Routes.search}?type=$type');
  }

  static Handler preMeasureData = Handler(handlerFunc: (
    BuildContext context,
    Map<String, List<Object>> params,
  ) {
    return PreMeasureDataPage();
  });

  static goPreMeasureDataPage(BuildContext context) {
    _jumpTo(context, Routes.preMeasureData);
  }

  static Handler cart = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    return CartPage();
  });

  static goCartPage(BuildContext context) {
    _jumpTo(context, Routes.cart);
  }

  static Handler commitOrder = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    String args = params['params']?.first;
    args = FluroConvertUtils.fluroCnParamsDecode(args);

    Map json = Map.castFrom(jsonDecode(args));
    return CommitOrderPage(params: json);
  });

  static goCommitOrderPage(BuildContext context, {String params}) {
    params =
        params != null ? FluroConvertUtils.fluroCnParamsEncode(params) : '';

    _jumpTo(context, '${Routes.commitOrder}?params=$params');
  }

  static Handler orderCommitSuccess = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    return OrderCommitSuccessPage();
  });

  static goOrderCommitSuccessPage(BuildContext context) {
    _jumpTo(context, Routes.orderCommitSuccess);
  }

  static Handler orderSearch = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    String keyword =
        FluroConvertUtils.fluroCnParamsDecode(params['keyword']?.first);
    return OrderSearchPage(
      keyword: keyword,
    );
  });

  static goOrderSearchPage(BuildContext context, {String keyword: ''}) {
    keyword = FluroConvertUtils.fluroCnParamsEncode(keyword);
    _jumpTo(context, '${Routes.orderSearch}?keyword=$keyword');
  }

  static Handler customerSearch = Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    String keyword =
        FluroConvertUtils.fluroCnParamsDecode(params['keyword']?.first);
    return CustomerSearchPage(
      keyword: keyword,
    );
  });

  static goCustomerSearchPage(BuildContext context, {String keyword: ''}) {
    keyword = FluroConvertUtils.fluroCnParamsEncode(keyword);
    _jumpTo(context, '${Routes.customerSearch}?keyword=$keyword');
  }
}