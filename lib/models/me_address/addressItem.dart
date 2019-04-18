import 'package:flutter/material.dart';

class AddressItem {
  const AddressItem({
    @required this.id,
    @required this.name,
    @required this.phone,
    @required this.region,
    @required this.detailAddress
  });
  final String id;
  final String name;
  final String phone;
  final String region;
  final String detailAddress;
}