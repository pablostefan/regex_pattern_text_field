import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:regex_pattern_text_field/controllers/regex_pattern_text_editing_controller.dart';
import 'package:regex_pattern_text_field/models/regex_pattern_matched.dart';
import 'package:regex_pattern_text_field/models/regex_pattern_text_style.dart';

class RegexPatternTextField extends StatefulWidget {
  final Object groupId;
  final bool defaultRegexPatternStyles;
  final List<RegexPatternTextStyle>? regexPatternStyles;
  final Function(RegexPatternMatched model)? onMatch;
  final Function(String text)? onNonMatch;
  final RegexPatternTextEditingController? regexPatternController;
  final FocusNode? focusNode;
  final InputDecoration decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool readOnly;
  final bool? showCursor;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final Function(List<RegexPatternMatched> regexPatternMatchedList, String text)? onChanged;
  final VoidCallback? onEditingComplete;
  final Function(List<RegexPatternMatched> regexPatternMatchedList, String text)? onSubmitted;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final bool? cursorOpacityAnimates;
  final Color? cursorColor;
  final BoxHeightStyle selectionHeightStyle;
  final BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final DragStartBehavior dragStartBehavior;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final String? restorationId;
  final bool? enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final GestureTapCallback? onTap;
  final MouseCursor? mouseCursor;
  final InputCounterWidgetBuilder? buildCounter;
  final bool enableIMEPersonalizedLearning;
  final Clip clipBehavior;
  final bool canRequestFocus;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final TapRegionCallback? onTapOutside;
  final bool scribbleEnabled;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final UndoHistoryController? undoController;
  final ToolbarOptions? toolbarOptions;
  final MaterialStatesController? statesController;
  final bool? ignorePointers;
  final Color? cursorErrorColor;
  final bool onTapAlwaysCalled;

  const RegexPatternTextField({
    super.key,
    this.groupId = EditableText,
    this.focusNode,
    this.undoController,
    this.decoration = const InputDecoration(),
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.toolbarOptions,
    this.showCursor,
    this.autofocus = false,
    this.statesController,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled,
    this.ignorePointers,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorOpacityAnimates,
    this.cursorColor,
    this.cursorErrorColor,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.selectionControls,
    this.onTap,
    this.onTapAlwaysCalled = false,
    this.onTapOutside,
    this.mouseCursor,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints = const <String>[],
    this.contentInsertionConfiguration,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.canRequestFocus = true,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.regexPatternController,
    this.regexPatternStyles,
    this.keyboardType,
    this.defaultRegexPatternStyles = true,
    this.onMatch,
    this.onNonMatch,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableInteractiveSelection,
  });

  static Widget _defaultContextMenuBuilder(BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(editableTextState: editableTextState);
  }

  @override
  State<RegexPatternTextField> createState() => _RegexPatternTextFieldState();
}

class _RegexPatternTextFieldState extends State<RegexPatternTextField> {
  late RegexPatternTextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.regexPatternController ?? RegexPatternTextEditingController();
    _controller.setRegexPatternStyle(widget.regexPatternStyles, widget.defaultRegexPatternStyles);
    _controller.setOnMatch(widget.onMatch);
    _controller.setOnNonMatch(widget.onNonMatch);
  }

  void _regexPatternOnChange(String text) => widget.onChanged?.call(_controller.regexPatternMatchedList, text);

  void _regexPatternOnSubmitted(String text) => widget.onSubmitted?.call(_controller.regexPatternMatchedList, text);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: _controller,
        canRequestFocus: widget.canRequestFocus,
        clipBehavior: widget.clipBehavior,
        contentInsertionConfiguration: widget.contentInsertionConfiguration,
        contextMenuBuilder: widget.contextMenuBuilder,
        dragStartBehavior: widget.dragStartBehavior,
        inputFormatters: widget.inputFormatters,
        magnifierConfiguration: widget.magnifierConfiguration,
        onAppPrivateCommand: widget.onAppPrivateCommand,
        onChanged: _regexPatternOnChange,
        onTapOutside: widget.onTapOutside,
        restorationId: widget.restorationId,
        scribbleEnabled: widget.scribbleEnabled,
        spellCheckConfiguration: widget.spellCheckConfiguration,
        undoController: widget.undoController,
        enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
        textAlignVertical: widget.textAlignVertical,
        obscureText: widget.obscureText,
        obscuringCharacter: widget.obscuringCharacter,
        smartDashesType: widget.smartDashesType,
        smartQuotesType: widget.smartQuotesType,
        strutStyle: widget.strutStyle,
        selectionControls: widget.selectionControls,
        mouseCursor: widget.mouseCursor,
        cursorOpacityAnimates: widget.cursorOpacityAnimates,
        cursorHeight: widget.cursorHeight,
        selectionHeightStyle: widget.selectionHeightStyle,
        selectionWidthStyle: widget.selectionWidthStyle,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        keyboardAppearance: widget.keyboardAppearance,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        style: widget.style,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        readOnly: widget.readOnly,
        showCursor: widget.showCursor,
        autofocus: widget.autofocus,
        autocorrect: widget.autocorrect,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        cursorColor: widget.cursorColor,
        cursorRadius: widget.cursorRadius,
        cursorWidth: widget.cursorWidth,
        buildCounter: widget.buildCounter,
        autofillHints: widget.autofillHints,
        decoration: widget.decoration,
        expands: widget.expands,
        onEditingComplete: widget.onEditingComplete,
        onTap: widget.onTap,
        onSubmitted: _regexPatternOnSubmitted,
        enabled: widget.enabled,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        enableSuggestions: widget.enableSuggestions,
        scrollController: widget.scrollController,
        scrollPadding: widget.scrollPadding,
        scrollPhysics: widget.scrollPhysics);
  }
}
