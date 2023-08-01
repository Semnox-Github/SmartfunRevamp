import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/membership_info/provider/membership_info_provider.dart';
import 'package:semnox/features/membership_info/widgets/current_membership_tier.dart';
import 'package:semnox/features/membership_info/widgets/other_tiers.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

enum MembershipTier { bronze, gold, diamond, platinum }

class MembershipInfoPage extends ConsumerWidget {
  const MembershipInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(title: SplashScreenNotifier.getLanguageLabel('Membership')),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final userMemberShip = ref.read(membershipInfoProvider).value;
            return ref.watch(membershipContainerProvider).when(
                  error: (_, __) => Center(
                    child: MulishText(
                      text: SplashScreenNotifier.getLanguageLabel('Error loading info'),
                    ),
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  data: (data) {
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final tier = data[index];
                        if (index == 0) {
                          return CurrentMembershipTier(
                            userMembershipInfo: userMemberShip,
                          );
                        }
                        return OtherTiers(
                          tier: MembershipTier.values[index % 4],
                          title: tier.membershipName,
                          subtitle: tier.description,
                        );
                      },
                    );
                  },
                );
          },
        ),
      ),
    );
  }
}
