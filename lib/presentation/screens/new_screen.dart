import 'package:court_reservation/presentation/blocs/BookingBloc/booking_bloc.dart';
import 'package:court_reservation/presentation/widgets/title_text.dart';
import 'package:flash/flash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  TextEditingController dateField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state.isSaved) {
          context.read<BookingBloc>().add(CleanData());
          Navigator.pop(context);
        }
        if (state.isError) {
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
          context.read<BookingBloc>().add(ChangeError(isError: false));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: const Text(
              "Agendar",
              style: TextStyle(
                letterSpacing: 2,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleTextWidget(text: 'Fecha :'),
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        top: 3,
                        bottom: 3,
                        right: 15,
                      ),
                      child: SizedBox(
                        height: 50,
                        child: InkWell(
                          onTap: () {
                            DatePicker.showDatePicker(
                              context,
                              currentTime: DateTime.now(),
                              locale: LocaleType.es,
                              showTitleActions: true,
                              minTime:
                                  DateTime.now().add(const Duration(days: 3)),
                              maxTime:
                                  DateTime.now().add(const Duration(days: 6)),
                              onConfirm: (date) {
                                context.read<BookingBloc>().add(EditDate(
                                    date: DateFormat('dd/MM/yyyy')
                                        .format(date)
                                        .toString()));
                                dateField.text = DateFormat('dd/MM/yyyy')
                                    .format(date)
                                    .toString();
                              },
                            );
                          },
                          child: TextFormField(
                            controller: dateField,
                            keyboardType: TextInputType.text,
                            enabled: false,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: Icon(
                                  Icons.calendar_month,
                                  color: Colors.grey,
                                ),
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black54,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const TitleTextWidget(text: 'Cancha :'),
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 2),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        child: SizedBox(
                          height: 20,
                          child: DropdownButton(
                            underline: const SizedBox(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                            isExpanded: true,
                            hint: Text(
                              state.courts
                                  .where((element) =>
                                      element.toString() == state.courtId)
                                  .first,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            items: state.courts.map((item) {
                              return DropdownMenuItem(
                                value: item.toString(),
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (value) {
                              context
                                  .read<BookingBloc>()
                                  .add(EditCourt(courtId: value.toString()));
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const TitleTextWidget(text: 'Clima :'),
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        top: 3,
                        bottom: 3,
                        right: 15,
                      ),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          suffixIcon: state.urlIcon.isNotEmpty
                              ? Image(
                                  color: Colors.grey,
                                  height: 10,
                                  width: 10,
                                  image: NetworkImage(state.urlIcon),
                                )
                              : const Icon(
                                  Icons.question_mark,
                                  color: Colors.grey,
                                ),
                          border: InputBorder.none,
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        child: SizedBox(
                          child: Text(
                            state.weather == '' ? 'Cargando...' : state.weather,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const TitleTextWidget(text: 'Usuario :'),
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        top: 3,
                        bottom: 3,
                        right: 15,
                      ),
                      child: SizedBox(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          onChanged: (String value) {
                            context
                                .read<BookingBloc>()
                                .add(EditName(name: value));
                          },
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(90, 51, 255, 1),
                      ),
                      onPressed: () {
                        context.read<BookingBloc>().add(SaveBooking());
                      },
                      child: const Text(
                        "Registrar",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
