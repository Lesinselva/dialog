import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final String subtitle;
  final TextEditingController firstFieldController;
  final TextEditingController? secondFieldController;
  final IconData? icon;
  final Color? iconColor;
  final IconData? secicon;
  final int maxLength;
  final String firstButtonLabel;
  final Color firstButtonColor;
  final IconData firstButtonIcon;
  final Color? firstButtonIconColor;
  final Color? firstButtonTextColor;
  final Function(String) firstButtonAction;
  final String secondButtonLabel;
  final Color secondButtonColor;
  final IconData secondButtonIcon;
  final Color? secondButtonIconColor;
  final Color? secondButtonTextColor;
  final VoidCallback secondButtonAction;
  final Gradient titleBackgroundGradient;

  const CustomDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.firstFieldController,
    this.secondFieldController,
    this.icon,
    this.iconColor,
    this.secicon,
    required this.maxLength,
    required this.firstButtonLabel,
    required this.firstButtonColor,
    required this.firstButtonIcon,
    this.firstButtonIconColor,
    this.firstButtonTextColor,
    required this.firstButtonAction,
    required this.secondButtonLabel,
    required this.secondButtonColor,
    required this.secondButtonIcon,
    this.secondButtonIconColor,
    this.secondButtonTextColor,
    required this.secondButtonAction,
    required this.titleBackgroundGradient,
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
  }

  @override
  void dispose() {
    widget.firstFieldController.removeListener(_updateCharacterCount);
    super.dispose();
  }

  void _updateCharacterCount() {
    setState(() {});
  }

  void handleFirstButtonPressed() {
    bool hasError = false;

    if (widget.firstFieldController.text.isEmpty) {
      setState(() {
        firstFieldErrorMessage = '${widget.subtitle} cannot be empty';
      });
      hasError = true;
    } else {
      setState(() {
        firstFieldErrorMessage = null;
      });
    }

    if (widget.secondFieldController != null) {
      if (widget.secondFieldController!.text.isEmpty ||
          double.tryParse(widget.secondFieldController!.text) == null) {
        setState(() {
          secondFieldErrorMessage = 'Enter a valid amount';
        });
        hasError = true;
      } else {
        setState(() {
          secondFieldErrorMessage = null;
        });
      }
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
              gradient: widget.titleBackgroundGradient,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 22),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (widget.icon != null)
                          Icon(
                            widget.icon,
                            size: 20,
                            color: widget.iconColor ?? Colors.black,
                          ),
                        const SizedBox(width: 3),
                        Text(widget.subtitle),
                      ],
                    ),
                    Text(
                      '${widget.firstFieldController.text.length}/${widget.maxLength}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 245, 245, 245),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: widget.firstFieldController,
                      maxLength: widget.maxLength,
                      decoration: InputDecoration(
                        hintText: 'Enter your ${widget.subtitle}',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 199, 197, 197),
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        counterText: '',
                      ),
                    ),
                  ),
                ),
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.black,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Icon(
                                      widget.secicon,
                                      size: 11.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 3),
                                const Text('Selling price'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 245, 245, 245),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Icon(
                                      widget.secicon,
                                      size: 17,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 3),
                                    Expanded(
                                      child: TextFormField(
                                        controller:
                                            widget.secondFieldController,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d*\.?\d{0,2}')),
                                        ],
                                        decoration: const InputDecoration(
                                          hintText: '0',
                                          hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 199, 197, 197),
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                widget.firstButtonIcon,
                                color:
                                    widget.firstButtonIconColor ?? Colors.black,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                widget.firstButtonLabel,
                                style: TextStyle(
                                  color: widget.firstButtonTextColor ??
                                      Colors.black,
                                ),
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
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                widget.secondButtonIcon,
                                color: widget.secondButtonIconColor ??
                                    Colors.black,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                widget.secondButtonLabel,
                                style: TextStyle(
                                  color: widget.secondButtonTextColor ??
                                      Colors.black,
                                ),
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
