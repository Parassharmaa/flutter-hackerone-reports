import 'package:equatable/equatable.dart';

class ReportListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ReportListLoadEvent extends ReportListEvent {
  final int numOfReports;
  final String cursor;

  ReportListLoadEvent(this.numOfReports, {this.cursor}) : super();

  @override
  List<Object> get props => [numOfReports, cursor];
}

class ReportListLoadMoreEvent extends ReportListEvent {
  final int numOfReports;
  final String cursor;

  ReportListLoadMoreEvent(this.numOfReports, {this.cursor}) : super();

  @override
  List<Object> get props => [numOfReports, cursor];
}

class ReportListRefreshEvent extends ReportListEvent {}
