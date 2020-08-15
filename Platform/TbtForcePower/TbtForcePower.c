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
#include <Library/GpioLib.h>
#include <Library/HobLib.h>
#include <Library/IoLib.h>
#include <Library/UefiBootServicesTableLib.h>
#include <Library/UefiLib.h>

#include <TbtBoardInfo.h>

EFI_STATUS
EFIAPI
TbtForcePowerMain (
  IN EFI_HANDLE        ImageHandle,
  IN EFI_SYSTEM_TABLE  *SystemTable
  )
{
  EFI_STATUS       Status;
  TBT_INFO_HOB     *TbtInfoHob;

  TbtInfoHob = (TBT_INFO_HOB *) GetFirstGuidHob (&gTbtInfoHobGuid);
  if (TbtInfoHob != NULL) {
    ASSERT (TbtInfoHob->EfiHobGuidType.Header.HobLength >= sizeof (TBT_INFO_HOB));

    // TODO: WHL/CML can have up to 2 DTBT_CONTROLLER_CONFIG entries, check both
    DEBUG ((
      DEBUG_INFO,
      "GpioPad = 0x%X\n",
      TbtInfoHob->DTbtControllerConfig[0].ForcePwrGpio.GpioPad
      ));

    Status = GpioSetOutputValue (
      TbtInfoHob->DTbtControllerConfig[0].ForcePwrGpio.GpioPad,
      1
      );

    if (EFI_ERROR (Status)) {
      DEBUG ((DEBUG_ERROR, "Failed to write GPIO - %r\n", Status));
      return Status;
    }

    return EFI_SUCCESS;
  } else {
    return EFI_NOT_FOUND;
  }
}
