import 'package:ecoparking_flutter/model/account/vehicle.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/model/parking/shift_price.dart';
import 'package:ecoparking_flutter/model/ticket/ticket.dart';
import 'package:ecoparking_flutter/model/ticket/ticket_status.dart';
import 'package:flutter/material.dart';

class DummyData {
  static List<Parking> parkings = [
    Parking(
      id: '1',
      parkingName: 'Bãi đỗ xe Ô tô đình Giáp Tứ',
      image: 'https://i.ibb.co/zfDshWW/parking.png',
      address:
          '33 Ngách 143/74 Phố Nguyễn Chính, Thịnh Liệt, Hoàng Mai, Hà Nội, Việt Nam',
      phone: '0987654321',
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
      phone: '0987654321',
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
      phone: '0987654321',
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

  static List<Vehicle> vehicles = [
    Vehicle(
      id: '1',
      name: 'Toyota Vios',
      licensePlate: '30A-12345',
    ),
    Vehicle(
      id: '2',
      name: 'Toyota Camry',
      licensePlate: '30A-12346',
    ),
    Vehicle(
      id: '3',
      name: 'Toyota Innova',
      licensePlate: '30A-12347',
    ),
    Vehicle(
      id: '4',
      name: 'Toyota Fortuner',
      licensePlate: '30A-12348',
    ),
    Vehicle(
      id: '5',
      name: 'Toyota Land Cruiser',
      licensePlate: '30A-12349',
    ),
    Vehicle(
      id: '6',
      name: 'Toyota Hilux',
      licensePlate: '30A-12350',
    ),
  ];

  static List<Ticket> tickets = [
    Ticket(
      parkingName: 'Bãi đỗ xe Ô tô đình Giáp Tứ',
      image: 'https://i.ibb.co/zfDshWW/parking.png',
      address:
          '33 Ngách 143/74 Phố Nguyễn Chính, Thịnh Liệt, Hoàng Mai, Hà Nội, Việt Nam',
      parkingPhone: '0987654321',
      vehicleName: 'Toyota Land Cruiser',
      licensePlate: '30A-12349',
      startTime: DateTime(2021, 10, 1, 8, 0),
      endTime: DateTime(2021, 10, 1, 12, 0),
      status: TicketStatus.completed,
      days: 0,
      hours: 4,
      total: 80000.0,
    ),
    Ticket(
      parkingName: 'Bãi gửi xe Thịnh Liệt',
      image: 'https://i.ibb.co/zfDshWW/parking.png',
      address:
          'P304, Tòa nhà N 6, Khu chung cư, Đồng Tàu, Hoàng Mai, Hà Nội, Việt Nam',
      parkingPhone: '0987654321',
      vehicleName: 'Toyota Fortuner',
      licensePlate: '30A-12348',
      startTime: DateTime(2021, 10, 1, 8, 0),
      endTime: DateTime(2021, 10, 1, 12, 0),
      status: TicketStatus.cancelled,
      days: 0,
      hours: 4,
      total: 120000.0,
    ),
    Ticket(
      parkingName: 'Nhận Trông Xe Ngày Đêm',
      image: 'https://i.ibb.co/zfDshWW/parking.png',
      address: '121 P. Kim Đồng, Giáp Bát, Hoàng Mai, Hà Nội, Việt Nam',
      parkingPhone: '0987654321',
      vehicleName: 'Toyota Innova',
      licensePlate: '30A-12347',
      startTime: DateTime(2024, 11, 1, 8, 0),
      endTime: DateTime(2024, 11, 1, 12, 0),
      status: TicketStatus.paid,
      days: 0,
      hours: 4,
      total: 100000.0,
    ),
    Ticket(
      parkingName: 'Bãi đỗ xe Ô tô đình Giáp Tứ',
      image: 'https://i.ibb.co/zfDshWW/parking.png',
      address:
          '33 Ngách 143/74 Phố Nguyễn Chính, Thịnh Liệt, Hoàng Mai, Hà Nội, Việt Nam',
      parkingPhone: '0987654321',
      vehicleName: 'Toyota Camry',
      licensePlate: '30A-12346',
      startTime: DateTime(2024, 10, 30, 16, 0),
      endTime: DateTime(2024, 10, 30, 24, 0),
      status: TicketStatus.active,
      days: 0,
      hours: 8,
      total: 160000.0,
    )
  ];

  static List<Ticket> onGoingTickets = tickets
      .where((ticket) =>
          ticket.status == TicketStatus.active ||
          ticket.status == TicketStatus.paid)
      .toList();

  static List<Ticket> completedTickets = tickets
      .where((ticket) => ticket.status == TicketStatus.completed)
      .toList();

  static List<Ticket> cancelledTickets = tickets
      .where((ticket) => ticket.status == TicketStatus.cancelled)
      .toList();
}
