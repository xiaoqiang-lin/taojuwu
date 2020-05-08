import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taojuwu/constants/constants.dart';
import 'package:taojuwu/models/zy_response.dart';
import 'package:taojuwu/providers/user_provider.dart';
import 'package:taojuwu/router/handlers.dart';
import 'package:taojuwu/services/otp_service.dart';
import 'package:taojuwu/utils/common_kit.dart';

import 'package:taojuwu/utils/ui_kit.dart';
import 'package:taojuwu/widgets/v_spacing.dart';
import 'package:taojuwu/widgets/send_sms_button.dart';
import 'package:taojuwu/widgets/zy_assetImage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  UserProvider _userProvider;
  bool _isPwdMode = true;

  @override
  void initState() {
    super.initState();
    _userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _phoneController?.dispose();
    _pwdController?.dispose();
    _smsController?.dispose();

    // _isPwdMode?.dispose();
    super.dispose();
  }

  void afterLogin(Map<String, dynamic> json) {
    _userProvider.userInfo.saveUserInfo(json);
  }

  void showPrivacy(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    // TextTheme textTheme = themeData.textTheme;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('使用协议'),
            content: Container(
                // decoration: ,
                color: themeData.primaryColor,
                margin: EdgeInsets.symmetric(
                  horizontal: UIKit.width(50),
                ),
                child: SingleChildScrollView(
                  child: Text(Constants.PRIVACY),
                )),
          );
        });
  }

  void loginBySms(BuildContext context) {
    String tel = _phoneController.text;
    String code = _smsController.text;
    if (tel.trim().isEmpty) {
      return CommonKit.toast(context, '手机号不能为空哦');
    }
    if (code.trim().isEmpty) {
      return CommonKit.toast(context, '验证码不能为空哦');
    }
    OTPService.loginBySms(context, {'mobile': tel, 'mobile_code': code})
        .then((ZYResponse response) {
      if (response.valid) {
        CommonKit.toast(context, '登录成功');
        _phoneController.text = '';
        _smsController.text = '';
        RouteHandler.goHomePage(context);
      } else {
        CommonKit.toast(context, '${response.message ?? "登录失败"}');
      }
    }).catchError((err) => err);
  }

  void loginByPwd(BuildContext context) {
    String tel = _phoneController.text;
    String pwd = _pwdController.text;
    if (tel.trim().isEmpty) {
      return CommonKit.toast(context, '手机号不能为空哦');
    }

    if (RegexUtil.isTel(tel)) {
      return CommonKit.toast(context, '请输入正确的手机号');
    }
    if (pwd.trim().isEmpty) {
      return CommonKit.toast(context, '密码不能为空哦');
    }
    OTPService.loginByPwd({'username': tel, 'password': pwd})
        .then((ZYResponse response) {
      if (response.valid) {
        CommonKit.toast(context, '登录成功');
        _phoneController.text = '';
        _pwdController.text = '';
        afterLogin(response.data);
        RouteHandler.goHomePage(context);
      } else {
        CommonKit.toast(context, '${response.message ?? "登录失败"}');
      }
    }).catchError((err) => err);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme accentTextTheme = theme.accentTextTheme;
    TextTheme textTheme = theme.textTheme;
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          VSpacing(120),
          Text(
            '欢迎回家',
            textAlign: TextAlign.center,
            style: textTheme.headline,
          ),
          VSpacing(10),
          Text(
            '登陆后可购买商品或者查看更多内容',
            style: textTheme.subtitle.copyWith(
              fontSize: UIKit.sp(28),
            ),
            textAlign: TextAlign.center,
          ),
          VSpacing(60),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: UIKit.width(70), vertical: UIKit.height(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  child: Text(
                    '手机号码登录/注册',
                    style: textTheme.subhead,
                  ),
                  onTap: () {
                    if (!_isPwdMode) {
                      setState(() {
                        _isPwdMode = !_isPwdMode;
                      });
                    }
                  },
                ),
                InkWell(
                  child: Text(
                    '密码登录',
                    style: textTheme.subhead,
                  ),
                  onTap: () {
                    if (_isPwdMode) {
                      setState(() {
                        _isPwdMode = !_isPwdMode;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          CustomPaint(
            painter: LoginPageIndicatorPainter(
                triangleW: 5.0,
                pointX: _isPwdMode ? w * 0.25 - 20.0 : w * 0.75 + 5.0,
                width: w),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: UIKit.width(50)),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      hintText: '请输入手机号',
                      icon: Container(
                        child: Text('+86'),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: theme.dividerColor, width: .5))
                            // border: Border.fromBorderSide(BorderSide(color: ))
                            ),
                      )),
                ),
                VSpacing(20),
                _isPwdMode
                    ? TextField(
                        controller: _smsController,
                        decoration: InputDecoration(
                            hintText: '请输入验证码',
                            suffixIcon: SendSmsButton(
                              callback: () async {
                                String tel = _phoneController.text;
                                if (tel.trim().isEmpty) {
                                  return CommonKit.toast(context, '手机号不能为空哦');
                                }
                                if (!RegexUtil.isMobileExact(tel)) {
                                  return CommonKit.toast(context, '请输入正确的手机号');
                                }
                                return OTPService.getSms(
                                        context, {'mobile': tel})
                                    .then((ZYResponse response) {
                                  if (response.valid) {
                                    CommonKit.toast(context, '验证码发送成功,请注意查收');
                                  } else {
                                    CommonKit.toast(context, '验证码发送失败,请稍后重试');
                                  }
                                }).catchError((err) => err);
                              },
                            )),
                      )
                    : TextField(
                        controller: _pwdController,
                        decoration: InputDecoration(
                            hintText: '请输入密码',
                            suffixIcon: FlatButton(
                                onPressed: null, child: Text('忘记密码'))),
                      ),
              ],
            ),
          ),
          VSpacing(50),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: UIKit.width(50), vertical: UIKit.height(20)),
              child: RaisedButton(
                onPressed: () {
                  CommonKit.debounce(() {
                    // if(_isPwdMode){
                    //   loginBySms(context);
                    // }else{

                    // }
                    loginByPwd(context);
                  }, 500);
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: UIKit.height(20)),
                    child: Text(
                      '登录',
                      style: accentTextTheme.button,
                    )),
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: UIKit.width(50)),
            child: Text.rich(TextSpan(
                text: '登陆即代表同意淘居屋',
                style: textTheme.caption,
                children: [
                  TextSpan(text: '  '),
                  WidgetSpan(
                      child: InkWell(
                    onTap: () {
                      showPrivacy(context);
                    },
                    child: Text('用户协议',
                        style: textTheme.caption
                            .copyWith(color: textTheme.body1.color)),
                  )),
                ])),
          ),
          VSpacing(100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('第三方账号登入  '),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: UIKit.width(20)),
                child: ZYAssetImage(
                  'wechat.png',
                  width: UIKit.width(80),
                  height: UIKit.height(80),
                ),
              ),
              ZYAssetImage('qq.png',
                  width: UIKit.width(80), height: UIKit.height(80)),
            ],
          ),
        ],
      ),
    );
  }
}

class LoginPageIndicatorPainter extends CustomPainter {
  final double triangleW;
  final double pointX;
  final double width;

  LoginPageIndicatorPainter({this.triangleW, this.pointX, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Color(0xff666666)
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(0, 0), Offset(pointX - triangleW, 0), paint);

    canvas.drawLine(
        Offset(pointX - triangleW, 0), Offset(pointX, -triangleW), paint);
    canvas.drawLine(
        Offset(pointX, -triangleW), Offset(pointX + 2 * triangleW, 0), paint);

    canvas.drawLine(Offset(width, 0), Offset(pointX + 2 * triangleW, 0), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}