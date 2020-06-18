import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hackerone/models/reports_detail.dart';
import 'package:hackerone/resources/repository.dart';
import 'bloc.dart';

class ReportDetailBloc extends Bloc<ReportDetailEvent, ReportDetailState> {
  ReportRepository reportRepository;

  ReportDetailBloc({@required this.reportRepository});

  @override
  get initialState => ReportDetailInitialState();

  @override
  Stream<ReportDetailState> mapEventToState(event) async* {
    final currentState = state;
    yield ReportDetailLoadingState();
    if (event is ReportDetailLoadEvent) {
      try {
        final res = await reportRepository.fetchReportDetail(event.reportId);
        final ReportsDetail data = ReportsDetail.fromJson(res.data);
        yield ReportDetailLoadedState(reportDetail: data);
      } catch (error) {
        print(error);
        yield ReportDetailErrorState();
      }
    }
  }
}
