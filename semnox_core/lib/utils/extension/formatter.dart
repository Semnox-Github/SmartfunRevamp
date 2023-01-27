///
/// Extension Methods to format number based on default config.
///
// extension FormatString on num {
//   String formatToCurrencyCode(BuildContext context) {
//     final format = context
//         .read(SemnoxDefaultConfigViewProvider.provider)
//         ?.getConfigFor(DefaultConfigKey.AMOUNT_WITH_CURRENCY_CODE);
//     return format == null ? toCurrency() : NumberFormat(format).format(this);
//   }

//   String formatToCurrencySymbol(BuildContext context) {
//     final format = context
//         .read(SemnoxDefaultConfigViewProvider.provider)
//         ?.getConfigFor(DefaultConfigKey.AMOUNT_WITH_CURRENCY_SYMBOL);
//     return NumberFormat(format).format(this);
//   }
// }

// extension FormatDateTime on DateTime? {
//   String fromatToDateTime(BuildContext context) {
//     if (this == null) return "";
//     final format = context
//         .read(SemnoxDefaultConfigViewProvider.provider)
//         ?.getConfigFor(DefaultConfigKey.DATETIME_FORMAT);
//     return DateFormat(format).format(this!);
//   }

//   String fromatToDate(BuildContext context) {
//     if (this == null) return "";
//     final format = context
//         .read(SemnoxDefaultConfigViewProvider.provider)
//         ?.getConfigFor(DefaultConfigKey.DATE_FORMAT);
//     return DateFormat(format).format(this!);
//   }
// }

extension StringUtils on String {
  String maxTrim(int length, {String overflowChar = "..."}) {
    // if(this == null) return "";
    return this.length > length ? substring(0, length) + overflowChar : this;
  }
}
