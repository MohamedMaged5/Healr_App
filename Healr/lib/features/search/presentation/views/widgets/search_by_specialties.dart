import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/search/presentation/managers/search_cubit/search_cubit.dart';
import 'package:healr/features/search/presentation/views/widgets/specialties_item.dart';

class SearchBySpecialties extends StatelessWidget {
  const SearchBySpecialties({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Search by specialties",
            style: Styles.textStyle16.copyWith(
              fontWeight: FontWeight.w500,
            )),
        SizedBox(height: 16.h),
        SpecialtiesItem(
          title: "Otolaryngology",
          imagePath: "assets/images/brain.svg",
          onTap: () {
            BlocProvider.of<SearchCubit>(context)
                .specialtiesSearch("Otolaryngology");
          },
        ),
        SizedBox(height: 16.h),
        SpecialtiesItem(
          title: "Dental Care",
          imagePath: "assets/images/tooth.svg",
          onTap: () {
            BlocProvider.of<SearchCubit>(context).specialtiesSearch("dental");
          },
        ),
        SizedBox(height: 16.h),
        SpecialtiesItem(
          title: "Gastroenterology",
          imagePath: "assets/images/stomach.svg",
          onTap: () {
            BlocProvider.of<SearchCubit>(context)
                .specialtiesSearch("Gastroenterology");
          },
        ),
        SizedBox(height: 16.h),
        SpecialtiesItem(
          title: "Ophthalmology",
          imagePath: "assets/images/eye.svg",
          onTap: () {
            BlocProvider.of<SearchCubit>(context)
                .specialtiesSearch("Ophthalmology");
          },
        ),
        SizedBox(height: 16.h),
        SpecialtiesItem(
          title: "Dermatology",
          imagePath: "assets/images/woman.svg",
          onTap: () {
            BlocProvider.of<SearchCubit>(context)
                .specialtiesSearch("Dermatology");
          },
        ),
        SizedBox(height: 16.h),
        SpecialtiesItem(
          title: "Pulmonology",
          imagePath: "assets/images/lungs.svg",
          onTap: () {
            BlocProvider.of<SearchCubit>(context)
                .specialtiesSearch("Pulmonology");
          },
        ),
        SizedBox(height: 16.h),
        SpecialtiesItem(
          title: "Psychiatry",
          imagePath: "assets/images/brain 2.svg",
          onTap: () {
            BlocProvider.of<SearchCubit>(context)
                .specialtiesSearch("Psychiatry");
          },
        ),
        SizedBox(height: 16.h),
        SpecialtiesItem(
          title: "Nephrology",
          imagePath: "assets/images/kidney.svg",
          onTap: () {
            BlocProvider.of<SearchCubit>(context)
                .specialtiesSearch("Nephrology");
          },
        ),
        SizedBox(height: 16.h),
        SpecialtiesItem(
          title: "Orthopedics",
          imagePath: "assets/images/bone.svg",
          onTap: () {
            BlocProvider.of<SearchCubit>(context)
                .specialtiesSearch("Orthopedics");
          },
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
