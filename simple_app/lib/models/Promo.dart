class Promo {
  String? key;
  String? image;
  String? text;
  String? link;
  String? buttonText;
  String? buttonColor;
  bool? euroAvailable;
  int? dieDate;

  Promo(
      {this.key,
        this.image,
        this.text,
        this.link,
        this.buttonText,
        this.buttonColor,
        this.euroAvailable,
        this.dieDate});

  Promo.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    image = json['image'];
    text = json['text'];
    link = json['link'];
    buttonText = json['button_text'];
    buttonColor = json['button_color'];
    euroAvailable = json['euro_available'];
    dieDate = json['die_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['image'] = this.image;
    data['text'] = this.text;
    data['link'] = this.link;
    data['button_text'] = this.buttonText;
    data['button_color'] = this.buttonColor;
    data['euro_available'] = this.euroAvailable;
    data['die_date'] = this.dieDate;
    return data;
  }
}
