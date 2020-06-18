import 'package:flutter/material.dart';
import 'package:hackerone/models/reports_list.dart';

class ReportTileWidget extends StatelessWidget {
  final Edges reportEdge;

  const ReportTileWidget({Key key, @required this.reportEdge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const Icon(
                  Icons.keyboard_arrow_up,
                  size: 16.0,
                ),
                Text("${reportEdge.node.votes.totalCount}"),
                SizedBox(height: 10),
                Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          reportEdge.node.team.mediumProfilePicture),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(reportEdge.node.report.title,
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 10),
                Text(
                  """From ${reportEdge.node.reporter.username} to ${reportEdge.node.team.name} \nBounty: ${reportEdge.node.totalAwardedAmount} ${reportEdge.node.currency}""",
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
