import 'package:flutter/foundation.dart';
import 'package:hackerone/models/reports_detail.dart';
import 'package:equatable/equatable.dart';

class ReportDetailState extends Equatable {
  const ReportDetailState();

  @override
  List<Object> get props => [];
}

class ReportDetailInitialState extends ReportDetailState {}

class ReportDetailLoadingState extends ReportDetailState {}

class ReportDetailLoadedState extends ReportDetailState {
  final ReportsDetail reportDetail;

  ReportDetailLoadedState({@required this.reportDetail});

  @override
  List<Object> get props => [reportDetail];
}

class ReportDetailErrorState extends ReportDetailState {}
