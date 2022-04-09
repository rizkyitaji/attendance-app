import 'package:attendance/services/assets.dart';
import 'package:attendance/services/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'container_shadow.dart';
import 'primary_ink_well.dart';

class EmptyWidget extends StatelessWidget {
  final String? description;
  final VoidCallback? action;

  EmptyWidget({this.description, this.action});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(
            illustrationEmpty,
            width: 150,
          ),
          SizedBox(height: 24),
          Text(
            description ?? 'Data masih kosong',
            style: poppinsBlackw400.copyWith(color: Colors.grey),
          ),
          if (action != null) ...[
            SizedBox(height: 24),
            SizedBox(
              width: 150,
              child: Center(
                child: ContainerShadow(
                  child: PrimaryInkWell(
                    onTap: action,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      child: Center(
                        child: Text(
                          'Muat ulang',
                          style: poppinsBlackw400.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
