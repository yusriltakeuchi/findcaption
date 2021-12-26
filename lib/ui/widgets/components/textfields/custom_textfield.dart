import 'package:findcaption/ui/constant/constant.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextInputAction? action;
  final TextInputType? type;
  final bool? secureText;
  final TextEditingController? controller;
  final bool? readOnly;
  final Function? onClick;
  final bool? useBoldText;
  final double? fontSize;
  final bool? disableMaxLine;
  final TextCapitalization? capitalization;
  final Function? onEditComplete;
  final bool? useShowPassword;
  final Function? onClickShowPassword;
  final bool? showPasswordState;
  final int? maxLength;
  final Function(String)? onChange;
  final bool? autoFocus;
  final Color? hintColor;
  final String? suffixText;
  final String? prefixText;
  final Widget? suffixTextCustom;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.action,
    required this.type,
    this.secureText = false,
    required this.controller,
    this.readOnly = false,
    this.onClick,
    this.useBoldText = true,
    this.fontSize,
    this.disableMaxLine = false,
    this.capitalization,
    this.useShowPassword = false,
    this.onClickShowPassword,
    this.showPasswordState,
    this.maxLength,
    this.onChange,
    this.autoFocus = false,
    this.hintColor,
    this.onEditComplete,
    this.suffixText,
    this.prefixText,
    this.suffixTextCustom,
  }) : super(key: key);
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextField(
            readOnly: widget.readOnly!,
            onTap: () => widget.onClick != null ? widget.onClick!() : {},
            controller: widget.controller,
            textInputAction: widget.action,
            keyboardType: widget.type,
            obscureText: widget.secureText!,
            onEditingComplete: () => widget.onEditComplete != null
                ? widget.onEditComplete!()
                : {},
            maxLines: widget.disableMaxLine! ? 5 : 1,
            maxLength: widget.maxLength ?? -1,
            onChanged: (value) =>
                widget.onChange != null ? widget.onChange!(value) : {},
            autofocus: widget.autoFocus!,
            style: widget.useBoldText!
                ? styleTitle.copyWith(
                    fontSize: setFontSize(
                      (widget.fontSize ?? 36),
                    ),
                  )
                : styleSubtitle.copyWith(
                    fontSize: setFontSize(
                      (widget.fontSize ?? 32),
                    ),
                  ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.useBoldText!
                  ? styleTitle.copyWith(
                      fontSize: setFontSize(
                        (widget.fontSize ?? 36),
                      ),
                      color: widget.hintColor ?? blackColor,
                    )
                  : styleSubtitle.copyWith(
                      fontSize: setFontSize(
                        (widget.fontSize ?? 32),
                      ),
                      color: widget.hintColor ?? blackColor,
                    ),
              border: const OutlineInputBorder(),
              counterText: "",
              suffixText: widget.suffixText,

              suffixStyle: styleSubtitle.copyWith(
                fontSize: setFontSize(
                  (widget.fontSize ?? 32),
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: setWidth(40)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: blackColor.withOpacity(0.4),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: blackColor,
                  width: 1,
                ),
              ),
              prefixText: widget.prefixText,
              prefixStyle: styleSubtitle.copyWith(
                fontSize: setFontSize(
                  (widget.fontSize ?? 32),
                ),
              ),
              suffix: widget.suffixTextCustom,
            ),
            textCapitalization: widget.capitalization != null
                ? widget.capitalization!
                : TextCapitalization.none,
          ),
        ),
        widget.useShowPassword!
            ? Material(
                type: MaterialType.transparency,
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => widget.onClickShowPassword!(),
                  borderRadius: BorderRadius.circular(40),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      widget.showPasswordState!
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: blackColor,
                    ),
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
