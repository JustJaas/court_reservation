part of 'booking_bloc.dart';

abstract class BookingEvent {}

class InitializeDB extends BookingEvent {
  InitializeDB();
}

class FirstLoad extends BookingEvent {
  final bool firstLoad;
  FirstLoad({required this.firstLoad});
}

class EditCourt extends BookingEvent {
  final String courtId;
  EditCourt({required this.courtId});
}

class EditDate extends BookingEvent {
  final String date;
  EditDate({required this.date});
}

class EditName extends BookingEvent {
  final String name;
  EditName({required this.name});
}

class SaveBooking extends BookingEvent {
  SaveBooking();
}

class GetBookings extends BookingEvent {
  GetBookings();
}

class DeleteBooking extends BookingEvent {
  final int bookingId;
  DeleteBooking({required this.bookingId});
}

class ChangeError extends BookingEvent {
  final bool isError;
  ChangeError({required this.isError});
}

class ChangeSaved extends BookingEvent {
  ChangeSaved();
}

class CleanData extends BookingEvent {
  CleanData();
}
