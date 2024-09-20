import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final String hintText;
  final String hintText2;

  final String? subtitle;
  final TextEditingController firstFieldController;
  final TextEditingController? secondFieldController;
  final IconData? secicon;
  final int maxLength;

  final Color firstButtonColor;
  final IconData firstButtonIcon;
  final Color? firstButtonIconColor;
  final Function(String) firstButtonAction;

  final Color secondButtonColor;
  final IconData secondButtonIcon;
  final Color? secondButtonIconColor;
  final VoidCallback secondButtonAction;
  final Color titleBackgroundColor;

  const CustomDialog({
    super.key,
    required this.title,
    this.subtitle,
    required this.firstFieldController,
    this.secondFieldController,
    this.secicon,
    required this.maxLength,
    required this.firstButtonColor,
    required this.firstButtonIcon,
    this.firstButtonIconColor,
    required this.firstButtonAction,
    required this.secondButtonColor,
    required this.secondButtonIcon,
    this.secondButtonIconColor,
    required this.secondButtonAction,
    required this.titleBackgroundColor,
    required this.hintText,
    required this.hintText2,
  });

  @override
  CustomDialogState createState() => CustomDialogState();
}

class CustomDialogState extends State<CustomDialog> {
  String? firstFieldErrorMessage;
  String? secondFieldErrorMessage;

  @override
  void initState() {
    super.initState();
    widget.firstFieldController.addListener(_updateCharacterCount);
    if (widget.secondFieldController != null) {
      widget.secondFieldController!.addListener(_updateCharacterCount);
    }
  }

  @override
  void dispose() {
    widget.firstFieldController.removeListener(_updateCharacterCount);
    if (widget.secondFieldController != null) {
      widget.secondFieldController!.removeListener(_updateCharacterCount);
    }
    super.dispose();
  }

  void _updateCharacterCount() {
    setState(() {});
  }

  void handleFirstButtonPressed() {
    bool hasError = false;

    if (widget.firstFieldController.text.isEmpty) {
      setState(() {
        firstFieldErrorMessage = '${widget.hintText} cannot be empty';
      });
      hasError = true;
    } else {
      setState(() {
        firstFieldErrorMessage = null;
      });
    }
    if (widget.secondFieldController != null &&
        (widget.secondFieldController!.text.isEmpty ||
            double.tryParse(widget.secondFieldController!.text) == null)) {
      setState(() {
        secondFieldErrorMessage = 'Enter a valid amount';
      });
      hasError = true;
    } else {
      setState(() {
        secondFieldErrorMessage = null;
      });
    }

    if (!hasError) {
      widget.firstButtonAction(widget.firstFieldController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.titleBackgroundColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                widget.title,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              children: [
                if (widget.subtitle != null) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.subtitle!,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  )
                ],
                // Container(
                //   decoration: BoxDecoration(
                //     color: const Color.fromARGB(255, 245, 245, 245),
                //     border:
                //         Border.all(color: const Color(0xFFC5C5C5), width: 1),
                //     borderRadius: BorderRadius.circular(11),
                //   ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: widget.firstFieldController,
                    maxLength: widget.maxLength,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          color: Color(0xFF454545),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      border: InputBorder.none,
                      counterText: '',
                    ),
                  ),
                ),
                // ),
                if (firstFieldErrorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      firstFieldErrorMessage!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                if (widget.secondFieldController != null)
                  Column(
                    children: [
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: const Color.fromARGB(255, 245, 245, 245),
                      //     borderRadius: BorderRadius.circular(11),
                      //     border: Border.all(
                      //         color: const Color(0xFFC5C5C5), width: 1),
                      //   ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Icon(
                            //   widget.secicon,
                            //   size: 15,
                            //   color: const Color(0xFF454545),
                            // ),
                            const SizedBox(width: 3),
                            Expanded(
                              child: TextFormField(
                                controller: widget.secondFieldController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d{0,2}')),
                                ],
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Icon(
                                      widget.secicon,
                                      size: 18,
                                      color: const Color(0xFF454545),
                                    ),
                                  ),
                                  hintText: widget.hintText2,
                                  hintStyle: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                      color: Color(0xFF454545),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  isDense: true,
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //),
                      if (secondFieldErrorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            secondFieldErrorMessage!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      const SizedBox(height: 16),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: handleFirstButtonPressed,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: widget.firstButtonColor,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                widget.firstButtonIcon,
                                color:
                                    widget.firstButtonIconColor ?? Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: widget.secondButtonAction,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: widget.secondButtonColor,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                widget.secondButtonIcon,
                                color: widget.secondButtonIconColor ??
                                    Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
