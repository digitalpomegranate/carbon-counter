class Challenge {
  String docId;
  String challengeDesc;
  String challengeName;
  String icon;
  int ecoBenefit;
  int finishBenefit;
  int moneyBenefit;
  int startBenefit;

  Challenge.fromMap(map) {
    docId = map['doc_id'];
    icon = map['icon'];
    challengeDesc = map['challenge_desc'];
    challengeName = map['challenge_name'];
    ecoBenefit = map['eco_benefit'];
    finishBenefit = map['finish_benifit'];
    moneyBenefit = map['money_benefit'];
    startBenefit = map['start_benefit'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['doc_id'] = this.docId;
    map['icon'] = this.icon;
    map['challenge_desc'] = this.challengeDesc;
    map['challenge_name'] = this.challengeName;
    map['eco_benefit'] = this.ecoBenefit;
    map['finish_benifit'] = this.finishBenefit;
    map['money_benefit'] = this.moneyBenefit;
    map['start_benefit'] = this.startBenefit;
    return map;
  }
}
