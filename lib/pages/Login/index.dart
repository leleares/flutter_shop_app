import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/api/user.dart';
import 'package:flutter_shop_app/utils/ToastUtil.dart';
import 'package:flutter_shop_app/viewmodels/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  void _handleLoginClick() {
    // 触发检验表单动作
    if (_formKey.currentState!.validate()) {
      if (_isChecked) {
        // 执行登录逻辑
        _login();
      } else {
        // 提示未勾选协议
        Toastutil.showToast(context, "请勾选协议");
      }
    }
  }

  Future<void> _login() async {
    try {
      String account = _phoneController.text;
      String password = _passwordController.text;
      final res = await loginRequest(
        LoginRequest(account: account, password: password),
      );

      print("res=> $res");
      Toastutil.showToast(context, "登录成功");
      Navigator.pop(context);
    } catch (e) {
      Toastutil.showToast(context, (e as DioException).message ?? "");
    }
  }

  // 用户账号Widget
  Widget _buildPhoneTextField() {
    return TextFormField(
      controller: _phoneController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '账号不可以为空';
        }
        if (!RegExp(r"^1[3-9]\d{9}$").hasMatch(value)) {
          return '手机号格式不正确';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入账号",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  // 用户密码Widget
  Widget _buildCodeTextField() {
    return TextFormField(
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '密码不可以为空';
        }
        if (!RegExp(r"^[a-zA-Z0-9_]{6,12}$").hasMatch(value)) {
          return '请输入6——16位的字母数字或下划线';
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入密码",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  // 登录按钮Widget
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _handleLoginClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text("登录", style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  bool _isChecked = false;
  // 勾选Widget
  Widget _buildCheckbox() {
    return Row(
      children: [
        // 设置勾选为圆角
        Checkbox(
          value: _isChecked,
          activeColor: Colors.black,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value ?? false;
            });
          },
          // 设置形状
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 圆角大小
          ),
          // 可选：设置边框
          side: BorderSide(color: Colors.grey, width: 2.0),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "查看并同意"),
              TextSpan(
                text: "《隐私条款》",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(text: "和"),
              TextSpan(
                text: "《用户协议》",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 头部Widget
  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "账号密码登录",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(30),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 30),
              _buildPhoneTextField(),
              SizedBox(height: 20),
              _buildCodeTextField(),
              SizedBox(height: 20),
              _buildCheckbox(),
              SizedBox(height: 20),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
