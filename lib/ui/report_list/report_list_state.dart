import 'package:flutter/foundation.dart';
import 'package:hackerone/models/reports_list.dart';

class ReportListState {}

class ReportListInitialState extends ReportListState {}

class ReportListLoadMoreState extends ReportListState {}

class ReportListLoadingState extends ReportListState {}

class ReportListLoadedState extends ReportListState {
  final List<Edges> reports;
  final String cursor;
  final bool nextPage;
  final int totalCount;
  final DateTime lastFetch;

  ReportListLoadedState(
      {@required this.reports,
      @required this.cursor,
      @required this.nextPage,
      @required this.totalCount,
      @required this.lastFetch});

  ReportListLoadedState copyWith(
      {List<Edges> reports, String cursor, bool nextPage}) {
    return ReportListLoadedState(
      reports: reports ?? this.reports,
      cursor: cursor ?? this.cursor,
      nextPage: nextPage ?? this.nextPage,
      totalCount: totalCount ?? this.totalCount,
      lastFetch: lastFetch ?? this.lastFetch,
    );
  }
}

class ReportListErrorState extends ReportListState {}

class ReportListRefreshCompleteState extends ReportListState {}
