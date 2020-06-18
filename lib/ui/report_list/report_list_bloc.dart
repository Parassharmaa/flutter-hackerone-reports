import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hackerone/models/reports_list.dart';
import 'package:hackerone/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ReportListBloc extends HydratedBloc<ReportListEvent, ReportListState> {
  ReportRepository reportRepository;

  ReportListBloc({@required this.reportRepository});

  @override
  get initialState => super.initialState ?? ReportListInitialState();

  @override
  Stream<Transition<ReportListEvent, ReportListState>> transformEvents(
    Stream<ReportListEvent> events,
    TransitionFunction<ReportListEvent, ReportListState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  ReportListState fromJson(Map<String, dynamic> json) {
    return ReportListLoadedState(
        reports: (jsonDecode(json['reports']) as List)
            .map((i) => Edges.fromJson(i))
            .toList(),
        cursor: json['cursor'],
        nextPage: json['nextPage'],
        lastFetch: DateTime.parse(json['lastFetch']),
        totalCount: json['totalCount']);
  }

  @override
  Map<String, dynamic> toJson(ReportListState state) {
    if (state is ReportListLoadedState) {
      return {
        "reports": jsonEncode(state.reports),
        "cursor": state.cursor,
        "nextPage": state.nextPage,
        "lastFetch": state.lastFetch.toIso8601String(),
        "totalCount": state.totalCount
      };
    }
    return null;
  }

  @override
  Stream<ReportListState> mapEventToState(event) async* {
    final currentState = state;
    if (event is ReportListLoadEvent) {
      try {
        if (currentState is ReportListInitialState) {
          yield ReportListLoadingState();
          final QueryResult result =
              await reportRepository.fetchReports(event.numOfReports);
          ReportsList data = new ReportsList.fromJson(result.data);
          reportRepository.saveReportCount(data.hacktivityItems.totalCount);
          yield ReportListLoadedState(
            reports: data.hacktivityItems.edges,
            cursor: data.hacktivityItems.pageInfo.endCursor,
            nextPage: data.hacktivityItems.pageInfo.hasNextPage,
            totalCount: data.hacktivityItems.totalCount,
            lastFetch: DateTime.now(),
          );
        }
      } catch (e) {
        print(e);
        yield ReportListErrorState();
      }
    } else if (event is ReportListLoadMoreEvent) {
      if (currentState is ReportListLoadedState) {
        final QueryResult result = await reportRepository
            .fetchReports(event.numOfReports, cursor: currentState.cursor);
        ReportsList data = new ReportsList.fromJson(result.data);
        yield ReportListLoadedState(
          reports: currentState.reports + data.hacktivityItems.edges,
          cursor: data.hacktivityItems.pageInfo.endCursor,
          nextPage: data.hacktivityItems.pageInfo.hasNextPage,
          totalCount: currentState.totalCount,
          lastFetch: DateTime.now(),
        );
      }
    } else if (event is ReportListRefreshEvent) {
      try {
        if (currentState is ReportListLoadedState) {
          QueryResult result = await reportRepository.fetchReports(1);
          ReportsList data = new ReportsList.fromJson(result.data);
          int diff = 0;
          try {
            diff = data.hacktivityItems.totalCount - currentState.totalCount;
          } catch (_) {
            print("Error");
            diff = 0;
          }
          result = await reportRepository.fetchReports(diff);
          data = new ReportsList.fromJson(result.data);
          reportRepository.saveReportCount(data.hacktivityItems.totalCount);
          yield ReportListLoadedState(
            reports: data.hacktivityItems.edges + currentState.reports,
            cursor: currentState.cursor,
            nextPage: currentState.nextPage,
            totalCount: data.hacktivityItems.totalCount,
            lastFetch: DateTime.now(),
          );
        }
      } catch (e) {
        print(e);
        yield ReportListErrorState();
      }
    }
  }
}
