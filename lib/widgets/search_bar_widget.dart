import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_base/enums/enums.dart';
import 'package:flutter_base/locales/localizes.dart';
import 'package:flutter_base/styles/common_style.dart';
import 'package:flutter_base/values/colors.dart';
import 'package:flutter_base/values/constants.dart';
import 'package:flutter_base/values/images.dart';
import 'package:flutter_base/widgets/button_widget.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

typedef Widget AppBarCallback(BuildContext context);
typedef void TextFieldSubmitCallback(String value);
typedef void TextFieldChangeCallback(String value);
typedef void SetStateCallback(void fn());

class SearchBar {
  /// Whether the search should take place "in the existing search bar", meaning whether it has the same background or a flipped one. Defaults to true.
  final bool inBar;

  /// Whether or not the search bar should close on submit. Defaults to true.
  final bool closeOnSubmit;

  /// Whether the text field should be cleared when it is submitted
  final bool clearOnSubmit;

  /// A void callback which takes a string as an argument, this is fired every time the search is submitted. Do what you want with the result.
  final TextFieldSubmitCallback? onSubmitted;

  /// A void callback which gets fired on close button press.
  final VoidCallback? onClosed;

  /// A callback which is fired when clear button is pressed.
  final VoidCallback? onCleared;

  /// Since this should be inside of a State class, just pass setState to this.
  final SetStateCallback setState;

  /// Show action button, defaults to true.
  final bool? showActionButton;

  /// What the hintText on the search bar should be. Defaults to 'Search'.
  String? hintText;

  /// Whether search is currently active.
  final ValueNotifier<bool> isSearching = ValueNotifier(false);

  /// A callback which is invoked each time the text field's value changes
  final TextFieldChangeCallback? onChanged;

  /// The controller to be used in the textField.
  TextEditingController? controller;

  /// Whether the clear button should be active (fully colored) or inactive (greyed out)
  bool _clearActive = false;

  /// icon color
  Color? iconColor;

  final Widget? suffixIcon; // Suffix icon

  final Widget? prefixIcon; // Prefix icon

  final bool? showLeadingButton; // Show leading button

  String? title; // Title

  final TextStyle? titleStyle; // Text style

  ValueNotifier<bool> animationAction =
      ValueNotifier(false); // Animation action on/off show action button

  bool? isBackground; // Is back ground

  SearchBar({
    required this.setState,
    // @required this.buildDefaultAppBar,
    this.onSubmitted,
    this.controller,
    this.hintText,
    this.inBar = true,
    this.iconColor,
    this.closeOnSubmit = true,
    this.clearOnSubmit = true,
    this.showActionButton = true,
    this.showLeadingButton = true,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.onClosed,
    this.onCleared,
    this.title,
    this.titleStyle,
    this.isBackground = true,
  }) {
    if (this.controller == null) {
      this.controller = TextEditingController();
    }

    // Don't waste resources on listeners for the text controller if the dev
    // doesn't want a clear button anyways in the search bar
    if (!this.showActionButton!) {
      return;
    }

    this.controller!.addListener(() {
      if (this.controller!.text.isEmpty) {
        // If clear is already disabled, don't disable it
        if (_clearActive) {
          setState(() {
            _clearActive = false;
          });
        }

        return;
      }

      // If clear is already enabled, don't enable it
      if (!_clearActive) {
        setState(() {
          _clearActive = true;
        });
      }
    });
  }

  /// Initializes the search bar.
  /// This adds a route that listens for onRemove (and stops the search when that happens), and then calls [setState] to rebuild and start the search.
  void beginSearch(context) {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: () {
      setState(() {
        isSearching.value = false;
        animationAction.value = false;
        isBackground = true;
      });
    }));

    setState(() {
      isSearching.value = true;
      animationAction.value = true;
      isBackground = false;
    });
  }

  /// Builds the search bar!
  /// The leading will always be a back button.
  /// backgroundColor is determined by the value of inBar
  /// title is always a [TextField] with the key 'SearchBarTextField', and various text stylings based on [inBar]. This is also where [onSubmitted] has its listener registered.
  AppBar buildSearchBar(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color buttonColor = iconColor ?? Colors.primary;

    return AppBar(
      elevation: Constants.elevation,
      shadowColor: Colors.shadow,
      leading: isBackground!
          ? null
          : IconButton(
              icon: BackButtonIcon(),
              color: isBackground! ? buttonColor : Colors.primary,
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: () {
                onClosed?.call();
                controller!.clear();
                Navigator.maybePop(context);
              }),
      automaticallyImplyLeading: showLeadingButton!,
      brightness: Brightness.dark,
      backgroundColor: theme.canvasColor,
      flexibleSpace: isBackground!
          ? Image(
              image: AssetImage(Images.bgHeader),
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            )
          : null,
      titleSpacing: 0,
      title: !isSearching.value
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: Constants.margin16),
              child: Text(
                title ?? "",
                style: titleStyle ?? CommonStyle.textLargeBold(),
              ),
            )
          : Directionality(
              textDirection: Directionality.of(context),
              child: Container(
                alignment: Alignment.center,
                height: 38,
                child: renderSearchBar(context),
              ),
            ),
      actions: !showActionButton!
          ? null
          : [
              // Show an icon if clear is not active, so there's no ripple on tap
              !animationAction.value
                  ? IconButton(
                      icon: !_clearActive
                          ? Icon(Icons.search)
                          : Icon(Icons.clear),
                      color: iconColor ?? Colors.primary,
                      onPressed: () {
                        if (!_clearActive) {
                          onCleared?.call();
                          controller!.clear();
                        }
                        beginSearch(context);
                      },
                    )
                  : SizedBox(
                      width: Constants.margin16,
                    ),
            ],
    );
  }

  /// Handle submit icon text input
  _onClickSubmitIconTextField() {}

  InputBorder _border({Color? color, double? width, double? radius}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? Constants.cornerRadius * 4),
      borderSide: BorderSide(
        color: color ?? Colors.background,
        width: width ?? Constants.borderWidth,
      ),
    );
  } // Function return outline border custom

  /// Render search bar
  Widget renderSearchBar(context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        border: Border.all(
          color: Colors.background,
          style: BorderStyle.solid,
          width: Constants.borderWidth,
        ),
        color: Colors.background,
      ),
      padding: EdgeInsets.only(right: Constants.padding8),
      child: TextFormField(
        key: Key('SearchBarTextField'),
        keyboardType: TextInputType.text,
        maxLines: 1,
        style: CommonStyle.text(),
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText ?? Localizes.search.tr,
          hintStyle: CommonStyle.text(),
          prefixIcon: ButtonWidget(
            type: ButtonType.iconButton,
            child: Image.asset(Images.icSearchGrey),
            onTap: () {},
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: _onClickSubmitIconTextField, icon: suffixIcon!)
              : null,
          border: InputBorder.none,
        ),
        onChanged: this.onChanged,
        onFieldSubmitted: (String val) async {
          // if (closeOnSubmit) {
          //   await Navigator.maybePop(context);
          // }
          // if (clearOnSubmit) {
          //   controller.clear();
          // }
          if (onSubmitted != null) {
            onSubmitted?.call(val);
          }
        },
        controller: controller,
        autofocus: true,
      ),
    );
  }

  // /// Returns an AppBar based on the value of [isSearching]
  AppBar build(BuildContext context) {
    return buildSearchBar(context);
  }
}
