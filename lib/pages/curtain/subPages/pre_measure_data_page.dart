import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taojuwu/models/shop/sku_attr/room_attr.dart';
import 'package:taojuwu/models/shop/sku_attr/window_pattern_attr.dart';

import 'package:taojuwu/models/zy_response.dart';
import 'package:taojuwu/pages/curtain/widgets/attr_options_bar.dart';
import 'package:taojuwu/pages/curtain/widgets/sku_attr_picker.dart';
import 'package:taojuwu/pages/curtain/widgets/window_pattern_view.dart';
import 'package:taojuwu/providers/goods_provider.dart';
import 'package:taojuwu/services/otp_service.dart';
import 'package:taojuwu/utils/common_kit.dart';
import 'package:taojuwu/utils/ui_kit.dart';
import 'package:taojuwu/widgets/zy_assetImage.dart';
import 'package:taojuwu/widgets/zy_outline_button.dart';
import 'package:taojuwu/widgets/zy_raised_button.dart';
import 'package:taojuwu/widgets/zy_submit_button.dart';

class PreMeasureDataPage extends StatefulWidget {
  PreMeasureDataPage({Key key}) : super(key: key);

  @override
  _PreMeasureDataPageState createState() => _PreMeasureDataPageState();
}

class _PreMeasureDataPageState extends State<PreMeasureDataPage> {
  TextEditingController widthInputController;
  TextEditingController heightInputController;
  TextEditingController dyInputController;

  Map<String, dynamic> data = {};
  Map<String, dynamic> params = {
    'dataId': '',
    'width': '',
    'height': '',
    'install_room': '',
    'goods_id': '',
    'vertical_ground_height': '',
    'data': {},
    'goods_id': ''
  };

  void setParams(GoodsProvider provider) {
    params['dataId'] = '${provider?.windowPatternId ?? ''}';

    params['width'] = '${provider?.widthM ?? ''}';
    params['height'] = '${provider?.heightM ?? ''}';
    params['vertical_ground_height'] = '${provider?.dy ?? ''}';
    params['goods_id'] = '${provider?.goodsId ?? ''}';
    params['install_room'] = '${provider?.curRoomAttrBean?.id ?? ''}';
    data['${provider?.windowPatternId ?? ''}'] = {
      'name': '${provider?.windowPatternStr ?? ''}',
      'selected': {
        '安装选项': ['${provider?.curInstallMode ?? ''}'],
        '打开方式': provider?.openModeParams
      }
    };

    params['data'] = jsonEncode(data);
  }

  String normalizeData(String n) {
    if (n == null || n?.isEmpty == true) return '';
    // return '${double/}';
    return '';
  }

  @override
  void initState() {
    super.initState();
    // goodsProvider = widget.goodsProvider;
    GoodsProvider goodsProvider =
        Provider?.of<GoodsProvider>(context, listen: false);
    widthInputController =
        TextEditingController(text: goodsProvider?.widthCMStr);
    heightInputController =
        TextEditingController(text: goodsProvider?.heightCMStr);
    dyInputController = TextEditingController(text: goodsProvider?.dyCMStr);
  }

  @override
  void dispose() {
    super.dispose();
    widthInputController?.dispose();
    heightInputController?.dispose();
    dyInputController?.dispose();
  }

  void checkWindowPattern(BuildContext context) async {
    await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return _WindowStyleCheckWrapper();
        });
  }

  Widget buildInstallOptionPicker() {
    ThemeData themeData = Theme.of(context);
    TextTheme textTheme = themeData.textTheme;

    return Consumer<GoodsProvider>(
      builder: (BuildContext context, GoodsProvider provider, _) {
        return Container(
          child: Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(right: UIKit.width(30)),
                  child: Text(
                    '安装选项',
                    style: textTheme.caption,
                  )),
              Expanded(
                  child: Row(
                children: List.generate(provider?.installOptions?.length ?? 0,
                    (int i) {
                  Map<String, dynamic> item = provider?.installOptions[i];
                  return Container(
                      margin: EdgeInsets.symmetric(horizontal: UIKit.width(10)),
                      child: item['is_checked'] == true
                          ? ZYRaisedButton(
                              item['text'],
                              () {
                                provider?.checkOpenMode(i);
                              },
                              horizontalPadding: UIKit.width(15),
                            )
                          : ZYOutlineButton(
                              item['text'],
                              () {
                                provider?.checkInstallMode(i);
                              },
                              horizontalPadding: UIKit.width(15),
                            ));
                }),
              ))
            ],
          ),
        );
      },
    );
  }

  Widget buildOpenOptionPicker() {
    ThemeData themeData = Theme.of(context);
    TextTheme textTheme = themeData.textTheme;

    return Consumer<GoodsProvider>(
      builder: (BuildContext context, GoodsProvider provider, _) {
        return Container(
          child: Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(right: UIKit.width(30)),
                  child: Text(
                    '打开方式',
                    style: textTheme.caption,
                  )),
              Expanded(
                  child: Row(
                children:
                    List.generate(provider?.openOptions?.length ?? 0, (int i) {
                  Map<String, dynamic> item = provider?.openOptions[i];
                  return Container(
                      margin: EdgeInsets.symmetric(horizontal: UIKit.width(10)),
                      child: item['is_checked'] == true
                          ? ZYRaisedButton(
                              item['text'],
                              () {
                                provider?.checkOpenMode(i);
                              },
                              horizontalPadding: UIKit.width(15),
                            )
                          : ZYOutlineButton(
                              item['text'],
                              () {
                                provider?.checkOpenMode(i);
                              },
                              horizontalPadding: UIKit.width(15),
                            ));
                }),
              ))
            ],
          ),
        );
      },
    );
  }

  Widget buildOpenSubOptionPicker() {
    ThemeData themeData = Theme.of(context);
    TextTheme textTheme = themeData.textTheme;

    return Consumer<GoodsProvider>(
      builder: (BuildContext context, GoodsProvider provider, _) {
        return Column(
          children:
              List.generate(provider?.openSubOptions?.length ?? 0, (int i) {
            Map<String, dynamic> tmp = provider?.openSubOptions[i];
            return Row(
                children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: UIKit.width(30)),
                          child: Text(
                            tmp['name'],
                            style: textTheme.caption,
                          )),
                    ] +
                    List.generate(tmp['options']?.length, (int j) {
                      Map<String, dynamic> item = tmp['options'][j];
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: UIKit.width(10)),
                        child: item['is_checked']
                            ? ZYRaisedButton(
                                item['text'],
                                () {
                                  provider?.checkOpenSubOption(i, j);
                                },
                                horizontalPadding: UIKit.width(20),
                              )
                            : ZYOutlineButton(
                                item['text'],
                                () {
                                  provider?.checkOpenSubOption(i, j);
                                },
                                horizontalPadding: UIKit.width(20),
                              ),
                      );
                    }));
          }),
        );
      },
    );
  }

  void checkRoomAttr(BuildContext context) async {
    await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return _RoomAttrCheckWrapper();
        });
  }

  bool beforeSendData(GoodsProvider provider) {
    String w = widthInputController?.text;
    String h = heightInputController?.text;
    if (w?.trim()?.isEmpty == true) {
      CommonKit?.showInfo('请填写宽度');
      return false;
    }
    if (double.parse(w) == 0) {
      CommonKit?.showInfo('宽度不能为0哦');
      return false;
    }
    if (h?.trim()?.isEmpty == true) {
      CommonKit?.showInfo('请填写高度');
      return false;
    }
    if (double.parse(h) == 0) {
      CommonKit?.showInfo('高度不能为0哦');
      return false;
    }
    if (double.parse(h) > 350) {
      CommonKit.showInfo('暂不支持3.5m以上定制');
      h = '350';
      return false;
    }

    provider?.width = w;
    provider?.height = h;
    provider?.dy = dyInputController?.text;
    setParams(provider);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    TextTheme textTheme = themeData.textTheme;
    return Consumer<GoodsProvider>(
      builder: (BuildContext context, GoodsProvider provider, _) {
        setParams(provider);
        print('${provider?.windowPatternStr}/${provider?.curInstallMode}');
        print(WindowPatternAttr.pictureMap[
            '${provider?.windowPatternStr}/${provider?.curInstallMode}']);
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('测装数据'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: UIKit.width(20), vertical: UIKit.height(20)),
              child: Column(
                children: <Widget>[
                  Container(
                    child: ZYAssetImage(
                      WindowPatternAttr.pictureMap[
                          '${provider?.windowPatternStr}/${provider?.curInstallMode}'],
                      width: UIKit.width(480),
                      height: UIKit.height(480),
                    ),
                  ),
                  Divider(),
                  AttrOptionsBar(
                    title: '空间',
                    trailingText: provider?.curRoomAttrBean?.name ?? '',
                    callback: () {
                      checkRoomAttr(context);
                    },
                  ),
                  AttrOptionsBar(
                    title: '窗型',
                    trailingText: provider?.windowPatternStr ?? '',
                    callback: () {
                      checkWindowPattern(context);
                    },
                  ),
                  // _buildInstallOptionBar(context),
                  // _modeBar(
                  //   context,
                  //   '安装方式:',
                  //   WindowPatternAttr.installModes,
                  // ),
                  Divider(),
                  buildInstallOptionPicker(),
                  Divider(),
                  buildOpenOptionPicker(),

                  Divider(),
                  buildOpenSubOptionPicker(),
                  // _modeBar(
                  //   context,
                  //   '打开方式:',
                  //   WindowPatternAttr.openModes,
                  // ),
                  // _buildOpenOptionBar(),
                  Divider(),
                  Column(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: UIKit.height(20)),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: UIKit.width(30)),
                              child: Text(
                                '宽   (cm):',
                                style: textTheme.caption,
                              ),
                            ),
                            Container(
                              child: TextField(
                                maxLines: 1,
                                controller: widthInputController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 2.5),
                                ),
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: UIKit.width(20)),
                              width: UIKit.width(160),
                              height: UIKit.height(50),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: UIKit.height(20)),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: UIKit.width(30)),
                              child: Text(
                                '高   (cm):',
                                style: textTheme.caption,
                              ),
                            ),
                            Container(
                              child: TextField(
                                maxLines: 1,
                                controller: heightInputController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 2.5),
                                ),
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: UIKit.width(20)),
                              width: UIKit.width(160),
                              height: UIKit.height(50),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: UIKit.height(20)),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: UIKit.width(30)),
                          child: Text(
                            '离地距离:',
                            style: textTheme.caption,
                          ),
                        ),
                        Container(
                          child: TextField(
                            maxLines: 1,
                            controller: dyInputController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '单位(cm)',
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 2.5),
                            ),
                          ),
                          margin:
                              EdgeInsets.symmetric(horizontal: UIKit.width(20)),
                          width: UIKit.width(160),
                          height: UIKit.height(50),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: ZYSubmitButton('确认', () {
            print(params);
            if (!beforeSendData(provider)) return;
            OTPService.saveMeasure(context, params: params)
                .then((ZYResponse response) {
              if (response?.valid == true) {
                provider?.measureId = response?.data;
                Navigator.of(context).pop();
              }
            }).catchError((err) => err);
          }),
        );
      },
    );
  }
}

class _RoomAttrCheckWrapper extends StatefulWidget {
  _RoomAttrCheckWrapper({
    Key key,
  }) : super(key: key);

  @override
  __RoomAttrCheckWrapperState createState() => __RoomAttrCheckWrapperState();
}

class __RoomAttrCheckWrapperState extends State<_RoomAttrCheckWrapper> {
  RoomAttr roomAttr;
  List<RoomAttrBean> beans;

  RoomAttrBean tmp;
  int tmpId;
  @override
  void initState() {
    super.initState();
    GoodsProvider provider = Provider.of<GoodsProvider>(context, listen: false);
    roomAttr = provider?.roomAttr;
    tmpId = provider?.curRoomAttrBean?.id;
  }

  @override
  Widget build(BuildContext context) {
    List<RoomAttrBean> beans = roomAttr?.data;
    ThemeData themeData = Theme.of(context);
    return Consumer<GoodsProvider>(
      builder: (BuildContext context, GoodsProvider provider, _) {
        return SkuAttrPicker(
          title: '空间选择',
          child: SingleChildScrollView(
            child: Wrap(
              children: List.generate(beans?.length ?? 0, (int i) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: UIKit.width(10)),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        tmp = beans[i];
                        tmpId = beans[i].id;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: tmpId == beans[i].id
                              ? themeData.accentColor
                              : const Color(0xFFEDEDED)),
                      margin: EdgeInsets.symmetric(
                          horizontal: UIKit.width(10),
                          vertical: UIKit.height(10)),
                      padding: EdgeInsets.symmetric(
                          horizontal: UIKit.width(15),
                          vertical: UIKit.height(10)),
                      child: Text(
                        beans[i].name,
                        style: tmpId == beans[i].id
                            ? themeData.accentTextTheme.button
                            : TextStyle(),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          callback: () {
            provider?.curRoomAttrBean = tmp;
            // print(provider?.curRoomAttrBean?.name);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

class _WindowStyleCheckWrapper extends StatelessWidget {
  const _WindowStyleCheckWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GoodsProvider>(
      builder: (BuildContext context, GoodsProvider provider, _) {
        return SkuAttrPicker(
          title: '窗型选择',
          child: SingleChildScrollView(
              child: Container(
            margin: EdgeInsets.symmetric(horizontal: UIKit.width(20)),
            child: Column(
              children: [
                WindowPatternView(
                  text: WindowPatternAttr.patterns['title'],
                  imgs: WindowPatternAttr.patterns['options'],
                  curOpotion: provider?.curWindowPattern ?? 0,
                  provider: provider,
                ),
                WindowPatternView(
                  text: WindowPatternAttr.styles['title'],
                  imgs: WindowPatternAttr.styles['options'],
                  curOpotion: provider?.curWindowStyle ?? 0,
                  provider: provider,
                ),
                WindowPatternView(
                  text: WindowPatternAttr.types['title'],
                  imgs: WindowPatternAttr.types['options'],
                  curOpotion: provider?.curWindowType ?? 0,
                  provider: provider,
                )
              ],
            ),
          )),
          callback: () {
            provider?.saveWindowAttrs();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
