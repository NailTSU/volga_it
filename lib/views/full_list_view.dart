import 'package:flutter/material.dart';
import 'package:volga_it/components/full_list.dart';
import 'package:volga_it/components/root_wrapper.dart';

class FullListView extends StatelessWidget {
  const FullListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RootWrapper(
      title: 'Избранное',
      body: FullList(),
    );
  }

}