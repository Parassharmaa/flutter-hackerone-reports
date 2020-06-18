import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackerone/models/reports_list.dart';
import 'package:hackerone/ui/report_detail/report_detail.dart';
import 'bloc.dart';
import 'dart:async';
import 'widgets/report_title_widget.dart';
import 'package:hackerone/ui/widget/bottom_loader.dart';

class ReportList extends StatefulWidget {
  ReportList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReportList createState() => _ReportList();
}

class _ReportList extends State<ReportList> {
  ReportListBloc bloc;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ReportListBloc>(context);
    _refreshCompleter = Completer<void>();
    if (bloc.state is ReportListLoadedState) {
      bloc.add(ReportListRefreshEvent());
    } else {
      bloc.add(ReportListLoadEvent(20));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: BlocListener<ReportListBloc, ReportListState>(
        listener: (BuildContext context, state) {
          if (state is ReportListErrorState) {
            final snackBar = SnackBar(content: Text('An error occurred'));
            Scaffold.of(context).showSnackBar(snackBar);
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
        },
        child: RefreshIndicator(
          onRefresh: () {
            bloc.add(ReportListRefreshEvent());
            return _refreshCompleter.future;
          },
          child: BlocBuilder<ReportListBloc, ReportListState>(
            builder: (BuildContext context, ReportListState state) {
              print(state);
              if (state is ReportListLoadedState) {
                _refreshCompleter?.complete();
                _refreshCompleter = Completer();
                List<Edges> data = state.reports;
                bool nextPage = state.nextPage;
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent &&
                        state.nextPage) {
                      bloc.add(ReportListLoadMoreEvent(20));
                    }
                    return false;
                  },
                  child: ListView.separated(
                    itemCount: !nextPage ? data.length : data.length + 1,
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 2,
                        color: Colors.white70,
                      );
                    },
                    itemBuilder: (context, index) {
                      return index >= data.length
                          ? BottomLoader()
                          : InkWell(
                              onTap: () {
                                Edges report = data[index];
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ReportDetail(
                                      reportId: report.node.databaseId,
                                      reportTitle: report.node.report.title,
                                    ),
                                  ),
                                );
                              },
                              child: ReportTileWidget(
                                reportEdge: data[index],
                              ),
                            );
                    },
                  ),
                );
              }
              if (state is ReportListLoadingState || state is ReportListState) {
                return Center(child: CircularProgressIndicator());
              }
              return Container();
            },
          ),
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        tooltip: "Filter",
//        child: Icon(Icons.filter_list),
//        onPressed: () {
//          showModalBottomSheet(
//              context: context,
//              builder: (BuildContext bc) {
//                return Container(
//                  child: new Wrap(
//                    children: <Widget>[
//                      new ListTile(
//                          leading: new Icon(Icons.favorite_border),
//                          title: new Text('Popular Reports'),
//                          onTap: () => {}),
//                      Divider(),
//                      new ListTile(
//                        leading: new Icon(Icons.update),
//                        title: new Text('New Reports'),
//                        onTap: () => {},
//                      ),
//                    ],
//                  ),
//                );
//              });
//        },
//      ),
    );
  }
}
