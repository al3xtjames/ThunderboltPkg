/** @file
  Copyright (C) 2019, Alex James. All rights reserved.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
**/

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
  IN EFI_HANDLE        ImageHandle,
  IN EFI_SYSTEM_TABLE  *SystemTable
  )
{
  UINT8            GpioPchAccessType;
  UINT8            GpioExpanderAccessType;
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

    GpioPchAccessType = TbtInfoHob->RevisionId > 1 ? 0x01 : 0x00;
    GpioExpanderAccessType = TbtInfoHob->RevisionId > 1 ? 0x02 : 0x01;

    if (TbtInfoHob->ForcePwrGpio.GpioAccessType == GpioPchAccessType) {
      // PCH
      Status = GpioSetOutputValue (TbtInfoHob->ForcePwrGpio.GpioNumber, 1);
      if (EFI_ERROR (Status)) {
        DEBUG ((DEBUG_ERROR, "Failed to write GPIO - %r\n", Status));
        return Status;
      }
    } else if (TbtInfoHob->ForcePwrGpio.GpioAccessType == GpioExpanderAccessType) {
      // IoExpander {TCA6424A}
      GpioExpSetOutput (
        TbtInfoHob->ForcePwrGpio.Expander,
        TbtInfoHob->ForcePwrGpio.GpioNumber,
        1
        );
    }

    return EFI_SUCCESS;
  } else {
    DEBUG ((DEBUG_ERROR, "Thunderbolt Info HOB was not found\n"));
    return EFI_NOT_FOUND;
  }
}
