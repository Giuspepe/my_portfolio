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
    return BlocProvider(
      create: (context) => SecurityListBloc(repository: Repository()),
      child: BlocBuilder<SecurityListBloc, SecurityListState>(
          builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('All Securities'),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: state is SecurityListFetchedState
                    ? () => Navigator.of(context).pushNamed('/securities/add')
                    : null,
              )
            ],
          ),
          drawer: SideDrawer(),
          body: SecuritiesList(state),
        );
      }),
    );
  }
}

class SecuritiesList extends StatelessWidget {
  final SecurityListState state;

  SecuritiesList(this.state);

  @override
  Widget build(BuildContext context) {
    if (state is SecurityListUninitializedState) {
      context.bloc<SecurityListBloc>().add(SecurityListFetchEvent());
      return Container();
    } else if (state is SecurityListFetchingState) {
      return Center(child: CircularProgressIndicator());
    } else if (state is SecurityListFetchedState) {
      return SecuritiesListView(state);
    } else {
      return Center(child: Text('An error occured.'));
    }
  }
}

class SecuritiesListView extends StatelessWidget {
  final SecurityListFetchedState state;

  SecuritiesListView(this.state);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: state.securities.length,
      itemBuilder: (ctx, i) => SecurityListTile(state.securities[i]),
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
