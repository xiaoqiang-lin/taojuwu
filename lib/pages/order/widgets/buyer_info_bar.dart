import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taojuwu/icon/ZYIcon.dart';
import 'package:taojuwu/providers/client_provider.dart';
import 'package:taojuwu/router/handlers.dart';
import 'package:taojuwu/utils/ui_kit.dart';

class BuyerInfoBar extends StatelessWidget {
  const BuyerInfoBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    TextTheme accentTextTheme = themeData.accentTextTheme;
    return InkWell(
      onTap: () {
        RouteHandler.goEditAddressPage(context);
      },
      child:
          Consumer(builder: (BuildContext context, ClientProvider provider, _) {
        
        return Container(
          color: themeData.primaryColor,
          padding: EdgeInsets.symmetric(
              horizontal: UIKit.width(20), vertical: UIKit.height(20)),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: UIKit.sp(60),
                child: Text(
                  '收',
                  style: accentTextTheme.title.copyWith(fontSize: UIKit.sp(36)),
                ),
                backgroundColor: themeData.accentColor,
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: UIKit.width(20)),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('收货人:${provider?.name??''}'),
                    Text('联系方式:${provider?.tel??''}'),
                    Text('收货地址:${provider?.address??''}${provider?.detailAddress??''}'),
                  ],
                ),
              )),
              ZYIcon.next
            ],
          ),
        );
      }),
    );
  }
}