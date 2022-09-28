import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_base/models/common/header_model.dart';
import 'package:flutter_base/values/colors.dart';
import 'package:flutter_base/widgets/search_bar_widget.dart';

// ignore: must_be_immutable
class HeaderWidget extends StatefulWidget {
  String? title; // Title
  final TextStyle? titleStyle; // Title Style
  final Function? onSubmitted; // On submitted
  final bool showSearchBar; // Show search bar
  final bool showLeadingBar; // Show search bar
  TextEditingController?
      controller; // The controller to be used in the textField.
  final TextFieldChangeCallback?
      onChanged; // A callback which is invoked each time the text field's value changes
  final bool
      closeOnSubmit; // Whether or not the search bar should close on submit. Defaults to true.
  final bool
      clearOnSubmit; // Whether the text field should be cleared when it is submitted
  final Widget? suffixIcon; // Suffix icon
  final Widget? prefixIcon; // Prefix icon
  String? hintText; // Hint text
  final EdgeInsets? contentPadding; // Content padding
  final bool showIconAction; // Show icon action
  final bool inBar; // Show icon search
  final String? initialValue; // Initial value
  final bool? isBackground; // Is back ground
  final Color? colorIcon; // Color icon
  final Function? onClosed; // On closed
  final Function? onCleared; // On cleared

  /// What the hintText on the search bar should be. Defaults to 'Search'.

  HeaderWidget({
    this.title,
    this.titleStyle,
    this.onSubmitted,
    this.showSearchBar = true,
    this.showLeadingBar = true,
    this.closeOnSubmit = true,
    this.clearOnSubmit = true,
    this.suffixIcon,
    this.hintText,
    this.contentPadding,
    this.prefixIcon,
    this.controller,
    this.onChanged,
    this.onClosed,
    this.onCleared,
    this.showIconAction = true,
    this.inBar = false,
    this.initialValue,
    this.isBackground,
    this.colorIcon,
  }) {
    if (this.controller == null) {
      this.controller = this.initialValue != null
          ? TextEditingController(text: this.initialValue)
          : null;
    }
  }

  @override
  HeaderWidgetState createState() {
    return HeaderWidgetState(
      headerModel: HeaderModel(
        controller: this.controller,
        title: this.title,
        titleStyle: this.titleStyle,
        showIconAction: this.showIconAction,
        showLeadingButton: this.showLeadingBar,
        isBackground: this.isBackground,
        colorIcon: this.colorIcon,
      ),
    );
  }
}

class HeaderWidgetState extends State<HeaderWidget> {
  late SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void onSubmitted(String value) {
    if (widget.onSubmitted != null) {
      widget.onSubmitted!(value);
    }
    // setState(() => _scaffoldKey.currentState
    //     .showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
  }

  onChanged(text) {
    widget.onChanged!(text);
  }

  HeaderWidgetState({required HeaderModel headerModel}) {
    searchBar = SearchBar(
      controller: headerModel.controller ?? null,
      inBar: false,
      iconColor: headerModel.colorIcon ?? Colors.primary,
      setState: setState,
      onSubmitted: onSubmitted,
      isBackground: headerModel.isBackground,
      showLeadingButton: headerModel.showLeadingButton,
      showActionButton: headerModel.showIconAction,
      title: headerModel.title,
      titleStyle: headerModel.titleStyle,
      onChanged: onChanged,
      onCleared: () {
        if (widget.onCleared != null) {
          widget.onCleared!();
        }
      },
      onClosed: () {
        if (widget.onClosed != null) {
          widget.onClosed!();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return searchBar.build(context);
  }
}
