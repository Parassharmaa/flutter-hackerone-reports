import 'package:equatable/equatable.dart';

class ReportDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ReportDetailLoadEvent extends ReportDetailEvent {
  final String reportId;

  ReportDetailLoadEvent(this.reportId) : super();

  @override
  List<Object> get props => [reportId];
}

class ReportDetailRefreshEvent extends ReportDetailEvent {

}