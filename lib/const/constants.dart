import 'package:logger/logger.dart';
import 'package:thesis_project/const/keywords.dart';
import 'package:thesis_project/models/provider.dart';
import 'package:thesis_project/models/provider_dataset.dart';
import 'package:thesis_project/models/working_hour.dart';

import '../models/booking.dart';
import '../models/servie_category.dart';

final Logger logger = Logger();

const String apiKey = "My Api Key";
const String userEmail = "user073@gmail.com";
const String dummyFoodDesc =
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error, harum nesciunt ipsum debitis quas aliquid. ";
List<ServiceCategory> serviceCategoryList = [
  ServiceCategory(name: acRepair, iconUri: "assets/images/ic_ac_repair.png"),
  ServiceCategory(name: cleaning, iconUri: "assets/images/ic_cleaning.png"),
  ServiceCategory(
      name: electronics, iconUri: "assets/images/ic_electronics.png"),
  ServiceCategory(name: paintings, iconUri: "assets/images/ic_painting.png"),
  ServiceCategory(name: shifting, iconUri: "assets/images/ic_shifting.png"),
  ServiceCategory(name: barber, iconUri: "assets/images/ic_barabr.png"),
  ServiceCategory(name: beauty, iconUri: "assets/images/ic_beauty.png"),
  ServiceCategory(name: plumbing, iconUri: "assets/images/ic_plumber.png"),
];

const List<double> ratingsList = [
  0,
  1.2,
  3.2,
  2.1,
  2.3,
  3.4,
  3.8,
  3.9,
  4.0,
  3.0,
  4.5,
  4.6,
  4.2,
  4.8,
  5,
  4.9,
  4.7
];
const List<String> placeNameList = [
  "Chittagong University Road, Chittagong",
  "Chikandandi, Chittagong",
  "Aman Bazaar, N106, Chittagong",
  "Baluchara, Chittagong",
  "1 No Gate, Chittagong University",
  "Jobra, Chittagong University",
  "Rail Gate, Chittagon Univsity",
  "Muradpur, Chittagong",
  "Bahoddarhat, Chittagong",
  "Hathazari Road, Chittagong",
  "Parboti Hing School, Hathazari Road",
  "Shoba Koloni, Jobra Road"
];
List<ServiceProvider> providerList = [
  ServiceProvider(
    name: "Ashraful Islam",
    category: tutor,
    imgUri: "assets/images/provider4.jpeg",
    rating: 5,
    numOfReview: 120,
    serviceFee: 450,
    location: "Chittagong University Road, Chittagong",
    lat: 22.4787345,
    long: 91.7942796,
    phone: "01819682374",
  ),
  ServiceProvider(
    name: "Karimul Haque",
    category: paintings,
    imgUri: "assets/images/provider6.jpeg",
    rating: 4,
    numOfReview: 120,
    location: "Chikandandi, Chittagong",
    serviceFee: 450,
    lat: 22.4481407,
    long: 91.8224547,
    phone: "01819682374",
  ),
  ServiceProvider(
    name: "Ahsan Ullah",
    category: acRepair,
    imgUri: "assets/images/provider2.jpeg",
    rating: 3,
    numOfReview: 120,
    serviceFee: 450,
    location: "Aman Bazaar, N106, Chittagong",
    lat: 22.4213714,
    long: 91.82010129999999,
    phone: "01819682374",
  ),
  ServiceProvider(
    name: "Diponkor Sheik",
    category: shifting,
    imgUri: "assets/images/provider1.jpg",
    rating: 2,
    numOfReview: 120,
    location: "Baluchara, Chittagong",
    serviceFee: 450,
    lat: 22.4090162,
    long: 91.8178341,
    phone: "01819682374",
  ),
  ServiceProvider(
    name: "Shariful Rahman",
    category: shifting,
    imgUri: "assets/images/provider7.jpeg",
    rating: 2,
    numOfReview: 120,
    location: "Jobra, Chittagong",
    serviceFee: 450,
    lat: 22.4875834,
    long: 91.8098954,
    phone: "01819682374",
  ),
  ServiceProvider(
    name: "Maruf Kabir",
    category: shifting,
    imgUri: "assets/images/provider3.jpeg",
    rating: 1,
    numOfReview: 120,
    location: "Baluchora, Chittagong",
    serviceFee: 450,
    lat: 21.4637269,
    long: 91.9915908,
    phone: "01819682374",
  ),
];

List<Booking> bookingList = [
  Booking(
    providerDataSet: ProviderDataset(
        name: "Provider 011",
        category: "Plumbing",
        imgUri: "https://randomuser.me/api/portraits/men/76.jpg",
        rating: 3.0,
        monthlyRating: 6.1,
        numOfReview: 15,
        serviceFee: 450,
        location: "Muradpur, Chittagong",
        lat: 22.478792360818773,
        long: 91.79682897786998,
        phone: "+8801739870424",
        jobs: [
          Jobs(
            consumerName: "Consumer 011",
            workingHour: 2,
            ts: null,
          ),
        ],
        activePeriod: 596,
        liveDistance: 1.2),
    ts: DateTime.now().subtract(const Duration(days: 3)).millisecondsSinceEpoch,
    workingHour: 4,
    bookingStatus: true,
    acceptanceStatus: true,
    rejectanceStatus: false,
  ),
  Booking(
    providerDataSet: ProviderDataset(
        name: "Provider 049",
        category: "Shifting",
        imgUri: "https://randomuser.me/api/portraits/men/53.jpg",
        rating: 3.4,
        monthlyRating: 4.9,
        numOfReview: 10,
        serviceFee: 599,
        location: "Rail Gate, Chittagon Univsity",
        lat: 22.478792360818773,
        long: 91.79682897786998,
        phone: "+8801739870437",
        jobs: [
          Jobs(
            consumerName: "Consumer 011",
            workingHour: 2,
            ts: null,
          ),
        ],
        activePeriod: 596,
        liveDistance: 3.4),
    ts: DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch,
    workingHour: 2,
    bookingStatus: true,
    acceptanceStatus: true,
    rejectanceStatus: false,
  ),
  Booking(
    providerDataSet: ProviderDataset(
        name: "Provider 061",
        category: "Painting",
        imgUri: "https://randomuser.me/api/portraits/men/73.jpg",
        rating: 3.8,
        monthlyRating: 4.1,
        numOfReview: 11,
        serviceFee: 250,
        location: "Jobra, Chittagong Univsity",
        lat: 22.478792360818773,
        long: 91.79682897786998,
        phone: "+8801739870437",
        jobs: [
          Jobs(
            consumerName: "Consumer 011",
            workingHour: 2,
            ts: null,
          ),
        ],
        activePeriod: 596,
        liveDistance: 1.2),
    ts: DateTime.now().subtract(const Duration(days: 2)).millisecondsSinceEpoch,
    workingHour: 3,
    bookingStatus: false,
    acceptanceStatus: false,
    rejectanceStatus: false,
  ),
/*   Booking(
    serviceCategory: cleaning,
    serviceFee: 350,
    schedule: "3 hours, 02 Jul",
    workingHour: 4,
    status: true,
    providerName: "Karimul Haque",
    providerAddress: "Baluchora, Chittagong",
    providerImgUrl: "assets/images/provider6.jpeg",
  ),
  Booking(
    serviceCategory: shifting,
    serviceFee: 450,
    schedule: "1 hour, 13 Aug",
    workingHour: 1,
    status: true,
    providerName: "Ahsan Ullah",
    providerAddress: "Chowdhuryhat, Chittagong, Bangladesh",
    providerImgUrl: "assets/images/provider1.jpg",
  ), */
];

List<WorkingHour> workingHourList = [
  WorkingHour(quantity: 1, matrix: "h"),
  WorkingHour(quantity: 2, matrix: "h"),
  WorkingHour(quantity: 3, matrix: "h"),
  WorkingHour(quantity: 4, matrix: "h"),
  WorkingHour(quantity: 5, matrix: "h"),
  WorkingHour(quantity: 6, matrix: "h"),
  WorkingHour(quantity: 7, matrix: "h"),
  WorkingHour(quantity: 8, matrix: "h"),
];
