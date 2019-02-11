class GoogleSearchWidget {
  String name;
  GoogleSearchWidget( String name) {
    this.name = name;
  }
  void searchGoogle() {
    String search = name.replace(' ', '+');//Optimise for searching
    search = search.substring(1, search.length()-1);//^^
    print(search);
    link("http://www.google.com/search?q=" + search);//Create a link
  }
}