#ifndef AMI_TBT_HOB_H
#define AMI_TBT_HOB_H

#include <Pi/PiHob.h>

#pragma pack(1)

//
// TBT GPIO Data Structure
//
typedef struct _AMI_TBT_GPIO_INFO {
  UINT8          GpioAccessType;     ///< Where the GPIO comes from [a.k.a how to access the GPIO],Where the GPIO comes from. 0: PCH; 1: I/O Expender
  UINT8          Expander;           ///< Applicable to GpioAccessType = IoExpander {TCA6424A} type
  UINT32         GpioNumber;         ///< GPIO Number/Pin Number/Pad Number
  UINT8          GpioMode;           ///< 0 = Edge Mode; 1 = Level Mode
  UINT8          GpioLevel;          ///< 0 = Active Low; 1 = Active High
  UINT32         AcpiGpeSignature;
  UINT16         AcpiGpeStsAddress;
  UINT8          AcpiGpeStsBit;
  UINT32         AcpiGpioGpeNumber;  ///< GPIO GPE Number ('xx' in _Exx, _Lxx)
  UINT8          AcpiGpeSignaturePorting; ///< 0 = No porting required(for 2-tier GPI GPE event architecture), 1 = Porting required(for 1-tier GPI GPE event architecture)
} AMI_TBT_GPIO_INFO;

//
// TBT Info HOB
//
typedef struct _AMI_TBT_INFO_HOB {
  EFI_HOB_GUID_TYPE EfiHobGuidType;
  UINT8             RevisionId;                 ///< Revision ID
  UINT32            TbtSupportedPortsInfo;      ///< Bit 0 = 1 means PCH-RootPort 0 is supported, Bit 1 = 1 means PCH-RootPort 1 is supported .... Bit 7 = 1 means PCH-RootPort 7 is supported
                                                ///< Bit 8 = 1 means PCH-RootPort 8 is supported, Bit 9 = 1 means PCH-RootPort 9 is supported .... Bit 15 = 1 means PCH-RootPort 15 is supported
                                                ///< Bit 16 = 1 means PCH-RootPort 16 is supported, Bit 17 = 1 means PCH-RootPort 17 is supported .... Bit 19 = 1 means PCH-RootPort 19 is supported
                                                ///< Bit 20 = 1 means Peg 0 is supported, Bit 21 = 1 means Peg 1 is supported .... Bit 22 = 1 means Peg 2 is supported
  UINT8             TbtDefaultSelectorInfo;     ///< Default Selector number (1-based)
  UINT8             HRPowerOffSupport;          ///< Host Router will power off completely during Sx, 1=Supported; 0=Not Supported
  AMI_TBT_GPIO_INFO ForcePwrGpio;
  AMI_TBT_GPIO_INFO CioPlugEventGpio;

  UINT8             TbtSupport;
  UINT8             TbtSelector;
  UINT8             TbtSwapSelector;
  UINT8             Bus;
  UINT8             Dev;
  UINT8             Fun;
  UINT8             SecurityMode;
  UINT8             AicSupport;
  UINT8             AicArSupport;               // AMI_OVERRIDE - Separate boot-on option for AR. EIP238956
  UINT8             TbtBootSupport;
  UINT8             TbtUsbOn;
  UINT8             TbtBootOn;                  // AMI_OVERRIDE - Separate boot-on option for AR. EIP238956
  UINT8             TbtWakeupSupport;
  UINT8             TbtCacheLineSize;
  UINT16            TbtForcePwrGroup;
  UINT16            TbtForcePwrPad;
  UINT16            TbtHotPlugEvtGroup;
  UINT16            TbtHotPlugEvtPad;
  UINT8             TbtSkipPciOprom;
  UINT8             TbtSkipPciEnumeration;
  UINT8             TbtAspm;
  UINT8             TbtLtr;
  UINT8             SmiNotifyEnabled;
  UINT8             TbtHotSMI;
  UINT8             TbtHotNotify;
  UINT8             TbtAcpiRemovalSupport;
  UINT16            ReserveMemoryPerSlot;
  UINT16            ReservePMemoryPerSlot;
  UINT8             AssignIO;
  UINT8             ReserveIOPerSlot;
} AMI_TBT_INFO_HOB;

#pragma pack()

#endif // AMI_TBT_HOB_H
