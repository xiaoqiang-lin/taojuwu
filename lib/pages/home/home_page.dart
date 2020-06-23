import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
// import 'package:r_upgrade/r_upgrade.dart';
import 'package:taojuwu/application.dart';
import 'package:taojuwu/providers/user_provider.dart';
import 'package:taojuwu/router/handlers.dart';
import 'package:taojuwu/utils/common_kit.dart';
import 'package:taojuwu/utils/ui_kit.dart';
import 'package:taojuwu/widgets/v_spacing.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List items;
  Timer timer;
  StreamController _streamController;
  @override
  void initState() {
    super.initState();
    checkAppVersion();
    // Application.hasNewAppVersion().then((bool flag) {
    //   if (flag) {
    //     checkAppVersion();
    //   }
    // });

    // _getInstallMarket();
    items = [
      {
        'title': '套餐搭配',
        'subtitle': '一起买，价格更优惠',
        'icon': 'combo@2x.png',
        'callback': () {
          CommonKit.showInfo('暂未开放');
        },
        'color': const Color(0xFFC9BCA9),
      },
      {
        'title': '预约测量',
        'subtitle': '上门测量，更准确',
        'icon': 'measure@2x.png',
        'callback': () {
          RouteHandler.goMeasureOrderPage(context);
        },
        'color': const Color(0xFFC9BCA9),
      },
      {
        'title': '订单管理',
        'subtitle': '订单进度一目了然',
        'icon': 'order@2x.png',
        'callback': () {
          RouteHandler.goOrderPage(
            context,
          );
        },
        'color': const Color(0xFF192538)
      },
      {
        'title': '客户管理',
        'subtitle': '把握客户，把握机会',
        'icon': 'customer_manage@2x.png',
        'callback': () {
          RouteHandler.goCustomerPage(
            context,
          );
        },
        'color': const Color(0xffDDE0E1)
      },
      {
        'title': '数据中心',
        'subtitle': '销售统计，清晰明了',
        'icon': 'data@2x.png',
        'callback': () {
          CommonKit.showInfo('暂未开放');
          // RouteHandler.goDataCenterPage(context);
        },
        'color': const Color(0xff0D0B14)
      },
      {
        'title': '设置',
        'subtitle': '问题反馈，软件帮助',
        'icon': 'setting@2x.png',
        'callback': () {
          RouteHandler.goProfilePage(context);
        },
        'color': const Color(0xffE4B1AB)
      },
    ];

    _streamController = StreamController();
    timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _streamController.add(DateTime.now());
    });
  }

  checkAppVersion() {
    AppUpgrade.appUpgrade(
      context,
      _checkAppInfo(),
      cancelText: '以后再说',
      okText: '马上升级',
      cancelTextStyle: TextStyle(color: const Color(0xFF2196f3)),
      okTextStyle: TextStyle(color: const Color(0xFF2196f3)),
      okBackgroundColors: [Colors.white, Colors.white],
      progressBarColor: Colors.blue,
      iosAppId: 'id88888888',
      appMarketInfo: AppMarket.oppo,
      borderRadius: 16.0,
      onCancel: () {
        // print('onCancel');
      },
      onOk: () {
        // print('onOk');
      },
      downloadProgress: (count, total) {
        // print('count:$count,total:$total');
      },
      downloadStatusChange: (DownloadStatus status, {dynamic error}) {
        print('status:$status,error:$error');
        if (status == DownloadStatus.done) {
          Application.installApk();
        }
      },
    );
  }

  Future<AppUpgradeInfo> _checkAppInfo() async {
    //这里一般访问网络接口，将返回的数据解析成如下格式
    return Future.delayed(Duration(seconds: 1), () {
      return AppUpgradeInfo(
        title: '新版本V1.1.1',
        contents: [
          '1、支持立体声蓝牙耳机，同时改善配对性能',
          '2、提供屏幕虚拟键盘',
          '3、更简洁更流畅，使用起来更快',
          '4、修复一些软件在使用时自动退出bug',
          '5、新增加了分类查看功能'
        ],
        apkDownloadUrl:
            'http://buyi.taoju5.com//%E6%B7%98%E5%B1%85%E5%B1%8B.apk',
        force: false,
      );
    });
  }

  // _getInstallMarket() async {
  //   List<String> marketList = await FlutterUpgrade.getInstallMarket();
  //   marketList.forEach((f) {
  //     _installMarkets += '$f,';
  //   });
  // }

  @override
  void dispose() {
    _streamController?.close();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    ThemeData themeData = Theme.of(context);
    TextTheme accentTextTheme = themeData.accentTextTheme;
    TextTheme textTheme = themeData.textTheme;

    return Container(
      color: themeData.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: UIKit.width(20)),
            margin: EdgeInsets.only(bottom: UIKit.height(50)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Consumer<UserProvider>(
                  builder: (BuildContext context, UserProvider provider, _) {
                    return StreamBuilder(
                        initialData: DateTime.now(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text.rich(
                              TextSpan(
                                  text:
                                      '${UIKit.getGreetWord(snapshot.data) ?? ""},${provider?.userInfo?.nickName ?? ""}',
                                  style: textTheme.title,
                                  children: [
                                    TextSpan(text: '\n'),
                                    TextSpan(
                                        text: provider?.userInfo?.shopName,
                                        style: textTheme.subtitle)
                                  ]),
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                              textWidthBasis: TextWidthBasis.longestLine,
                            ),
                          );
                        });
                  },
                ),
                VSpacing(20),
                InkWell(
                  onTap: () {
                    RouteHandler.goCurtainMallPage(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: UIKit.height(500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          '窗帘定制',
                          style: accentTextTheme.title,
                        ),
                        Text(
                          'curtain',
                          style: accentTextTheme.subtitle,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(UIKit.getAssetsImagePath(
                                'home_top_cover_origin.png')))),
                  ),
                ),
                VSpacing(20),
                GridView.builder(
                  shrinkWrap: true,
                  // controller: controller,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.2),
                  itemBuilder: (BuildContext context, int i) {
                    var item = items[i];
                    return InkWell(
                        onTap: item['callback'],
                        child: Card(
                            child: Container(
                          alignment: Alignment.center,
                          color: Color(0xFFF3F4F5),
                          padding:
                              EdgeInsets.symmetric(horizontal: UIKit.width(20)),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: UIKit.width(20)),
                                child: Image.asset(
                                  UIKit.getAssetsImagePath(item['icon']),
                                  width: UIKit.width(60),
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      item['title'],
                                      style: textTheme.title.copyWith(
                                          fontSize: UIKit.sp(28),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    VSpacing(10),
                                    Text(
                                      item['subtitle'],
                                      style: textTheme.subtitle
                                          .copyWith(fontSize: UIKit.sp(22)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )));
                  },
                  itemCount: items.length,
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
