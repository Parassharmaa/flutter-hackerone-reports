class ReportsDetail {
  int id;
  String url;
  String title;
  String state;
  String substate;
  String severityRating;
  String readableSubstate;
  String createdAt;
  Null isMemberOfTeam;
  Reporter reporter;
  Team team;
  String disclosedAt;
  String bugReporterAgreedOnGoingPublicAt;
  String vulnerabilityInformation;
  String vulnerabilityInformationHtml;

  ReportsDetail(
      {this.id,
      this.url,
      this.title,
      this.state,
      this.substate,
      this.severityRating,
      this.readableSubstate,
      this.createdAt,
      this.isMemberOfTeam,
      this.reporter,
      this.team,
      this.disclosedAt,
      this.bugReporterAgreedOnGoingPublicAt,
      this.vulnerabilityInformation,
      this.vulnerabilityInformationHtml});

  ReportsDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    title = json['title'];
    state = json['state'];
    substate = json['substate'];
    severityRating = json['severity_rating'];
    readableSubstate = json['readable_substate'];
    createdAt = json['created_at'];
    isMemberOfTeam = json['is_member_of_team?'];
    reporter = json['reporter'] != null
        ? new Reporter.fromJson(json['reporter'])
        : null;
    team = json['team'] != null ? new Team.fromJson(json['team']) : null;
    disclosedAt = json['disclosed_at'];
    bugReporterAgreedOnGoingPublicAt =
        json['bug_reporter_agreed_on_going_public_at'];
    vulnerabilityInformation = json['vulnerability_information'];
    vulnerabilityInformationHtml = json['vulnerability_information_html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['title'] = this.title;
    data['state'] = this.state;
    data['substate'] = this.substate;
    data['severity_rating'] = this.severityRating;
    data['readable_substate'] = this.readableSubstate;
    data['created_at'] = this.createdAt;
    data['is_member_of_team?'] = this.isMemberOfTeam;
    if (this.reporter != null) {
      data['reporter'] = this.reporter.toJson();
    }
    if (this.team != null) {
      data['team'] = this.team.toJson();
    }
    data['disclosed_at'] = this.disclosedAt;
    data['bug_reporter_agreed_on_going_public_at'] =
        this.bugReporterAgreedOnGoingPublicAt;
    data['vulnerability_information'] = this.vulnerabilityInformation;
    data['vulnerability_information_html'] = this.vulnerabilityInformationHtml;
    return data;
  }
}

class Reporter {
  bool disabled;
  String username;
  String url;
  ProfilePictureUrls profilePictureUrls;
  bool isMe;
  bool cleared;
  bool hackeroneTriager;
  bool hackerMediation;

  Reporter(
      {this.disabled,
      this.username,
      this.url,
      this.profilePictureUrls,
      this.isMe,
      this.cleared,
      this.hackeroneTriager,
      this.hackerMediation});

  Reporter.fromJson(Map<String, dynamic> json) {
    disabled = json['disabled'];
    username = json['username'];
    url = json['url'];
    profilePictureUrls = json['profile_picture_urls'] != null
        ? new ProfilePictureUrls.fromJson(json['profile_picture_urls'])
        : null;
    isMe = json['is_me?'];
    cleared = json['cleared'];
    hackeroneTriager = json['hackerone_triager'];
    hackerMediation = json['hacker_mediation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disabled'] = this.disabled;
    data['username'] = this.username;
    data['url'] = this.url;
    if (this.profilePictureUrls != null) {
      data['profile_picture_urls'] = this.profilePictureUrls.toJson();
    }
    data['is_me?'] = this.isMe;
    data['cleared'] = this.cleared;
    data['hackerone_triager'] = this.hackeroneTriager;
    data['hacker_mediation'] = this.hackerMediation;
    return data;
  }
}

class ProfilePictureUrls {
  String small;

  ProfilePictureUrls({this.small});

  ProfilePictureUrls.fromJson(Map<String, dynamic> json) {
    small = json['small'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    return data;
  }
}

class Team {
  int id;
  String url;
  String handle;
  ProfilePictureUrls profilePictureUrls;
  String submissionState;
  String defaultCurrency;
  bool awardsMiles;
  bool offersBounties;
  String state;
  bool onlyClearedHackers;
  Profile profile;

  Team(
      {this.id,
      this.url,
      this.handle,
      this.profilePictureUrls,
      this.submissionState,
      this.defaultCurrency,
      this.awardsMiles,
      this.offersBounties,
      this.state,
      this.onlyClearedHackers,
      this.profile});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    handle = json['handle'];
    profilePictureUrls = json['profile_picture_urls'] != null
        ? new ProfilePictureUrls.fromJson(json['profile_picture_urls'])
        : null;
    submissionState = json['submission_state'];
    defaultCurrency = json['default_currency'];
    awardsMiles = json['awards_miles'];
    offersBounties = json['offers_bounties'];
    state = json['state'];
    onlyClearedHackers = json['only_cleared_hackers'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['handle'] = this.handle;
    if (this.profilePictureUrls != null) {
      data['profile_picture_urls'] = this.profilePictureUrls.toJson();
    }
    data['submission_state'] = this.submissionState;
    data['default_currency'] = this.defaultCurrency;
    data['awards_miles'] = this.awardsMiles;
    data['offers_bounties'] = this.offersBounties;
    data['state'] = this.state;
    data['only_cleared_hackers'] = this.onlyClearedHackers;
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    return data;
  }
}

class Profile {
  String name;
  String twitterHandle;
  String website;
  String about;

  Profile({this.name, this.twitterHandle, this.website, this.about});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    twitterHandle = json['twitter_handle'];
    website = json['website'];
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['twitter_handle'] = this.twitterHandle;
    data['website'] = this.website;
    data['about'] = this.about;
    return data;
  }
}
