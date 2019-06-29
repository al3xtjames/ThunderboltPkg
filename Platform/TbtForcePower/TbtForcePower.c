#include <Pi/PiMultiPhase.h>

#include <Library/DebugLib.h>
#include <Library/GpioExpanderLib.h>
#include <Library/GpioLib.h>
#include <Library/HobLib.h>
#include <Library/IoLib.h>
#include <Library/UefiBootServicesTableLib.h>
#include <Library/UefiLib.h>

#include <TbtBoardInfo.h>

#include "AmiTbtHob.h"

EFI_STATUS
EFIAPI
TbtForcePowerMain (
  IN EFI_HANDLE       ImageHandle,
  IN EFI_SYSTEM_TABLE *SystemTable
  )
{
  EFI_STATUS       Status;
  AMI_TBT_INFO_HOB *TbtInfoHob;

  TbtInfoHob = (AMI_TBT_INFO_HOB *) GetFirstGuidHob (&gTbtInfoHobGuid);
  if (TbtInfoHob != NULL) {
    ASSERT (TbtInfoHob->EfiHobGuidType.Header.HobLength >= sizeof (AMI_TBT_INFO_HOB));

    DEBUG ((
      DEBUG_INFO,
      "GpioAccessType = 0x%X, Expander = 0x%X, GpioNumber = 0x%X\n",
      TbtInfoHob->ForcePwrGpio.GpioAccessType,
      TbtInfoHob->ForcePwrGpio.Expander,
      TbtInfoHob->ForcePwrGpio.GpioNumber
      ));

    if (TbtInfoHob->ForcePwrGpio.GpioAccessType == 0x01) {
      // PCH
      Status = GpioSetOutputValue (TbtInfoHob->ForcePwrGpio.GpioNumber, 1);
      if (EFI_ERROR (Status)) {
        DEBUG ((DEBUG_ERROR, "Failed to write GPIO - %r\n", Status));
        return Status;
      }
    } else if (TbtInfoHob->ForcePwrGpio.GpioAccessType == 0x02) {
      // IoExpander {TCA6424A}
      GpioExpSetOutput (
        TbtInfoHob->ForcePwrGpio.Expander,
        TbtInfoHob->ForcePwrGpio.GpioNumber,
        1
        );
    }

    return EFI_SUCCESS;
  } else {
    return EFI_NOT_FOUND;
  }
}
