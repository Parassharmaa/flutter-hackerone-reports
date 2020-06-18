class ReportsList {
  HacktivityItems hacktivityItems;

  ReportsList({this.hacktivityItems});

  ReportsList.fromJson(Map<String, dynamic> json) {
    hacktivityItems = json['hacktivity_items'] != null
        ? new HacktivityItems.fromJson(json['hacktivity_items'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hacktivityItems != null) {
      data['hacktivity_items'] = this.hacktivityItems.toJson();
    }
    return data;
  }
}

class HacktivityItems {
  int totalCount;
  PageInfo pageInfo;
  List<Edges> edges;

  HacktivityItems({this.totalCount, this.pageInfo, this.edges});

  HacktivityItems.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    pageInfo = json['pageInfo'] != null
        ? new PageInfo.fromJson(json['pageInfo'])
        : null;
    if (json['edges'] != null) {
      edges = new List<Edges>();
      json['edges'].forEach((v) {
        edges.add(new Edges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo.toJson();
    }
    if (this.edges != null) {
      data['edges'] = this.edges.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PageInfo {
  String endCursor;
  bool hasNextPage;

  PageInfo({this.endCursor, this.hasNextPage});

  PageInfo.fromJson(Map<String, dynamic> json) {
    endCursor = json['endCursor'];
    hasNextPage = json['hasNextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['endCursor'] = this.endCursor;
    data['hasNextPage'] = this.hasNextPage;
    return data;
  }
}

class Edges {
  Node node;

  Edges({this.node});

  Edges.fromJson(Map<String, dynamic> json) {
    node = json['node'] != null ? new Node.fromJson(json['node']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.node != null) {
      data['node'] = this.node.toJson();
    }
    return data;
  }
}

class Node {
  String id;
  String databaseId;
  String type;
  Votes votes;
  Reporter reporter;
  Team team;
  Report report;
  String latestDisclosableAction;
  String latestDisclosableActivityAt;
  double totalAwardedAmount;
  String severityRating;
  String currency;

  Node(
      {this.id,
      this.databaseId,
      this.type,
      this.votes,
      this.reporter,
      this.team,
      this.report,
      this.latestDisclosableAction,
      this.latestDisclosableActivityAt,
      this.totalAwardedAmount,
      this.severityRating,
      this.currency});

  Node.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    databaseId = json['databaseId'];
    type = json['type'];
    votes = json['votes'] != null ? new Votes.fromJson(json['votes']) : null;
    reporter = json['reporter'] != null
        ? new Reporter.fromJson(json['reporter'])
        : new Reporter(id: null, username: "Someone");
    team = json['team'] != null ? new Team.fromJson(json['team']) : null;
    report =
        json['report'] != null ? new Report.fromJson(json['report']) : null;
    latestDisclosableAction = json['latest_disclosable_action'];
    latestDisclosableActivityAt = json['latest_disclosable_activity_at'];
    totalAwardedAmount = json['total_awarded_amount'];
    severityRating = json['severity_rating'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['databaseId'] = this.databaseId;
    data['type'] = this.type;
    if (this.votes != null) {
      data['votes'] = this.votes.toJson();
    }
    if (this.reporter != null) {
      data['reporter'] = this.reporter.toJson();
    }
    if (this.team != null) {
      data['team'] = this.team.toJson();
    }
    if (this.report != null) {
      data['report'] = this.report.toJson();
    }
    data['latest_disclosable_action'] = this.latestDisclosableAction;
    data['latest_disclosable_activity_at'] = this.latestDisclosableActivityAt;
    data['total_awarded_amount'] = this.totalAwardedAmount;
    data['severity_rating'] = this.severityRating;
    data['currency'] = this.currency;
    return data;
  }
}

class Votes {
  int totalCount;

  Votes({this.totalCount});

  Votes.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    return data;
  }
}

class Reporter {
  String id;
  String username;

  Reporter({this.id, this.username: "Someone"});

  Reporter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    return data;
  }
}

class Team {
  String handle;
  String name;
  String mediumProfilePicture;
  String url;
  String id;

  Team({this.handle, this.name, this.mediumProfilePicture, this.url, this.id});

  Team.fromJson(Map<String, dynamic> json) {
    handle = json['handle'];
    name = json['name'];
    mediumProfilePicture = json['medium_profile_picture'];
    url = json['url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['handle'] = this.handle;
    data['name'] = this.name;
    data['medium_profile_picture'] = this.mediumProfilePicture;
    data['url'] = this.url;
    data['id'] = this.id;
    return data;
  }
}

class Report {
  String id;
  String title;
  String substate;
  String url;

  Report({this.id, this.title, this.substate, this.url});

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    substate = json['substate'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['substate'] = this.substate;
    data['url'] = this.url;
    return data;
  }
}
