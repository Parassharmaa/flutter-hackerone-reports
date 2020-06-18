import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackerone/resources/repository.dart';
import 'package:hackerone/ui/widget/bottom_loader.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ReportDetail extends StatelessWidget {
  final String reportTitle;
  final String reportId;

  ReportDetail({Key key, @required this.reportTitle, @required this.reportId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Report #$reportId"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.open_in_new),
            onPressed: () {
              launch("https://hackerone.com/reports/$reportId");
            },
          )
        ],
      ),
      body: BlocProvider<ReportDetailBloc>(
        create: (context) => ReportDetailBloc(
            reportRepository: context.repository<ReportRepository>())
          ..add(ReportDetailLoadEvent(reportId)),
        child: BlocBuilder<ReportDetailBloc, ReportDetailState>(
            builder: (BuildContext context, ReportDetailState state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    reportTitle,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                if (state is ReportDetailLoadedState)
                  Padding(
                      padding: EdgeInsets.all(16),
                      child: MarkdownBody(
                        data: state.reportDetail.vulnerabilityInformation,
                      ))
                else if (state is ReportDetailLoadingState)
                  Center(
                    child: BottomLoader(),
                  )
                else if (state is ReportDetailErrorState)
                  Text("Cannot Load Report")
              ],
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.share),
        tooltip: "Share",
        onPressed: () {
          Share.share(
              "$reportTitle \n---\nCheck out at https://hackerone.com/reports/$reportId",
              subject: "Hackerone: $reportTitle");
        },
      ),
    );
  }
}
