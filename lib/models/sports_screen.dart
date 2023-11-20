import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layout/news_layout/cubit/cubit.dart';
import '../layout/news_layout/cubit/states.dart';
import '../shared/components/components.dart';


class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List list = NewsCubit.get(context).sports;
        return articleBuilder(list, context);
      },
    );
  }
}
