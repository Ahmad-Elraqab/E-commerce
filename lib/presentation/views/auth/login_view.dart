import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:taxi_client_app/app/env/app_color.dart';
import 'package:taxi_client_app/app/env/text_style.dart';
import 'package:taxi_client_app/app/router/router.gr.dart';

@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.reWhiteFFFFFF,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  _buildHeader(),
                  const SizedBox(height: 40),
                  _buildEmailField(),
                  const SizedBox(height: 20),
                  _buildPasswordField(),
                  const SizedBox(height: 16),
                  _buildRememberMeAndForgot(),
                  const SizedBox(height: 32),
                  _buildLoginButton(),
                  const SizedBox(height: 24),
                  _buildDivider(),
                  const SizedBox(height: 24),
                  _buildSocialLogin(),
                  const SizedBox(height: 32),
                  _buildSignUpLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(color: AppColor.reOrangeFF9500, borderRadius: BorderRadius.circular(16)),
          child: const Icon(Icons.shopping_bag, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 24),
        Text('Welcome Back! 👋', style: AppTextStyle.bold32.copyWith(color: AppColor.reBlack252525)),
        const SizedBox(height: 8),
        Text(
          'Sign in to continue shopping',
          style: AppTextStyle.regular16.copyWith(color: AppColor.reGrey666666),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email', style: AppTextStyle.semiBold14.copyWith(color: AppColor.reBlack393939)),
        const SizedBox(height: 8),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Enter your email',
            hintStyle: AppTextStyle.regular14.copyWith(color: AppColor.reGrey9C9C9C),
            prefixIcon: Icon(Icons.email_outlined, color: AppColor.reGrey666666),
            filled: true,
            fillColor: AppColor.reGreyF9F9F9,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.reOrangeFF9500, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.reRedFF3B30, width: 2),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Password', style: AppTextStyle.semiBold14.copyWith(color: AppColor.reBlack393939)),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            hintStyle: AppTextStyle.regular14.copyWith(color: AppColor.reGrey9C9C9C),
            prefixIcon: Icon(Icons.lock_outline, color: AppColor.reGrey666666),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColor.reGrey666666,
              ),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
            filled: true,
            fillColor: AppColor.reGreyF9F9F9,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.reOrangeFF9500, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.reRedFF3B30, width: 2),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildRememberMeAndForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => setState(() => _rememberMe = !_rememberMe),
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: _rememberMe ? AppColor.reOrangeFF9500 : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: _rememberMe ? AppColor.reOrangeFF9500 : AppColor.reGreyD7D7D7,
                    width: 2,
                  ),
                ),
                child: _rememberMe ? const Icon(Icons.check, color: Colors.white, size: 14) : null,
              ),
            ),
            const SizedBox(width: 8),
            Text('Remember me', style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack4D4D4D)),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Forgot Password?',
            style: AppTextStyle.medium14.copyWith(color: AppColor.reOrangeFF9500),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.reOrangeFF9500,
          disabledBackgroundColor: AppColor.reOrangeFF9500.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text('Sign In', style: AppTextStyle.semiBold16.copyWith(color: Colors.white)),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColor.reGreyD7D7D7)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or continue with',
            style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666),
          ),
        ),
        Expanded(child: Divider(color: AppColor.reGreyD7D7D7)),
      ],
    );
  }

  Widget _buildSocialLogin() {
    return Row(
      children: [
        Expanded(child: _buildSocialButton('Google', Icons.g_mobiledata, const Color(0xFFDB4437), () {})),
        const SizedBox(width: 16),
        Expanded(child: _buildSocialButton('Apple', Icons.apple, AppColor.reBlack252525, () {})),
      ],
    );
  }

  Widget _buildSocialButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColor.reGreyD7D7D7),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 8),
          Text(label, style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack393939)),
        ],
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666),
          ),
          GestureDetector(
            onTap: () => context.router.push(const RegisterView()),
            child: Text('Sign Up', style: AppTextStyle.semiBold14.copyWith(color: AppColor.reOrangeFF9500)),
          ),
        ],
      ),
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate login delay
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      // Navigate to main view
      if (mounted) {
        context.router.pushAndPopUntil(const MainView(), predicate: (route) => false);
      }
    }
  }
}
