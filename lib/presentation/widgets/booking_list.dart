import 'package:court_reservation/presentation/blocs/BookingBloc/booking_bloc.dart';
import 'package:court_reservation/presentation/widgets/empty_list.dart';
import 'package:court_reservation/presentation/widgets/title_text.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingList extends StatefulWidget {
  const BookingList({super.key});

  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state.isSaved) {
          context.read<BookingBloc>().add(ChangeSaved());
          showFlash(
            context: context,
            duration: const Duration(seconds: 5),
            builder: (context, controller) {
              return Flash(
                controller: controller,
                position: FlashPosition.top,
                child: FlashBar(
                  backgroundColor: const Color(0xFFEFEBFF),
                  controller: controller,
                  content: Text(
                    state.alertMessage,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (state.firstLoad) {
          context.read<BookingBloc>().add(GetBookings());
        }
        return (state.bookings.isEmpty)
            ? const EmptyList()
            : ListView.builder(
                itemCount: state.bookings.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEFEBFF),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: TitleTextWidget(
                                  text:
                                      'Cancha: ${state.bookings[index].courtId}',
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF442F9A),
                                ),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: 190,
                                child: Row(
                                  children: [
                                    const Icon(Icons.person),
                                    TitleTextWidget(
                                        text: ' ${state.bookings[index].name}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              TitleTextWidget(
                                  text: 'Fecha: ${state.bookings[index].date}'),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  TitleTextWidget(
                                    text: state.bookings[index].weather,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  state.bookings[index].urlIcon.isNotEmpty
                                      ? Image(
                                          color: Colors.grey,
                                          height: 30,
                                          width: 30,
                                          image: NetworkImage(
                                              state.bookings[index].urlIcon),
                                        )
                                      : const Icon(
                                          Icons.question_mark,
                                          color: Colors.grey,
                                        ),
                                ],
                              )
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () {
                              showFlash(
                                context: context,
                                duration: const Duration(seconds: 5),
                                builder: (context, controller) {
                                  return Flash(
                                    controller: controller,
                                    position: FlashPosition.bottom,
                                    child: FlashBar(
                                      backgroundColor: const Color(0xFFEFEBFF),
                                      controller: controller,
                                      content: Column(
                                        children: [
                                          const Text(
                                            '¿Estas seguro que quieres eliminar este registro?',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                child: const Text(
                                                  'Cancelar',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  controller.dismiss();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text(
                                                  'Confirmar',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  context
                                                      .read<BookingBloc>()
                                                      .add(DeleteBooking(
                                                          bookingId: state
                                                              .bookings[index]
                                                              .id));
                                                  controller.dismiss();
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
