import 'package:logger/logger.dart';
import 'package:thesis_project/const/keywords.dart';
import 'package:thesis_project/models/provider.dart';

import '../models/booking.dart';
import '../models/servie_category.dart';

final Logger logger = Logger();
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
      rating: 4.8,
      numOfReview: 120,
      serviceFee: 450,
      location: "Chowdhuryhat, Chittagong"),
  ServiceProvider(
    name: "Ashraful Islam",
    category: cleaning,
    imgUri: "assets/images/provider2.jpeg",
    rating: 3.5,
    numOfReview: 120,
    location: "Baluchora, Chittagong",
    serviceFee: 450,
  ),
];

List<Booking> bookingList = [
  Booking(
    serviceCategory: acRepair,
    serviceFee: 450,
    schedule: "8:00 AM - 10:00 AM, 08 Nov",
    status: false,
  ),
  Booking(
    serviceCategory: cleaning,
    serviceFee: 350,
    schedule: "10:00 AM - 1:00 PM, 02 Jul",
    status: true,
  ),
  Booking(
    serviceCategory: shifting,
    serviceFee: 450,
    schedule: "8:00 AM - 10:00 AM, 08",
    status: true,
  ),
];
