import 'package:flutter/material.dart' show required;

class AppCategory {
  String name;
  String image;
  int count;
  String assetName;

  AppCategory({
    @required this.name,
    this.image,
    @required this.count,
    @required this.assetName,
  });
}

List<AppCategory> genres = [
  AppCategory(
    name: "Blues",
    count: 200,
    assetName: "blues",
    image: "https://www.earwigmusic.com/sites/www.earwigmusic.com/files/assets/Honeboy%20Edwards%20Blues%20Band%201976.PNG"
  ),
  AppCategory(
    name: "Classic",
    count: 1380,
    assetName: "classic",
    image: "https://cdn-images.audioaddict.com/4/3/e/0/a/2/43e0a23fa2e30d0e3da528f4de5b2ec2.png"
  ),
  AppCategory(
    name: "Country",
    count: 200,
    assetName: "country",
    image: "http://d279m997dpfwgl.cloudfront.net/wp/2019/03/ap-guitar-1129349_1920-1000x666.jpg"
  ),
  AppCategory(
    name: "Easy Listening",
    count: 200,
    assetName: "easylistening",
    image: "https://is2-ssl.mzstatic.com/image/thumb/Purple118/v4/38/41/8e/38418e4a-3fc5-dadd-454b-d91f69149777/source/512x512bb.jpg"
  ),
  AppCategory(
    name: "Gospel",
    count: 200,
    assetName: "gospel",
    image: "https://images.fastcompany.com/upload/gospel-choir.jpg"
  ),
  AppCategory(
    name: "House",
    count: 1756,
    assetName: "house",
    image: "https://edmidentity.com/wp-content/uploads/2019/12/75640747_2810523328972593_709692609215332352_o-696x464.jpg"
  ),
  AppCategory(
    name: "Jazz",
    count: 200,
    assetName: "jazz",
    image: "https://cdn-images.audioaddict.com/1/3/b/0/6/b/13b06bc7019bcfe07da6c3f403674c82.png"
  ),
  AppCategory(
    name: "Rap",
    count: 794,
    assetName: "rap",
    image: "https://images.fineartamerica.com/images/artworkimages/mediumlarge/2/rap-music-legends-cindy-majalca-madrid.jpg"
  ),
  AppCategory(
    name: "Reggae",
    count: 444,
    assetName: "reggae",
    image: "https://ichef.bbci.co.uk/news/410/cpsprodpb/6C73/production/_104536772_bob_getty.jpg"
  ),
  AppCategory(
    name: "Rock",
    count: 1816,
    assetName: "rock",
    image: "https://www.liveabout.com/thmb/C_cBVWMY7lQWxUm40VhYNV4uPDs=/768x0/filters:no_upscale():max_bytes(150000):strip_icc()/bon-jovi-jon-bon-jovi-richie-sambora-and-hugh-mcdonald-live-at-nakano-sun-plaza-593352577-5b560a3946e0fb0037dd45a7.jpg"
  ),
  AppCategory(
    name: "Sports",
    count: 200,
    assetName: "sports",
    image: "https://cdn.pixabay.com/photo/2015/03/01/22/27/relay-race-655353_1280.jpg"
  ),
];

List<AppCategory> decades = [
  AppCategory(
    name: "2000s",
    count: 200,
    assetName: "00s",
    image: "https://www.billboard.com/files/media/1999-Early-2000s-Nostalgia-art-fea-2019-billboard-1500.jpg"
  ),
  AppCategory(
    name: "90s",
    count: 200,
    assetName: "90s",
    image: "https://previews.123rf.com/images/vasylbonchuk/vasylbonchuk1805/vasylbonchuk180500102/102497798-retro-style-club-background-fashion-pop-music-of-the-90s-and-80s-the-old-night-easy-editable-design-.jpg"
  ),
  AppCategory(
    name: "80s",
    count: 200,
    assetName: "80s",
    image: "https://i1.wp.com/top40weekly.com/wp-content/uploads/2018/10/the-go-gos-1980s.jpg?w=750&ssl=1"
  ),
  AppCategory(
    name: "70s",
    count: 200,
    assetName: "70s",
    image: "https://i.pinimg.com/originals/a6/3b/36/a63b364c75b089244458d9fa1c72ae84.jpg"
  ),
  AppCategory(
    name: "60s",
    count: 200,
    assetName: "60s",
    image: "https://www.biography.com/.image/ar_16:9%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cg_faces:center%2Cq_auto:good%2Cw_768/MTYyODMzOTY2NTkwNjAxMDU3/beatles_muhammad-ali_ap_1201040174644_feature.jpg"
  ),
  AppCategory(
    name: "50s",
    count: 22,
    assetName: "50s",
    image: "https://enmoreaudio.com/wp-content/uploads/2017/10/ElvisPresley.jpg"
  ),
  AppCategory(
    name: "40s",
    count: 5,
    assetName: "40s",
    image: "https://ca-times.brightspotcdn.com/dims4/default/7d7fefc/2147483647/strip/true/crop/1883x1059+0+0/resize/840x472!/quality/90/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2F29%2Ff7%2F430080afa969a40a06f20404c77a%2Fla-1467748124-snap-photo"
  ),
  AppCategory(
    name: "30s",
    count: 13,
    assetName: "30s",
    image: "https://a57.foxnews.com/static.foxnews.com/foxnews.com/content/uploads/2019/12/931/524/GettyImages-3203616_Main.jpg?ve=1&tl=1"
  ),
];

List<AppCategory> countries = [
  AppCategory(
    name: "Germany",
    count: 30,
    assetName: "germany",
    image: "https://germanculture.com.ua/wp-content/uploads/2016/08/brandenburg-gate-in-berlin-at-night-germany-1600x1133-e1471561315670.jpg"
  ),
  AppCategory(
    name: "Ghana",
    count: 42,
    assetName: "ghana",
    image: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Independence_Arch_-_Accra%2C_Ghana1.jpg/640px-Independence_Arch_-_Accra%2C_Ghana1.jpg"
  ),
  AppCategory(
    name: "Italy",
    count: 63,
    assetName: "italy",
    image: "https://www.worldatlas.com/r/w728-h425-c728x425/upload/3f/45/19/shutterstock-213169732.jpg"
  ),
  AppCategory(
    name: "Kenya",
    count: 24,
    assetName: "kenya",
    image: "https://www.planetware.com/photos-large/KEN/kenya-amboseli.jpg"
  ),
  AppCategory(
    name: "Mexico",
    count: 51,
    assetName: "mexico",
    image: "https://i.pinimg.com/originals/50/97/73/509773298d981041f57769ea6e1ea927.jpg"
  ),
  AppCategory(
    name: "Nigeria",
    count: 11,
    assetName: "naija",
    image: "https://buzznigeria.com/wp-content/uploads/2014/10/National-Arts-Theatre.jpg"
  ),
  AppCategory(
    name: "USA",
    count: 200,
    assetName: "usa",
    image: "https://s3.amazonaws.com/tinycards/image/6ab0fdef2c1f94fdab57eae39cf78ad5"
  ),
];

