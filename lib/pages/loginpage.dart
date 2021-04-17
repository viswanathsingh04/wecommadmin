import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:wecommadmin/models/login_model.dart';
import 'package:wecommadmin/pages/home_page.dart';
import 'package:wecommadmin/services/apiservices.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isApiCallProgress = false;
  LoginModel loginModel;
  @override
  void initState() {
    super.initState();
    loginModel = new LoginModel();
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        body: ProgressHUD(
          key: globalKey,
          inAsyncCall: isApiCallProgress,
          child: Form(
            child: _loginUI(context),
          ),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Theme.of(context).primaryColor],
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'Admin Login',
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,
              Icon(Icons.web),
              'host',
              'Host URL',
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Host URL can\`t be empty';
                }
                return null;
              },
              (onSavedVal) {
                this.loginModel.host = onSavedVal;
              },
              initialValue: this.loginModel.host,
              borderFocusColor: Theme.of(context).primaryColor,
              prefixIconColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,
              Icon(Icons.lock),
              'Key',
              'Consumer Key',
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Consumer Key can\`t be empty';
                }
                return null;
              },
              (onSavedVal) {
                this.loginModel.key = onSavedVal;
              },
              initialValue: this.loginModel.key,
              borderFocusColor: Theme.of(context).primaryColor,
              prefixIconColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,
              Icon(Icons.lock),
              'Secret',
              'Consumer Secret',
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Consumer secret can\`t be empty';
                }
                return null;
              },
              (onSavedVal) {
                this.loginModel.secret = onSavedVal;
              },
              initialValue: this.loginModel.secret,
              borderFocusColor: Theme.of(context).primaryColor,
              prefixIconColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
            ),
          ),
          Center(
            child: Text(
              'OR',
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
          Center(
            child: GestureDetector(
              child: Icon(
                Icons.qr_code,
                size: 100,
              ),
              onTap: () async {
                await scanQR();
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new Center(
            child: FormHelper.submitButton(
              'Login',
              () {
                if (validateAndSave()) {
                  setState(() {
                    this.isApiCallProgress = true;
                  });
                  Apiservices.checkLogin(this.loginModel).then((response) {
                    setState(() {
                      this.isApiCallProgress = false;
                    });
                    if (response) {
                      Get.offAll(HomePage());
                    } else {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        "Wecomm Admin",
                        'Invalid Details',
                        'Ok',
                        () {
                          setState(() {
                            this.loginModel.key = '';
                            this.loginModel.secret = '';
                          });
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  });
                }
              },
              btnColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              txtColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", 'Cancel', true, ScanMode.QR);
      //} catch (e) {}
    } on PlatformException {}
    if (!mounted) return;
    setState(() {
      if (barcodeScanRes.isNotEmpty) {
        this.loginModel.key = barcodeScanRes.split("|")[0];
        this.loginModel.secret = barcodeScanRes.split("|")[1];
      }
    });
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
