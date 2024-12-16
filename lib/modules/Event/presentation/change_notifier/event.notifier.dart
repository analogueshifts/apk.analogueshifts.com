
import 'package:analogue_shifts_mobile/app/widgets/loading_dailog.dart';
import 'package:analogue_shifts_mobile/core/network/api_errors.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/snackbar.dart';
import 'package:analogue_shifts_mobile/modules/Event/data/models/create-event.dto.dart';
import 'package:analogue_shifts_mobile/modules/Event/domain/entities/event.entity.dart';
import 'package:analogue_shifts_mobile/modules/Event/domain/repositories/event-repository.dart';
import 'package:analogue_shifts_mobile/modules/Event/presentation/change_notifier/event.state.dart';
import 'package:analogue_shifts_mobile/modules/Event/presentation/widgets/create-event.sucess.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/company_saved_success.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EventProvider extends ChangeNotifier {
  final ErrorHandler _errorHandler = GetIt.instance<ErrorHandler>();
  final EventRepository _eventRepository = GetIt.instance<EventRepository>();

  final List<Event> _events = [];
  List<Event> get events => _events;

  final List<Event> _upcomingEvents = [];
  List<Event> get upcomingEvents => _upcomingEvents;

  final EventsState _eventState = EventsState();

  EventsState get eventState => _eventState;

  void toggleGenerating(bool value) {
    if(eventState.isGenerating == value)return;
    _eventState.toggleGenerating();
    notifyListeners();
  }


  Future<void> createEvent(CreateEventDto payload, BuildContext context) async {
    showLoadingDialog(context: context);
    final result = await _eventRepository.createEvent(payload);
    Navigator.pop(context);
    result.fold(
          (exception) {
        var error = _errorHandler.handleError(exception);
        if(context.mounted){
          AppSnackbar.error(context, message: error);
        }

      },
          (value) async{
        if(context.mounted){
          showDialog(
            barrierColor: Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.transparent .withOpacity(0.6) : const Color(0xff110C00).withOpacity(0.8),
            context: context,
            builder:(context) {
              return EventCreationSuccess();
            },);
        }

      },
    );
    notifyListeners();
  }

  Future<void> getSavedEvents(BuildContext context, [int? page]) async {
    logger.d(page);
    toggleGenerating(true);
    notifyListeners();
    final result = await _eventRepository.getEvents();
    toggleGenerating(false);
    result.fold(
          (exception) {
        var error = _errorHandler.handleError(exception);
        if(context.mounted){
          AppSnackbar.error(context, message: error);
        }

      },
          (result) async{
        events.clear();
        events.addAll(result);
        notifyListeners();

      },
    );
    notifyListeners();
  }

  Future<void> getUpcomingEvents(BuildContext context, [int? page]) async {
    logger.d(page);
    toggleGenerating(true);
    notifyListeners();
    final result = await _eventRepository.getUpcomingEvents();
    toggleGenerating(false);
    result.fold(
          (exception) {
        var error = _errorHandler.handleError(exception);
        if(context.mounted){
          AppSnackbar.error(context, message: error);
        }

      },
          (result) async{
        upcomingEvents.clear();
        upcomingEvents.addAll(result);
        notifyListeners();

      },
    );
    notifyListeners();
  }
}