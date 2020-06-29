class Plan {
  String planId;
  String content;
  String title;
  String image;

  Plan({this.planId, this.content, this.title, this.image});

  Plan.fromJson(Map<String, dynamic> json) {
    planId = json['planId'];
    content = json['content'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['planId'] = this.planId;
    data['content'] = this.content;
    data['title'] = this.title;
    data['image'] = this.image;
    return data;
  }
}