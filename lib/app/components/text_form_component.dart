import 'package:flutter/material.dart';

import '../../utils/constants.dart';


class TextFormComponent extends StatefulWidget {
  final String? label;
  final String? hintText;
  final dynamic prefixIcon;
  final IconData? suffixIcon;
  final TextInputType textInputType;
  final TextEditingController controller;
  final Color enabledBorderColor;
  final Widget? prefix;
  final bool enabled;
  final int? maxLine;
  final bool? hide;

  const TextFormComponent({super.key, 
    this.label,
    this.prefixIcon,
    this.hintText,
    this.textInputType = TextInputType.name,
    required this.controller,
    this.suffixIcon,
    this.enabledBorderColor = Colors.black38,
    this.prefix,
    this.enabled = true,
    this.maxLine=1,
    this.hide=false,
  }); // Utilisez la clé dans le super-construteur

  @override
  State<TextFormComponent> createState() => _TextFormComponentState();
}

class _TextFormComponentState extends State<TextFormComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(

      width: double.infinity,
      child: Column(
        children: [
          h(15),
          Container(
            height: 60,
            child: TextFormField(
              maxLines: widget.maxLine,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
              obscureText: widget.hide!,
              enabled: widget.enabled,
              controller: widget.controller,
              keyboardType: widget.textInputType,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                suffixIcon: (widget.suffixIcon != null)
                    ? IconButton(
                        // Utilisez un IconButton pour gérer les pressions
                        icon: Icon(
                          widget.suffixIcon,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      )
                    : null,
                prefix: (widget.prefix != null) ? widget.prefix : null,
                prefixIcon: (widget.prefixIcon != null)
                    ?  Icon(
                            widget.prefixIcon,
                            color: Colors.black,
                          )

                    : null,
                hintText: (widget.hintText == null) ? null : widget.hintText,
                hintStyle: const TextStyle(color: Colors.black,fontFamily: 'PRegular', fontSize: 13),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.enabledBorderColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.enabledBorderColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
