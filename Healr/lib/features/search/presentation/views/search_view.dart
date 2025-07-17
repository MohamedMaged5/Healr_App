import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healr/core/utils/service_locator.dart';
import 'package:healr/features/search/data/repos/search_repo_imp.dart';
import 'package:healr/features/search/presentation/managers/search_cubit/search_cubit.dart';
import 'package:healr/features/search/presentation/views/widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(getIt.get<SearchRepoImp>()),
      child: const SearchViewBody(),
    );
  }
}
