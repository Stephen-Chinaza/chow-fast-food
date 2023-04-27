import 'package:chow/res/enum.dart';

import '../../res/app_images.dart';

class MealData {
  final String image;
  final String restaurantName;
  final String timeStamp;
  final String currency;
  final String name;
  final String amount;
  final DeliveryStatus status;
  final String? username;

  MealData({
    required this.image,
    required this.restaurantName,
    required this.timeStamp,
    required this.name,
    required this.amount,
    required this.status,
    required this.currency,
    this.username,
  });
}

//fake list data
List<MealData> mealList = [
  MealData(
    image: AppImages.food1,
    restaurantName: 'Chizzy\'s Food',
    timeStamp: '18 May | 12:20',
    name: 'Jellof Rice and Chicken',
    username: 'Elechi Blessing',
    amount: '2,000',
    currency: 'NGN',
    status: DeliveryStatus.pending,
  ),
  MealData(
      image: AppImages.food1,
      restaurantName: 'Chizzy\'s Food',
      timeStamp: '18 May | 12:20',
      name: 'Jellof Rice and Chicken',
      username: 'Elechi Blessing',
      currency: 'NGN',
      amount: '2,300',
      status: DeliveryStatus.delivered),
  MealData(
      image: AppImages.food1,
      restaurantName: 'Chizzy\'s Food',
      timeStamp: '18 May | 12:20',
      username: 'Elechi Blessing',
      name: 'Jellof Rice and Chicken',
      amount: '2,500',
      currency: 'NGN',
      status: DeliveryStatus.delivered),
  MealData(
      image: AppImages.food1,
      restaurantName: 'Chizzy\'s Food',
      timeStamp: '18 May | 12:20',
      username: 'Elechi Blessing',
      name: 'Jellof Rice and Chicken',
      amount: '2,600',
      currency: 'NGN',
      status: DeliveryStatus.delivered),
  MealData(
      image: AppImages.food1,
      restaurantName: 'Chizzy\'s Food',
      timeStamp: '18 May | 12:20',
      username: 'Elechi Blessing',
      name: 'Jellof Rice and Chicken',
      amount: '2,500',
      currency: 'NGN',
      status: DeliveryStatus.delivered),
  MealData(
      image: AppImages.food1,
      restaurantName: 'Chizzy\'s Food',
      timeStamp: '18 May | 12:20',
      username: 'Elechi Blessing',
      name: 'Jellof Rice and Chicken',
      amount: '2,300',
      currency: 'NGN',
      status: DeliveryStatus.delivered),
  MealData(
      image: AppImages.food1,
      restaurantName: 'Chizzy\'s Food',
      timeStamp: '18 May | 12:20',
      username: 'Elechi Blessing',
      name: 'Jellof Rice and Chicken',
      amount: '2,300',
      currency: 'NGN',
      status: DeliveryStatus.delivered),
  MealData(
      image: AppImages.food1,
      restaurantName: 'Chizzy\'s Food',
      timeStamp: '18 May | 12:20',
      username: 'Elechi Blessing',
      name: 'Jellof Rice and Chicken',
      amount: '2,300',
      currency: 'NGN',
      status: DeliveryStatus.pending),
];

List<MealData> requestedList = [
  MealData(
      image: AppImages.food1,
      restaurantName: 'Chizzy\'s Food',
      timeStamp: '18 May | 12:20',
      name: 'Jellof Rice and Chicken',
      username: 'Elechi Blessing',
      amount: '2,000',
      currency: 'NGN',
      status: DeliveryStatus.requested),
  MealData(
      image: AppImages.food1,
      restaurantName: 'Chizzy\'s Food',
      timeStamp: '18 May | 12:20',
      name: 'Jellof Rice and Chicken',
      username: 'Elechi Blessing',
      amount: '2,000',
      currency: 'NGN',
      status: DeliveryStatus.requested),
  MealData(
      image: AppImages.food1,
      restaurantName: 'Chizzy\'s Food',
      timeStamp: '18 May | 12:20',
      name: 'Jellof Rice and Chicken',
      username: 'Elechi Blessing',
      amount: '2,000',
      currency: 'NGN',
      status: DeliveryStatus.requested),
  MealData(
      image: AppImages.food1,
      restaurantName: 'Chizzy\'s Food',
      timeStamp: '18 May | 12:20',
      name: 'Jellof Rice and Chicken',
      username: 'Elechi Blessing',
      amount: '2,000',
      currency: 'NGN',
      status: DeliveryStatus.requested),
  MealData(
      image: AppImages.food1,
      restaurantName: 'Chizzy\'s Food',
      timeStamp: '18 May | 12:20',
      name: 'Jellof Rice and Chicken',
      username: 'Elechi Blessing',
      amount: '2,000',
      currency: 'NGN',
      status: DeliveryStatus.requested),
  MealData(
      image: AppImages.food1,
      restaurantName: 'Chizzy\'s Food',
      timeStamp: '18 May | 12:20',
      name: 'Jellof Rice and Chicken',
      username: 'Elechi Blessing',
      amount: '2,000',
      currency: 'NGN',
      status: DeliveryStatus.requested),
  MealData(
      image: AppImages.food1,
      restaurantName: 'Chizzy\'s Food',
      timeStamp: '18 May | 12:20',
      name: 'Jellof Rice and Chicken',
      username: 'Elechi Blessing',
      amount: '2,000',
      currency: 'NGN',
      status: DeliveryStatus.requested),
  MealData(
      image: AppImages.food1,
      restaurantName: 'Chizzy\'s Food',
      timeStamp: '18 May | 12:20',
      name: 'Jellof Rice and Chicken',
      username: 'Elechi Blessing',
      amount: '2,000',
      currency: 'NGN',
      status: DeliveryStatus.requested),
  MealData(
      image: AppImages.food1,
      restaurantName: 'Chizzy\'s Food',
      timeStamp: '18 May | 12:20',
      name: 'Jellof Rice and Chicken',
      username: 'Elechi Blessing',
      amount: '2,000',
      currency: 'NGN',
      status: DeliveryStatus.requested),
];
