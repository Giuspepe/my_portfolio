import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/side_drawer.dart';
import '../widgets/security_list_tile.dart';
import '../../BLoC/security_bloc.dart';
import '../../BLoC/states.dart';
import '../../BLoC/events.dart';
import '../../DataLayer/repository.dart';

class SecuritiesScreen extends StatelessWidget {
  static const routeName = '/securities';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Portfolio'),
      ),
      drawer: SideDrawer(),
      body: SecuritiesList(),
    );
  }
}

class SecuritiesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SecurityListBloc(repository: Repository()),
      child: BlocBuilder<SecurityListBloc, SecurityListState>(
        builder: (context, state) {
          print('Securities screen: $state');
          if (state is SecurityListUninitializedState) {
            context.bloc<SecurityListBloc>().add(SecurityListFetchEvent());
            return Container();
          } else if (state is SecurityListFetchingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SecurityListFetchedState) {
            return ListView.separated(
              itemCount: state.securities.length,
              itemBuilder: (ctx, i) => SecurityListTile(state.securities[i]),
              separatorBuilder: (context, index) => Divider(),
            );
          } else {
            return Center(child: Text('some other state'));
          }
        },
      ),
    );
  }
}
