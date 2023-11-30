import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/sizr.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class MySpeneSq extends StatelessWidget {
  const MySpeneSq({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitCubeGrid(
      size: width(70),
      itemBuilder: (context, index) {
        bool isDark =
            Provider.of<ThemeProvider>(context, listen: false).darkTheme;

        final colors = [
          Theme.of(context).primaryColor,
          isDark ? Colors.black : Colors.white
        ];
        final color = colors[index % colors.length];
        return DecoratedBox(
            decoration: BoxDecoration(color: color, shape: BoxShape.rectangle));
      },
    )
        // child: CircularProgressIndicator(
        //     valueColor: AlwaysStoppedAnimation<Color>(
        //         Theme.of(context).primaryColor))

        );
  }
}
