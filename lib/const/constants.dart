import 'package:thesis_project/const/keywords.dart';
import 'package:thesis_project/models/provider.dart';

import '../models/servie_category.dart';

const String apiKey = "My Api Key";
const String dummyFoodDesc =
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error, harum nesciunt ipsum debitis quas aliquid. ";
List<ServiceCategory> serviceCategoryList = [
  ServiceCategory(name: acRepair, iconUri: "assets/images/ic_ac_repair.png"),
  ServiceCategory(name: cleaning, iconUri: "assets/images/ic_cleaning.png"),
  ServiceCategory(
      name: electronics, iconUri: "assets/images/ic_electronics.png"),
  ServiceCategory(name: paintings, iconUri: "assets/images/ic_painting.png"),
  ServiceCategory(name: shifting, iconUri: "assets/images/ic_shifting.png"),
  ServiceCategory(name: tutor, iconUri: "assets/images/ic_tutor.png"),
  ServiceCategory(name: barber, iconUri: "assets/images/ic_barabr.png"),
  ServiceCategory(name: beauty, iconUri: "assets/images/ic_beauty.png"),
  ServiceCategory(name: plumbing, iconUri: "assets/images/ic_plumber.png"),
];

List<ServiceProvider> providerList = [
  ServiceProvider(
    name: "Ashraful Islam",
    category: cleaning,
    imgUri: "assets/images/provider1.jpg",
    rating: 4,
    numOfReview: 120,
    serviceFee: 450
  ), ServiceProvider(
    name: "Ashraful Islam",
    category: cleaning,
    imgUri: "assets/images/provider2.jpeg",
    rating: 4,
    numOfReview: 120,
    serviceFee: 450
  ),
];
