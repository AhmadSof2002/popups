class AdModel {
  String? publisherId;
  String? adId;
  String? price;
  String? text;
  String? title;

  AdModel({this.publisherId, this.adId, this.price, this.text, this.title});

  AdModel.fromJson(Map<String, dynamic> json) {
    publisherId = json['publisherId'];
    adId = json['adId'];
    price = json['price'];
    text = json['text'];
    title = json['title'];
  }
  Map<String, dynamic> toMap() {
    return {
      'publisherId': publisherId,
      'adId': adId,
      'price': price,
      'text': text,
      'title': title
    };
  }
}
