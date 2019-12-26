import 'package:flutter/material.dart' show required, Color, LinearGradient, Colors, Alignment;

class AppCategory {
  String name;
  String image;
  Color color;
  LinearGradient gradient;
  String assetName;

  AppCategory({
    @required this.name,
    this.image,
    @required this.color,
    this.gradient,
    @required this.assetName,
  });
}

List<AppCategory> genres = [
  AppCategory(
    name: "Blues",
    color: Colors.blue,
    assetName: "blues",
    image: "https://www.earwigmusic.com/sites/www.earwigmusic.com/files/assets/Honeboy%20Edwards%20Blues%20Band%201976.PNG"
  ),
  AppCategory(
    name: "Classic",
    color: Colors.cyan,
    assetName: "classic",
    image: "https://cdn-images.audioaddict.com/4/3/e/0/a/2/43e0a23fa2e30d0e3da528f4de5b2ec2.png"
  ),
  AppCategory(
    name: "Country",
    color: Colors.teal,
    assetName: "country",
    image: "http://d279m997dpfwgl.cloudfront.net/wp/2019/03/ap-guitar-1129349_1920-1000x666.jpg"
  ),
  AppCategory(
    name: "Easy Listening",
    color: Colors.amber,
    assetName: "easylistening",
    image: "https://is2-ssl.mzstatic.com/image/thumb/Purple118/v4/38/41/8e/38418e4a-3fc5-dadd-454b-d91f69149777/source/512x512bb.jpg"
  ),
  AppCategory(
    name: "Gospel",
    color: Colors.brown,
    assetName: "gospel",
    image: "https://images.fastcompany.com/upload/gospel-choir.jpg"
  ),
  AppCategory(
    name: "House",
    color: Colors.black,
    assetName: "house",
    image: "https://edmidentity.com/wp-content/uploads/2019/12/75640747_2810523328972593_709692609215332352_o-696x464.jpg"
  ),
  AppCategory(
    name: "Jazz",
    color: Colors.deepOrange,
    assetName: "jazz",
    image: "https://cdn-images.audioaddict.com/1/3/b/0/6/b/13b06bc7019bcfe07da6c3f403674c82.png"
  ),
  AppCategory(
    name: "Rap",
    color: Colors.deepPurple,
    assetName: "rap",
    image: "https://images.fineartamerica.com/images/artworkimages/mediumlarge/2/rap-music-legends-cindy-majalca-madrid.jpg"
  ),
  AppCategory(
    name: "Reggae",
    color: Colors.lime,
    assetName: "reggae",
    image: "https://ichef.bbci.co.uk/news/410/cpsprodpb/6C73/production/_104536772_bob_getty.jpg"
  ),
  AppCategory(
    name: "Rock",
    color: Colors.indigo,
    assetName: "rock",
    image: "https://www.liveabout.com/thmb/C_cBVWMY7lQWxUm40VhYNV4uPDs=/768x0/filters:no_upscale():max_bytes(150000):strip_icc()/bon-jovi-jon-bon-jovi-richie-sambora-and-hugh-mcdonald-live-at-nakano-sun-plaza-593352577-5b560a3946e0fb0037dd45a7.jpg"
  ),
  AppCategory(
    name: "Sports",
    color: Colors.yellow,
    assetName: "sports",
    image: "https://cdn.pixabay.com/photo/2015/03/01/22/27/relay-race-655353_1280.jpg"
  ),
];

List<AppCategory> decades = [
  AppCategory(
    name: "2000s",
    color: Color(0xFFFDB930),
    assetName: "00s",
    image: "https://www.billboard.com/files/media/1999-Early-2000s-Nostalgia-art-fea-2019-billboard-1500.jpg"
  ),
  AppCategory(
    name: "90s",
    color: Color(0xFF000000),
    assetName: "90s",
    image: "https://previews.123rf.com/images/vasylbonchuk/vasylbonchuk1805/vasylbonchuk180500102/102497798-retro-style-club-background-fashion-pop-music-of-the-90s-and-80s-the-old-night-easy-editable-design-.jpg"
  ),
  AppCategory(
    name: "80s",
    color: Color(0xFF324C7F),
    assetName: "80s",
    image: "https://i1.wp.com/top40weekly.com/wp-content/uploads/2018/10/the-go-gos-1980s.jpg?w=750&ssl=1"
  ),
  AppCategory(
    name: "70s",
    color: Color(0xFF007310),
    assetName: "70s",
    image: "https://i.pinimg.com/originals/a6/3b/36/a63b364c75b089244458d9fa1c72ae84.jpg"
  ),
];

List<AppCategory> countries = [
  AppCategory(
    name: "Germany",
    color: Color(0xFFFDB930),
    assetName: "germany",
    gradient: LinearGradient(
      colors: [
        Color(0xFF000000),
        Color(0xFFC51230),
        Color(0xFFFDB930)
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    image: "https://libertyflagandbanner.com/wp-content/uploads/2015/08/germany-flag-700x467.jpg"
  ),
  AppCategory(
    name: "Ghana",
    color: Color(0xFF000000),
    assetName: "ghana",
    gradient: LinearGradient(
      colors: [
        Color(0xFFC51230),
        Colors.yellow,
        Color(0xFF00683D)
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    image: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag_of_Ghana.svg/255px-Flag_of_Ghana.svg.png"
  ),
  AppCategory(
    name: "Italy",
    color: Color(0xFF324C7F),
    assetName: "italy",
    gradient: LinearGradient(
      colors: [
        Color(0xFF324C7F),
        Colors.white,
      ],
      stops: [
        0.8,
        1,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    image: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Flag_of_Italy_%281861-1946%29_crowned.svg/255px-Flag_of_Italy_%281861-1946%29_crowned.svg.png"
  ),
  AppCategory(
    name: "Kenya",
    color: Color(0xFF007310),
    assetName: "kenya",
    gradient: LinearGradient(
      colors: [
        Color(0xFF000000),
        Color(0xFF840008),
        Colors.white,
        Color(0xFF007310)
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    image: "https://cdn.britannica.com/15/15-004-9057917D/Flag-Kenya.jpg"
  ),
  AppCategory(
    name: "Mexico",
    color: Color(0xFF008850),
    assetName: "mexico",
    gradient: LinearGradient(
      colors: [
        Color(0xFF00713D),
        Colors.white,
        Color(0xFFB10738)
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    image: "https://images-na.ssl-images-amazon.com/images/I/61sIDOD1ajL._SX466_.jpg"
  ),
  AppCategory(
    name: "Nigeria",
    color: Colors.green,
    assetName: "naija",
    gradient: LinearGradient(
      colors: [
        Colors.green,
        Colors.white,
        Colors.green
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    image: "https://s3.amazonaws.com/images.wpr.com/flag-pages/png250/ng.png"
  ),
  AppCategory(
    name: "USA",
    color: Color(0xFF002768),
    assetName: "usa",
    gradient: LinearGradient(
      colors: [
        Color(0xFF002768),
        Colors.white,
        Color(0xFFBF0B30),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    image: "https://cdn.britannica.com/33/4833-004-297297B9/Flag-United-States-of-America.jpg"
  ),
];

