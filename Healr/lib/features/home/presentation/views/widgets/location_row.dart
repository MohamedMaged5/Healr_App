import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healr/core/utils/styles.dart';

class LocationRow extends StatelessWidget {
  const LocationRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset("assets/images/location-06.svg"),
        SizedBox(
          width: 6.w,
        ),
        Expanded(
          child: Text("Ismailia Medical Complex",
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: Styles.textStyle14.copyWith(
                fontWeight: FontWeight.w500,
              )),
        ),
      ],
    );
  }
}
