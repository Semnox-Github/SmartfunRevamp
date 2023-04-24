import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/enums/contact_enum.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/account/provider/verify/verify_provider.dart';

class VerifyButton extends ConsumerWidget {
  const VerifyButton({super.key, required this.contactType, required this.phoneOrEmail});

  final ContactType contactType;
  final String phoneOrEmail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      sendOtpStateProvider,
      (_, next) {
        next.maybeWhen(
          orElse: () => {},
          inProgress: () => context.loaderOverlay.show(),
          error: (message) {
            context.loaderOverlay.hide();
            Dialogs.showErrorMessage(context, message);
          },
          success: (verifyContactType) {
            if (verifyContactType == contactType) {
              context.loaderOverlay.hide();
              Dialogs.verifyDialog(
                context,
                (otp) => ref.read(sendOtpStateProvider.notifier).verifyOTP(otp, contactType),
                contactType,
              );
            }
          },
          otpVerified: (_) => context.loaderOverlay.hide(),
        );
      },
    );
    return TextButton(
      onPressed: () {
        ref.read(sendOtpStateProvider.notifier).sendOTP(phoneOrEmail, contactType);
      },
      child: Consumer(
        builder: (context, ref, child) {
          return ref.watch(sendOtpStateProvider).maybeWhen(
                orElse: () => const MulishText(
                  text: 'Verify',
                  fontColor: CustomColors.hardOrange,
                  fontWeight: FontWeight.bold,
                ),
                otpVerified: (type) => MulishText(
                  text: type == contactType ? 'VERIFIED' : 'Verify',
                  fontColor: type == contactType ? Colors.green : CustomColors.hardOrange,
                  fontWeight: FontWeight.bold,
                ),
              );
        },
      ),
    );
  }
}

// class VerifyButton extends StatefulWidget {
//   const VerifyButton({super.key, required this.description});
//   final String description;

//   @override
//   State<VerifyButton> createState() => _VerifyButtonState();
// }

// class _VerifyButtonState extends State<VerifyButton> {
//   bool isVerified = false;

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: isVerified
//           ? null
//           : () {
//               Dialogs.verifyDialog(
//                 context,
//                 () {
//                   setState(() {
//                     isVerified = true;
//                   });
//                 },
//                 widget.description,
//               );
//             },
//       child: MulishText(
//         text: isVerified ? 'VERIFIED' : 'Verify',
//         fontColor: isVerified ? Colors.green : CustomColors.hardOrange,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
// }
