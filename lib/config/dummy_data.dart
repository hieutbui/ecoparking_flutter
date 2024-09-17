import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/model/parking/shift_price.dart';
import 'package:flutter/material.dart';

class DummyData {
  static List<Parking> parkings = [
    Parking(
      id: '1',
      parkingName: 'Bãi đỗ xe Ô tô đình Giáp Tứ',
      image: 'https://i.ibb.co/zfDshWW/parking.png',
      address:
          '33 Ngách 143/74 Phố Nguyễn Chính, Thịnh Liệt, Hoàng Mai, Hà Nội, Việt Nam',
      latitude: 20.976443052910625,
      longitude: 105.85115051042895,
      totalSlot: 15,
      availableSlot: 5,
      pricePerDay: 100000.0,
      pricePerMonth: 2000000000.0,
      pricePerYear: 30000000000.0,
      pricePerHour: [
        ShiftPrice(
          id: '1',
          shiftType: ShiftType.morning,
          startTime: const TimeOfDay(hour: 6, minute: 0),
          endTime: const TimeOfDay(hour: 17, minute: 0),
          price: 20000.0,
        ),
        ShiftPrice(
          id: '2',
          shiftType: ShiftType.afternoon,
          startTime: const TimeOfDay(hour: 17, minute: 0),
          endTime: const TimeOfDay(hour: 22, minute: 0),
          price: 30000.0,
        ),
        ShiftPrice(
          id: '3',
          shiftType: ShiftType.night,
          startTime: const TimeOfDay(hour: 22, minute: 0),
          endTime: const TimeOfDay(hour: 6, minute: 0),
          price: 40000.0,
        ),
      ],
    ),
    Parking(
      id: '2',
      parkingName: 'Bãi gửi xe Thịnh Liệt',
      image: 'https://i.ibb.co/zfDshWW/parking.png',
      address:
          'P304, Tòa nhà N 6, Khu chung cư, Đồng Tàu, Hoàng Mai, Hà Nội, Việt Nam',
      latitude: 20.971450581582122,
      longitude: 105.84827587004936,
      totalSlot: 15,
      availableSlot: 5,
      pricePerDay: 100000.0,
      pricePerMonth: 2000000000.0,
      pricePerYear: 30000000000.0,
      pricePerHour: [
        ShiftPrice(
          id: '1',
          shiftType: ShiftType.morning,
          startTime: const TimeOfDay(hour: 6, minute: 0),
          endTime: const TimeOfDay(hour: 17, minute: 0),
          price: 30000.0,
        ),
        ShiftPrice(
          id: '2',
          shiftType: ShiftType.afternoon,
          startTime: const TimeOfDay(hour: 17, minute: 0),
          endTime: const TimeOfDay(hour: 22, minute: 0),
          price: 40000.0,
        ),
        ShiftPrice(
          id: '3',
          shiftType: ShiftType.night,
          startTime: const TimeOfDay(hour: 22, minute: 0),
          endTime: const TimeOfDay(hour: 6, minute: 0),
          price: 50000.0,
        ),
      ],
    ),
    Parking(
      id: '3',
      parkingName: 'Nhận Trông Xe Ngày Đêm',
      image: 'https://i.ibb.co/zfDshWW/parking.png',
      address: '121 P. Kim Đồng, Giáp Bát, Hoàng Mai, Hà Nội, Việt Nam',
      latitude: 20.97972534096629,
      longitude: 105.8424822985898,
      totalSlot: 15,
      availableSlot: 5,
      pricePerDay: 100000.0,
      pricePerMonth: 2000000000.0,
      pricePerYear: 30000000000.0,
      pricePerHour: [
        ShiftPrice(
          id: '1',
          shiftType: ShiftType.morning,
          startTime: const TimeOfDay(hour: 6, minute: 0),
          endTime: const TimeOfDay(hour: 17, minute: 0),
          price: 20000.0,
        ),
        ShiftPrice(
          id: '2',
          shiftType: ShiftType.afternoon,
          startTime: const TimeOfDay(hour: 17, minute: 0),
          endTime: const TimeOfDay(hour: 22, minute: 0),
          price: 30000.0,
        ),
        ShiftPrice(
          id: '3',
          shiftType: ShiftType.night,
          startTime: const TimeOfDay(hour: 22, minute: 0),
          endTime: const TimeOfDay(hour: 6, minute: 0),
          price: 40000.0,
        ),
      ],
    ),
  ];
}
