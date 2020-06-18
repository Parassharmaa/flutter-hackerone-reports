import 'dart:async';

import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql/client.dart';
import 'graphql_service.dart';
import 'graphql_operation/fetch_reports.dart';
import 'package:dio/dio.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:hackerone/models/reports_list.dart';

class ReportRepository {
  final GraphQLClient client;

  ReportRepository({@required this.client}) : assert(client != null);

  Future<QueryResult> fetchReports(int numOfReports, {cursor}) async {
    GraphQLService graphQLService = GraphQLService(client);
    return await graphQLService.performQuery(fetchReportsQuery, variables: {
      "cursor": cursor,
      "querystring": "",
      "where": {
        "report": {
          "disclosed_at": {"_is_null": false}
        }
      },
      "orderBy": null,
      "secureOrderBy": {
        "latest_disclosable_activity_at": {"_direction": "DESC"}
      },
      "count": numOfReports
    });
  }

  Future<Response> fetchReportDetail(String reportId) async {
    return await Dio().get(
      "https://hackerone.com/reports/$reportId.json",
    );
  }

  newReports() async {
    var res = await fetchReports(1);
    ReportsList d = ReportsList.fromJson(res.data);
    final prefs = await SharedPreferences.getInstance();
    int prevCount = prefs.getInt("reportCount");
    print(prevCount);
    int diff = d.hacktivityItems.totalCount - prevCount;
    return diff;
  }

  void saveReportCount(int count) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("reportCount", count);
    print("Saved report count: $count");
  }
}
