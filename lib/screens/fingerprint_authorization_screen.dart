import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class FingerprintScreen extends StatefulWidget {
  FingerprintScreen({Key key}) : super(key: key);
  
  @override
  _FingerprintScreenState createState() => _FingerprintScreenState();
  }
  
class _FingerprintScreenState extends State<FingerprintScreen> {

    bool _isAuthorized;

    Future <void> _authorize() async {
    var localAuth = LocalAuthentication();
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;

    _isAuthorized = null;
    if(canCheckBiometrics){
      try {
        _isAuthorized = await localAuth.authenticateWithBiometrics(
          localizedReason: 'Please authenticate to Complete this process',
          useErrorDialogs: false,
          stickyAuth: true,
        );
      } on PlatformException catch (e) {
        if(e.code != "") _isAuthorized = true;
      }
    }else{
      _isAuthorized = true;
    }

    if(_isAuthorized == null || _isAuthorized == false){
      this._authorize();
    }else if(_isAuthorized){
      Navigator.pushNamed(context, '/newsscreen');
    }
  }

  void initState(){
    super.initState();
    _authorize();
  }

   Widget build(BuildContext context){
     return new Scaffold(
       backgroundColor: Colors.blue,
        body: new Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Text('Welcome!', style: TextStyle(color: Colors.white, fontSize: 30.0)),
        ),
     );
   }
}