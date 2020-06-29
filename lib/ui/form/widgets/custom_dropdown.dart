import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  /// Optionally, the header can change on the
  /// expanded state by proving a [Widget] in [headerExpanded]. Colors can also
  /// be specified for the animated transitions/states. [children] are revealed
  /// when the expansion tile is expanded.
  const CustomDropdown({
    Key key,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.initiallyExpanded = false,
    @required this.header,
    this.expandedBackgroundColor,
    this.kExpand = const Duration(milliseconds: 200),
    this.headerExpanded,
    this.headerAnimationTween,
    this.dropdownPrreferedHeight,
    @required this.childOnTap,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  /// Called when the tile expands or collapses.
  ///
  /// When the tile starts expanding, this function is called with the value
  /// true. When the tile starts collapsing, this function is called with
  /// the value false.
  final ValueChanged<bool> onExpansionChanged;

  /// The widgets that are displayed when the tile expands.
  ///
  final List<Widget> children;

  /// The [Color] of the background of the [children] when expanded
  final Color expandedBackgroundColor;

  /// Specifies if the list tile is initially expanded (true) or collapsed (false, the default).
  final bool initiallyExpanded;

  /// The header for the expansion tile
  final Widget header;

  /// An optional widget to replace [header] with if the list is expanded
  final Widget headerExpanded;

  /// The duration of the animations
  final Duration kExpand;

  /// Header transition tween
  final Animatable<double> headerAnimationTween;

  /// Controls the on tap of the child.
  final Function childOnTap;
  final double dropdownPrreferedHeight;

  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  // Animation<double> _heightFactor;

  /// ExpansionTiles trailing icon's animation
  Animation<double> iconTurns;

  /// ExpansionTiles trailing icon's animation tween
  Animatable<double> halfTween;

  /// ExpansionTiles trailing icon's animation duration
  Duration animationduration;

  bool _isExpanded = false;

  double dropdownPrreferedHeight;

  @override
  void initState() {
    super.initState();
    halfTween = Tween<double>(begin: 0.0, end: 0.5);
    animationduration = Duration(milliseconds: 200);
    _controller = AnimationController(duration: widget.kExpand, vsync: this);
    iconTurns = _controller.drive(halfTween.chain(CustomDropdown._easeInTween));
    // _heightFactor = _controller.drive(CustomDropdown._easeInTween);
    _isExpanded = widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void didUpdateWidget(CustomDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dropdownPrreferedHeight != dropdownPrreferedHeight) {
      if (mounted)
        setState(() {
          dropdownPrreferedHeight = widget.dropdownPrreferedHeight;
        });
    }
    if (_isExpanded != widget.initiallyExpanded) {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => _handleTap(),
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _getHeader(),
                ],
              ),
            ),
          ),
          ClipRect(
            child: AnimatedOpacity(
              opacity: _isExpanded ? 1 : 0,
              duration: Duration(milliseconds: 200),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget trailingIcon() {
    return Padding(
      padding: EdgeInsets.only(
        right: 30,
      ),
      child: RotationTransition(
        turns: iconTurns,
        child: Icon(Icons.expand_more),
      ),
    );
  }

  /// Retrieves the header to display for the tile, derived from [_isExpanded] state
  Widget _getHeader() {
    if (!_isExpanded) {
      return Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          widget.header,
          trailingIcon(),
        ],
      );
    } else {
      return Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          widget.headerExpanded ?? widget.header,
          trailingIcon()
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed
          ? null
          : GestureDetector(
              onTap: () {
                widget.childOnTap();
                _handleTap();
              },
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                  maxHeight: dropdownPrreferedHeight ?? 300,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.children,
                  ),
                ),
              ),
            ),
    );
  }
}
