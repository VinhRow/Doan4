import 'package:ecommerce/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce/presentation/screens/auth/providers/signup_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui.dart';
import '../../widgets/gap_widget.dart';
import '../../widgets/link_button.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const String routeName = "signup";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignupProvider>(context);

    return Scaffold(
      appBar: AppBar(
          centerTitle: true, elevation: 0, title: const Text("VHQ Store")),
      body: SafeArea(
        child: Form(
          key: provider.formKey,
          child: ListView(padding: const EdgeInsets.all(16), children: [
            Text("Tạo Tài Khoản",
                style: TextStyles.heading2, textAlign: TextAlign.center),
            const GapWidget(size: -10),
            (provider.error != "")
                ? Text(
                    provider.error,
                    style: const TextStyle(color: Colors.red),
                  )
                : const SizedBox(),
            const GapWidget(size: 5),
            PrimaryTextField(
                controller: provider.emailController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Địa chỉ Email là bắt buộc";
                  }

                  if (!EmailValidator.validate(value.trim())) {
                    return "Email không hợp lệ";
                  }

                  return null;
                },
                labelText: "Địa chỉ Email"),
            const GapWidget(),
            PrimaryTextField(
                controller: provider.passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Bạn chưa nhập mật khẩu";
                  }
                  return null;
                },
                labelText: "Mật khẩu"),
            const GapWidget(),
            PrimaryTextField(
                controller: provider.cPasswordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Xác nhận mật khẩu!";
                  }

                  if (value.trim() != provider.passwordController.text.trim()) {
                    return "Mật khẩu không trùng khớp!";
                  }

                  return null;
                },
                labelText: "Xác nhận mật khẩu"),
            const GapWidget(),
            PrimaryButton(
                onPressed: provider.createAccount,
                text: (provider.isLoading) ? "..." : "Tạo tài khoản"),
            const GapWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Bạn đã có tài khoản?", style: TextStyles.body2),
                const GapWidget(),
                LinkButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    text: "Đăng nhập")
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
