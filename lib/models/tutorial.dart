class Tutorial {
  String id;
  String title;
  String content;
  String photo;

  Tutorial(this.id, this.title, this.content, this.photo);

  Tutorial.fromJson(var value) {
    this.id = value['id'];
    this.title = value['title'];
    this.content = value['content'];
    this.photo = value['photo'];
  }
}
