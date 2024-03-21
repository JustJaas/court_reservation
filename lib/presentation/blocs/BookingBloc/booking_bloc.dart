import 'package:bloc/bloc.dart';
import 'package:court_reservation/domain/entities/booking.dart';
import 'package:court_reservation/infraestructure/datasources/booking_db_datasource.dart';
import 'package:court_reservation/infraestructure/datasources/weather_api_datasource.dart';
import 'package:court_reservation/infraestructure/repositories/booking_repository_impl.dart';
import 'package:court_reservation/infraestructure/repositories/weather_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'booking_event.dart';
part 'booking_state.dart';

final bookingRepositoryProvider = BookingRepositoryImpl(BookingDBDatasource());
final weatherRepositoryProvider = WeatherRepositoryImpl(WeatherAPIDatasource());

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc._()
      : super(const BookingState(
          firstLoad: true,
          isSaved: false,
          isError: false,
          alertMessage: '',
          name: '',
          date: '',
          weather: '',
          urlIcon: '',
          courts: ['A', 'B', 'C'],
          courtId: 'A',
          bookings: [],
        )) {
    on<InitializeDB>(_initialize);

    on<GetBookings>((event, emit) async {
      await bookingRepositoryProvider
          .fetchAll()
          .then((value) => emit(state.copyWith(bookings: value)));
    });

    on<DeleteBooking>((event, emit) async {
      await bookingRepositoryProvider.delete(event.bookingId);
      add(GetBookings());
    });

    on<ChangeError>((event, emit) {
      emit(state.copyWith(isError: !state.isError));
    });

    on<ChangeSaved>((event, emit) {
      emit(state.copyWith(isSaved: false));
    });

    on<CleanData>((event, emit) {
      emit(state.copyWith(name: '', date: '', weather: '', urlIcon: ''));
    });

    on<EditCourt>((event, emit) async {
      emit(state.copyWith(courtId: event.courtId));
      final data = await weatherRepositoryProvider.getData(event.courtId);

      for (var element in data.list!) {
        String date = DateFormat('dd/MM/yyyy').format(element.dtTxt!);
        if (date == state.date) {
          final tempWeather =
              element.weather![0].description!.substring(0, 1).toUpperCase() +
                  element.weather![0].description!.substring(1);
          final tempIcon =
              "https://openweathermap.org/img/wn/${element.weather![0].icon}@2x.png";

          emit(state.copyWith(weather: tempWeather, urlIcon: tempIcon));
          break;
        }
      }
    });

    on<EditDate>((event, emit) {
      emit(state.copyWith(date: event.date));
      add(EditCourt(courtId: state.courtId));
    });

    on<EditName>((event, emit) => emit(state.copyWith(name: event.name)));

    on<SaveBooking>((event, emit) async {
      if (state.date.isEmpty) {
        add(ChangeError(isError: true));
        emit(state.copyWith(
          alertMessage: 'Necesitas registrar una fecha',
        ));
      } else if (state.name.isEmpty) {
        add(ChangeError(isError: true));
        emit(state.copyWith(
          alertMessage: 'Necesitas registrar un usuario',
        ));
      } else {
        await bookingRepositoryProvider
            .fetchByCourt(state.courtId, state.date)
            .then((value) async {
          if (value <= 2) {
            await bookingRepositoryProvider.create(
              name: state.name,
              date: state.date,
              weather: state.weather,
              urlIcon: state.urlIcon,
              courtId: state.courtId,
            );
            add(GetBookings());
            emit(state.copyWith(
              isSaved: true,
              alertMessage: 'Se registró con éxito!',
            ));
          } else {
            add(ChangeError(isError: true));
            emit(state.copyWith(
              alertMessage:
                  'La cancha ${state.courtId} ha alcanzado su límite para la fecha ${state.date}',
            ));
          }
        });
      }
    });
  }

  static final BookingBloc _instance = BookingBloc._();
  factory BookingBloc() => _instance;

  void _initialize(event, emit) => bookingRepositoryProvider.createTable();
}
