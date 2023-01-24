import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/widgets/input_fields/text_fields/editable_list_tile.dart';
import 'package:semnox_core/widgets/semnox_widget/network_configuration_widget.dart/view_model/network_configuration_form_view_model.dart';

class NetworkConfigurationForm extends StatefulWidget {
  const NetworkConfigurationForm({Key? key}) : super(key: key);

  @override
  State<NetworkConfigurationForm> createState() =>
      _NetworkConfigurationFormState();
}

class _NetworkConfigurationFormState extends State<NetworkConfigurationForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, WidgetRef ref, child) {
      final viewModel = ref.watch(NetworkConfigurationFormViewModel.provider);
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 100.mapToIdealHeight(context),
            ),
            const SemnoxText.h4(text: "NETWORK INFORMATION"),
            SizedBox(
              height: 45.mapToIdealHeight(context),
            ),
            DataProviderBuilder<NetworkConfigurationDTO?>(
                dataProvider: viewModel.connectionInfoProvider,
                builder: (context, connectionInfo) {
                  var isConnected = connectionInfo != null;
                  return Column(
                    children: [
                      StreamBuilder<String>(
                          stream: viewModel.ssId,
                          builder: (context, snapshot) {
                            return SemnoxListTile(
                              isSelected: isConnected,
                              leading: SemnoxIcons.wifi.toIcon(),
                              title: const SemnoxText(
                                text: "SSID",
                              ),
                              subtitle: SemnoxText(
                                text: isConnected
                                    ? snapshot.data ?? "--"
                                    : "Please Connect to network",
                              ),
                              trailing: isConnected
                                  ? SemnoxIcons.checked.toIcon()
                                  : Container(),
                            );
                          }),
                      if (!isConnected)
                        Container()
                      else ...[
                        SizedBox(
                          height: 20.mapToIdealHeight(context),
                        ),
                        StreamBuilder<String>(
                            stream: viewModel.deviceipAddress,
                            builder: (context, snapshot) {
                              return SemnoxListTile(
                                leading: SemnoxIcons.ipAddress.toIcon(),
                                title: const SemnoxText.bodyMed1(
                                  text: "Device Ip Address",
                                ),
                                subtitle: SemnoxText.bodyReg1(
                                  text: snapshot.data ?? "",
                                ),
                              );
                            }),
                        SizedBox(
                          height: 20.mapToIdealHeight(context),
                        ),
                        StreamBuilder<String>(
                            stream: viewModel.macAddress,
                            builder: (context, snapshot) {
                              return SemnoxListTile(
                                leading: SemnoxIcons.macAddress.toIcon(),
                                title: const SemnoxText.bodyMed1(
                                  text: "MAC Address",
                                ),
                                subtitle: SemnoxText.bodyReg1(
                                  text: snapshot.data ?? "",
                                ),
                              );
                            }),
                        SizedBox(
                          height: 20.mapToIdealHeight(context),
                        ),
                        SetupTextFormField(
                          textFieldPropeties: viewModel.serverIpField,
                          label: "Server Url",
                        ),
                        SizedBox(
                          height: 20.mapToIdealHeight(context),
                        ),
                        connectionInfo != null
                            ? SemnoxFlatButton(
                                child: const SemnoxText(text: "VALIDATE"),
                                onPressed: () async {
                                  bool status =
                                      await viewModel.validateIpAddress();
                                  if (status == false) {
                                    SemnoxSnackbar.error(
                                        context, "Not Validated");
                                  } else {
                                    SemnoxSnackbar.success(
                                        "Ip Address Validated", context);
                                  }
                                },
                              )
                            : Container(),
                        connectionInfo != null
                            ? SizedBox(
                                height: 20.mapToIdealHeight(context),
                              )
                            : Container(),
                        connectionInfo != null
                            ? SemnoxFlatButton(
                                child: const SemnoxText(
                                    text: "SAVE CONFIGURATION"),
                                onPressed: () async {
                                  viewModel.saveNetworkConfiguraton();
                                },
                              )
                            : Container(),
                      ]
                    ],
                  );
                }),
          ],
        ),
      );
    });
  }
}
