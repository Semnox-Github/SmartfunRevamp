import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/use_cases/feedback/get_feedback_actions_use_case.dart';

class BookingsView extends ConsumerWidget {
  const BookingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useCase = Get.find<GetFeedbackActionsUseCase>();
    useCase();
    return const Center(
      child: Text(
        'Bookings',
      ),
    );
  }
}
