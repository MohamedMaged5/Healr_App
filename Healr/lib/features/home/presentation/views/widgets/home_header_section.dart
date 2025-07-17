import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healr/core/utils/shared_pref_cache.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';

class HomeHeaderSection extends StatefulWidget {
  const HomeHeaderSection({super.key});

  @override
  State<HomeHeaderSection> createState() => _HomeHeaderSectionState();
}

class _HomeHeaderSectionState extends State<HomeHeaderSection> {
  String name = '';

  @override
  void initState() {
    super.initState();
    final cachedName = SharedPrefCache.getCache(key: 'name');
    if (cachedName.isNotEmpty) {
      setState(() {
        name = cachedName;
      });
    } else {
      context.read<ProfileCubit>().getProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          name = state.profile.name!;
          SharedPrefCache.saveCache(key: 'name', value: name);
        } else if (state is ProfileError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          });
        }

        if (name.isEmpty && state is! ProfileLoaded) {
          return const SizedBox.shrink();
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello,',
                  style: Styles.textStyle16.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  name
                      .trim()
                      .split(' ')
                      .take(2)
                      .map((value) => value.isNotEmpty
                          ? value[0].toUpperCase() +
                              value.substring(1).toLowerCase()
                          : '')
                      .join(' '),
                  style: Styles.textStyle22.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SvgPicture.asset(
              'assets/images/home_logo.svg',
            ),
          ],
        );
      },
    );
  }
}
