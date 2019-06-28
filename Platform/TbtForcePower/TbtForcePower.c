#include <Pi/PiMultiPhase.h>

#include <Library/GpioExpanderLib.h>
#include <Library/GpioLib.h>
#include <Library/HobLib.h>
#include <Library/IoLib.h>
#include <Library/UefiBootServicesTableLib.h>
#include <Library/UefiLib.h>

#include <TbtBoardInfo.h>

EFI_STATUS
EFIAPI
TbtForcePowerMain (
  IN EFI_HANDLE       ImageHandle,
  IN EFI_SYSTEM_TABLE *SystemTable
  )
{
#if 0
  TBT_INFO_HOB *TbtInfoHob;

  TbtInfoHob = (TBT_INFO_HOB *) GetFirstGuidHob (&gTbtInfoHobGuid);
  if (TbtInfoHob != NULL) {
    Print (
      L"GpioAccessType = 0x%X, Expander = 0x%X, GpioPad = 0x%X\n",
      TbtInfoHob->DTbtControllerConfig.ForcePwrGpio.GpioAccessType,
      TbtInfoHob->DTbtControllerConfig.ForcePwrGpio.Expander,
      TbtInfoHob->DTbtControllerConfig.ForcePwrGpio.GpioPad
      );

    if (TbtInfoHob->DTbtControllerConfig.ForcePwrGpio.GpioAccessType == 0x01) {
      GpioSetOutputValue (
        TbtInfoHob->DTbtControllerConfig.ForcePwrGpio.GpioPad,
        1
        );
    } else if (TbtInfoHob->DTbtControllerConfig.ForcePwrGpio.GpioAccessType == 0x02) {
      GpioExpSetOutput (
        TbtInfoHob->DTbtControllerConfig.ForcePwrGpio.Expander,
        TbtInfoHob->DTbtControllerConfig.ForcePwrGpio.GpioPad,
        1
        );
    }

    gBS->Stall (TbtInfoHob->DTbtCommonConfig.Gpio3ForcePwrDly * 1000);

    return EFI_SUCCESS;
  } else {
    return EFI_NOT_FOUND;
  }
#else
  MmioWrite8 (0xFDAE0728UL, 1);
  return EFI_SUCCESS;
#endif
}
