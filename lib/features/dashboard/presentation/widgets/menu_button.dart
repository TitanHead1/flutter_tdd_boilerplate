import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../presentation/config/app_images.dart';


class MenuButton extends StatelessWidget {
  const MenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (ctx) => IconButton(
          icon: SvgPicture.asset(
            AppImages.menuIconSvg,
          ),
          onPressed: () async {
            Scaffold.of(ctx).openDrawer();
          }),
    );
  }
}
