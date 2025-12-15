import 'package:taxi_client_app/app/env/app_color.dart';
import 'package:taxi_client_app/app/env/constants.dart';
import 'package:taxi_client_app/app/env/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

extension TextFormField on TextField {
  Widget formTextField({
    required String label,
    bool? secure,
    int? maxLines = 1,
    bool enable = true,
    Function? onSecure,
    Function? onAction,
    String? actionIcon,
    FocusNode? focusNode,
    TextEditingController? controller,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColor.reGreyD6D6D6, width: 1),
    );
    return Stack(
      children: [
        TextField(
          enabled: enable,
          controller: controller,
          focusNode: focusNode,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: border,
            errorBorder: border,
            enabledBorder: border,
            focusedBorder: border.copyWith(borderSide: BorderSide(color: AppColor.reGreyD6D6D6, width: 2)),
            disabledBorder: border,
            focusedErrorBorder: border,
            contentPadding: const EdgeInsets.symmetric(vertical: 17.5, horizontal: 16),
            hintText: label,
            hintStyle: AppTextStyle.regular14.copyWith(color: AppColor.reGreyA5A5A5),
            counterStyle: AppTextStyle.regular14.copyWith(color: AppColor.reGreyA5A5A5),
            alignLabelWithHint: true,
            // suffixIconConstraints:
            //     const BoxConstraints(maxWidth: 24, maxHeight: 24),
            // isCollapsed: true,
          ),
          maxLines: maxLines,
          obscureText: secure ?? false,
        ),
        Positioned(
          right: 16,
          top: 16,
          child: secure != null
              ? InkWell(
                  onTap: () => onSecure!(),
                  child: secure
                      ? SvgPicture.asset(AppIcon.eyeSlash, height: 24)
                      : SvgPicture.asset(AppIcon.eyeSlash, height: 24),
                )
              : onAction != null
              ? InkWell(onTap: () => onAction(), child: SvgPicture.asset(actionIcon.toString(), height: 24))
              : const SizedBox(),
        ),
      ],
    );
  }

  TextField searchTextField({
    required String label,
    FocusNode? focusNode,
    TextEditingController? controller,
    String? icon,
    TextStyle? appTextStyle,
    Function? onSubmitted,
    Function? onTap,
    Color? iconColor,
    double? borderRadius,
    bool enable = true,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 8),
      borderSide: BorderSide(color: AppColor.reGreyD7D7D7, width: 1),
    );
    return TextField(
      enabled: enable,
      onTap: () => onTap != null ? onTap!() : null,
      controller: controller,
      onSubmitted: (value) => onSubmitted != null ? onSubmitted(value) : null,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: border,
        errorBorder: border,
        enabledBorder: border,
        focusedBorder: border,
        disabledBorder: border,
        focusedErrorBorder: border,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        // hintText: label,
        hintText: label,
        hintStyle: appTextStyle ?? AppTextStyle.regular16.copyWith(color: AppColor.reGrey9C9C9C),
        // hintStyle: AppTextStyle.regular16.copyWith(
        //   color: AppColor.reGrey9C9C9C,
        // ),
        counterStyle: AppTextStyle.regular16.copyWith(color: AppColor.reGrey9C9C9C),
        // alignLabelWithHint: true,
        // prefixIconConstraints: BoxConstraints.tight(const Size(16, 16)),
        prefixIcon: Container(
          padding: const EdgeInsets.all(12),
          // child: SvgPicture.asset(
          //   icon ?? AppIcon.search,
          //   height: 16,
          //   color: iconColor,
          // ),
        ),
      ),
      minLines: 1,
    );
  }

  TextField dropDownTextField({
    required String label,
    bool? secure,
    int? maxLines,
    Function? onSecure,
    Function? onChange,
    FocusNode? focusNode,
    TextEditingController? controller,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColor.reGrey9C9C9C, width: 1),
    );
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: (val) => onChange != null ? onChange(val) : null,
      decoration: InputDecoration(
        border: border,
        errorBorder: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(
            // color: AppColor.reGreen216106,
            width: 2,
          ),
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomLeft: Radius.circular(0),
          ),
        ),
        disabledBorder: border,
        focusedErrorBorder: border,
        contentPadding: const EdgeInsets.all(16),
        hintText: label,
        hintStyle: AppTextStyle.medium16.copyWith(color: AppColor.reGrey9C9C9C),
        counterStyle: AppTextStyle.medium16.copyWith(color: AppColor.reGrey9C9C9C),
        // alignLabelWithHint: true,
        // suffix: secure != null
        //     ? InkWell(
        //         onTap: () => onSecure!(),
        //         child: SvgPicture.asset(
        //           AppIcon.closedEye,
        //           height: 16,
        //         ),
        //       )
        //     : null,
      ),
      maxLines: maxLines,
      obscureText: secure ?? false,
    );
  }
}

extension ContainerButtons on Container {
  Widget leftIconButton({
    double? iconWidth,
    double? iconHeight,
    double? radius,
    Color? borderColor,
    Color? color,
    double? height,
    double? verticalPadding,
    double? horizontalPadding,
    TextStyle? appTextStyle,
    Function? onTap,
    double? spaceBetweenItems,
    required String label,
    required String icon,
  }) {
    return InkWell(
      onTap: () => onTap!(),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color ?? AppColor.reWhiteFFFFFF,
          border: Border.all(color: borderColor ?? AppColor.reBlack393939),
          borderRadius: BorderRadius.circular(radius ?? 8),
        ),
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 4, horizontal: horizontalPadding ?? 4),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon, height: iconHeight, width: iconWidth),
              SizedBox(width: spaceBetweenItems ?? 16),
              Text(
                label,
                style: appTextStyle ?? AppTextStyle.medium20.copyWith(color: AppColor.reBlack393939),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rightIconButton({
    double? radius,
    Color? borderColor,
    Color? color,
    required String label,
    TextStyle? appTextStyle,
    double? verticalPadding,
    double? horizontalPadding,
    Function? onTap,
    double? spaceBetweenItems,
    required String icon,
  }) {
    return InkWell(
      onTap: () => onTap!(),
      child: Container(
        decoration: BoxDecoration(
          color: color ?? AppColor.reWhiteFFFFFF,
          border: Border.all(color: borderColor ?? AppColor.reBlack393939),
          borderRadius: BorderRadius.circular(radius ?? 8),
        ),
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 4, horizontal: horizontalPadding ?? 4),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: appTextStyle ?? AppTextStyle.medium20.copyWith(color: AppColor.reBlack393939),
              ),
              SizedBox(width: spaceBetweenItems ?? 16),
              SvgPicture.asset(icon),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconButton({
    double? radius,
    Color? borderColor,
    Color? color,
    double? verticalPadding,
    double? horizontalPadding,
    Function? onTap,
    required String icon,
  }) {
    return InkWell(
      onTap: () => onTap!(),
      child: Container(
        decoration: BoxDecoration(
          color: color ?? AppColor.reWhiteFFFFFF,
          border: Border.all(color: borderColor ?? AppColor.reBlack393939),
          borderRadius: BorderRadius.circular(radius ?? 8),
        ),
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 4, horizontal: horizontalPadding ?? 4),
        child: Center(child: SvgPicture.asset(icon)),
      ),
    );
  }

  Widget labelButton({
    double? radius,
    Color? borderColor,
    Color? color,
    double? height,
    double? verticalPadding,
    double? horizontalPadding,
    Function? onTap,
    required String label,
    TextStyle? appTextStyle,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color ?? AppColor.reWhiteFFFFFF,
        border: Border.all(color: borderColor ?? AppColor.reBlack393939),
        borderRadius: BorderRadius.circular(radius ?? 8),
      ),
      padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 4, horizontal: horizontalPadding ?? 4),
      child: Center(
        child: Text(
          label,
          style: appTextStyle ?? AppTextStyle.medium20.copyWith(color: AppColor.reBlack393939),
        ),
      ),
    );
  }
}
