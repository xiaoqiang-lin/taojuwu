import 'package:flutter/material.dart';
import 'package:taojuwu/repository/zy_response.dart';
import 'package:taojuwu/router/handlers.dart';
import 'package:taojuwu/services/otp_service.dart';
import 'package:taojuwu/utils/toast_kit.dart';

import 'package:taojuwu/utils/ui_kit.dart';
import 'package:taojuwu/widgets/v_spacing.dart';
import 'package:taojuwu/widgets/zy_submit_button.dart';

class ModifyPwdPage extends StatefulWidget {
  ModifyPwdPage({Key key}) : super(key: key);

  @override
  _ModifyPwdPageState createState() => _ModifyPwdPageState();
}

class _ModifyPwdPageState extends State<ModifyPwdPage> {
  TextEditingController oldPwdInput;
  TextEditingController newPwdInput;

  @override
  void initState() {
    super.initState();
    oldPwdInput = TextEditingController();
    newPwdInput = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    oldPwdInput?.dispose();

    newPwdInput?.dispose();
  }

  String oldPwd;
  String newPwd;

  bool beforeSendData() {
    oldPwd = oldPwdInput?.text?.trim();
    newPwd = newPwdInput?.text?.trim();

    if (oldPwd?.isNotEmpty != true || newPwd?.isNotEmpty != true) {
      ToastKit.showInfo('密码不能为空哦');
      return false;
    }
    if (oldPwd == newPwd) {
      ToastKit.showInfo('新旧密码不能一样哦');
      return false;
    }
    return true;
  }

  bool canClick = true;
  void resetPwd() {
    if (beforeSendData() == false) return;
    setState(() {
      canClick = false;
    });
    OTPService.modifyPassword(
            params: {'old_password': oldPwd, 'new_password': newPwd})
        .then((ZYResponse response) {
      if (response?.valid == true) {
        ToastKit.showSuccessDIYInfo('密码修改成功');
        RouteHandler.goLoginPage(context, replace: true);
      } else {
        ToastKit.showInfo(response?.message ?? '');
      }
    }).catchError((err) {
      return err;
    }).whenComplete(() {
      setState(() {
        canClick = true;
      });
    });
  }

  bool _isOldPwdCypher = true;
  bool _isNewPwdCypher = true;
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    TextTheme textTheme = themeData.textTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('重置密码'),
        elevation: 0,
        // actions: <Widget>[
        //   FlatButton(
        //       onPressed: () {
        //         resetPwd();
        //       },
        //       child: Text('完成'))
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: UIKit.width(40)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              VSpacing(80),
              Text(
                '重置密码',
                style:
                    textTheme.headline6.copyWith(fontWeight: FontWeight.w700),
              ),
              VSpacing(30),
              TextField(
                controller: oldPwdInput,
                obscureText: _isOldPwdCypher,
                decoration: InputDecoration(
                  hintText: '请输入旧密码',
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFC7C8CB), width: .5)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFC7C8CB), width: .5)),
                  suffixIcon: IconButton(
                      icon: Icon(
                        _isOldPwdCypher
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color(0xFFCCCCCC),
                      ),
                      onPressed: () {
                        setState(() {
                          _isOldPwdCypher = !_isOldPwdCypher;
                        });
                      }),
                ),
              ),
              VSpacing(10),
              TextField(
                controller: newPwdInput,
                obscureText: _isNewPwdCypher,
                decoration: InputDecoration(
                  hintText: '请输入新密码',
                  suffixIcon: IconButton(
                      icon: Icon(
                        _isNewPwdCypher
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color(0xFFCCCCCC),
                      ),
                      onPressed: () {
                        setState(() {
                          _isNewPwdCypher = !_isNewPwdCypher;
                        });
                      }),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFC7C8CB), width: .5)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFC7C8CB), width: .5)),
                ),
              ),
              VSpacing(40),
              ZYSubmitButton(
                '重置密码',
                () {
                  resetPwd();
                },
                isActive: canClick,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
