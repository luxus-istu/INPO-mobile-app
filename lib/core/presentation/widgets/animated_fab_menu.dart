import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inpo_mobile_app/core/constants/constants.dart';
import 'package:inpo_mobile_app/core/util/responsive.dart';

class AnimatedFabMenu extends StatefulWidget {
  const AnimatedFabMenu({super.key});

  @override
  State<AnimatedFabMenu> createState() => _AnimatedFabMenuState();
}

class _AnimatedFabMenuState extends State<AnimatedFabMenu>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Позволяем элементам выходить за пределы Stack
      children: [
        if (_isOpen) ..._buildMenuItems(),
        _buildMainFab(),
      ],
    );
  }

  Widget _buildMainFab() {
    return Positioned(
      right: Responsive.getResponsiveValue(
        context,
        mobile: 16,
        tablet: 24,
        desktop: 32,
      ),
      bottom: Responsive.getResponsiveValue(
        context,
        mobile: 16,
        tablet: 24,
        desktop: 32,
      ),
      child: FloatingActionButton(
        onPressed: _toggleMenu,
        backgroundColor: Colors.white,
        elevation: 4,
        shape: const RoundedRectangleBorder(
            side: BorderSide(
                color: Color(0xFFD5D5D5),
                strokeAlign: BorderSide.strokeAlignInside,
                width: 1),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          transitionBuilder: (child, animation) => RotationTransition(
            turns: Tween<double>(begin: 0, end: .5).animate(animation),
            child: child,
          ),
          child: Icon(
            _isOpen ? Icons.close : Icons.menu,
            key: ValueKey(_isOpen),
            size: Responsive.getResponsiveValue(
              context,
              mobile: 40,
              tablet: 48,
              desktop: 56,
            ),
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMenuItems() {
    return Constants.menuItems.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      final baseBottom = Responsive.getResponsiveValue(
        context,
        mobile: 16.0,
        tablet: 24.0,
        desktop: 32.0,
      );
      final spacing = Responsive.getResponsiveValue(
        context,
        mobile: 64.0,
        tablet: 72.0,
        desktop: 80.0,
      );
      final bottomPosition = baseBottom + (index + 1) * spacing;

      return _buildPositionedItem(
        icon: item.icon,
        label: item.label,
        onTap: () {
          if (item.route.isNotEmpty) {
            context.go(item.route);
            // this.widget.onTap(item.route);
          }
          _toggleMenu();
        },
        bottomPosition: bottomPosition,
        animationInterval: index * 0.15,
      );
    }).toList();
  }

  Widget _buildPositionedItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required double bottomPosition,
    required double animationInterval,
  }) {
    final animation = CurvedAnimation(
      parent: _animationController,
      curve: Interval(animationInterval, 1.0, curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Positioned(
          right: Responsive.getResponsiveValue(
            context,
            mobile: 16,
            tablet: 24,
            desktop: 32,
          ),
          bottom: bottomPosition,
          child: FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.5, 0), // Начинает за правым краем экрана
                end: Offset.zero, // Заканчивается на своем месте
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.elasticOut, // Упругая анимация
              )),
              child: FloatingActionButton.extended(
                onPressed: onTap,
                icon: Icon(
                  icon,
                  color: Colors.black,
                  size: Responsive.getResponsiveValue(
                    context,
                    mobile: 24,
                    tablet: 28,
                    desktop: 32,
                  ),
                ),
                label: Text(
                  label,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Responsive.getResponsiveValue(
                      context,
                      mobile: 14,
                      tablet: 16,
                      desktop: 18,
                    ),
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 2,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFFD5D5D5), width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
              ),
            ),
          ),
        );
      },
    );
  }
}
