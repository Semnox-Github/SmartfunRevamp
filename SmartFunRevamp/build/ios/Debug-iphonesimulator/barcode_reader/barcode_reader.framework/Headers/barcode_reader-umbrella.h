#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BarcodeReaderPlugin.h"

FOUNDATION_EXPORT double barcode_readerVersionNumber;
FOUNDATION_EXPORT const unsigned char barcode_readerVersionString[];

