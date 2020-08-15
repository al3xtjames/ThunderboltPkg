## @file
# Copyright (C) 2019, Alex James. All rights reserved.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
##

[Defines]
  PLATFORM_NAME           = ThunderboltPkg
  PLATFORM_GUID           = 870596E4-E429-47F7-83EC-40CC4468F1CD
  PLATFORM_VERSION        = 1.0
  SUPPORTED_ARCHITECTURES = X64
  BUILD_TARGETS           = RELEASE|DEBUG|NOOPT
  SKUID_IDENTIFIER        = DEFAULT
  DSC_SPECIFICATION       = 0x00010006

[LibraryClasses]
  BaseLib|MdePkg/Library/BaseLib/BaseLib.inf
  BaseMemoryLib|MdePkg/Library/BaseMemoryLib/BaseMemoryLib.inf
  ConfigBlockLib|IntelSiliconPkg/Library/BaseConfigBlockLib/BaseConfigBlockLib.inf
  CpuLib|MdePkg/Library/BaseCpuLib/BaseCpuLib.inf
  CpuPlatformLib|CoffeelakeSiliconPkg/Cpu/Library/PeiDxeSmmCpuPlatformLib/PeiDxeSmmCpuPlatformLib.inf
  DebugLib|MdePkg/Library/UefiDebugLibConOut/UefiDebugLibConOut.inf
  DebugPrintErrorLevelLib|MdePkg/Library/BaseDebugPrintErrorLevelLib/BaseDebugPrintErrorLevelLib.inf
  DevicePathLib|MdePkg/Library/UefiDevicePathLib/UefiDevicePathLib.inf
  GpioHelpersLib|CoffeelakeSiliconPkg/Pch/Library/Private/BaseGpioHelpersLibNull/BaseGpioHelpersLibNull.inf
  GpioLib|CoffeelakeSiliconPkg/Pch/Library/PeiDxeSmmGpioLib/PeiDxeSmmGpioLib.inf
  GpioNameBufferLib|CoffeelakeSiliconPkg/Pch/Library/Private/DxeGpioNameBufferLib/DxeGpioNameBufferLib.inf
  GpioPrivateLib|CoffeelakeSiliconPkg/Pch/Library/Private/PeiDxeSmmGpioPrivateLib/PeiDxeSmmGpioPrivateLibCnl.inf
  HobLib|MdePkg/Library/DxeHobLib/DxeHobLib.inf
  I2cAccessLib|WhiskeylakeOpenBoardPkg/Library/PeiI2cAccessLib/PeiI2cAccessLib.inf
  IoLib|MdePkg/Library/BaseIoLibIntrinsic/BaseIoLibIntrinsic.inf
  MemoryAllocationLib|MdePkg/Library/UefiMemoryAllocationLib/UefiMemoryAllocationLib.inf
  PcdLib|MdePkg/Library/BasePcdLibNull/BasePcdLibNull.inf
  PchCycleDecodingLib|CoffeelakeSiliconPkg/Pch/Library/PeiDxeSmmPchCycleDecodingLib/PeiDxeSmmPchCycleDecodingLib.inf
  PchDmiLib|CoffeelakeSiliconPkg/Pch/Library/Private/PeiDxeSmmPchDmiLib/PeiDxeSmmPchDmiLib.inf
  PchEspiLib|CoffeelakeSiliconPkg/Pch/Library/PeiDxeSmmPchEspiLib/PeiDxeSmmPchEspiLib.inf
  PchInfoLib|CoffeelakeSiliconPkg/Pch/Library/PeiDxeSmmPchInfoLib/PeiDxeSmmPchInfoLibCnl.inf
  PchPcrLib|CoffeelakeSiliconPkg/Pch/Library/PeiDxeSmmPchPcrLib/PeiDxeSmmPchPcrLib.inf
  PchPsfPrivateLib|CoffeelakeSiliconPkg/Pch/Library/Private/PeiDxeSmmPchPsfPrivateLib/PeiDxeSmmPchPsfPrivateLibCnl.inf
  PchSbiAccessLib|CoffeelakeSiliconPkg/Pch/Library/PeiDxeSmmPchSbiAccessLib/PeiDxeSmmPchSbiAccessLib.inf
  PchSerialIoLib|CoffeelakeSiliconPkg/Pch/Library/PeiDxeSmmPchSerialIoLib/PeiDxeSmmPchSerialIoLibCnl.inf
  PchSerialIoUartLib|CoffeelakeSiliconPkg/Pch/Library/PeiDxeSmmPchSerialIoUartLib/PeiDxeSmmPchSerialIoUartLib.inf
  PciCf8Lib|MdePkg/Library/BasePciCf8Lib/BasePciCf8Lib.inf
  PciLib|MdePkg/Library/UefiPciLibPciRootBridgeIo/UefiPciLibPciRootBridgeIo.inf
  PciSegmentLib|MdePkg/Library/BasePciSegmentLibPci/BasePciSegmentLibPci.inf
  PmcLib|CoffeelakeSiliconPkg/Pch/Library/PeiDxeSmmPmcLib/PeiDxeSmmPmcLib.inf
  PmcPrivateLib|CoffeelakeSiliconPkg/Pch/Library/Private/PeiDxeSmmPmcPrivateLib/PeiDxeSmmPmcPrivateLibCnl.inf
  PrintLib|MdePkg/Library/BasePrintLib/BasePrintLib.inf
  SaPlatformLib|CoffeelakeSiliconPkg/SystemAgent/Library/PeiDxeSmmSaPlatformLib/PeiDxeSmmSaPlatformLib.inf
  SataLib|CoffeelakeSiliconPkg/Pch/Library/PeiDxeSmmSataLib/PeiDxeSmmSataLibCnl.inf
  SynchronizationLib|MdePkg/Library/BaseSynchronizationLib/BaseSynchronizationLib.inf
  TimerLib|MdePkg/Library/BaseTimerLibNullTemplate/BaseTimerLibNullTemplate.inf
  UefiBootServicesTableLib|MdePkg/Library/UefiBootServicesTableLib/UefiBootServicesTableLib.inf
  UefiDriverEntryPoint|MdePkg/Library/UefiDriverEntryPoint/UefiDriverEntryPoint.inf
  UefiLib|MdePkg/Library/UefiLib/UefiLib.inf
  UefiRuntimeServicesTableLib|MdePkg/Library/UefiRuntimeServicesTableLib/UefiRuntimeServicesTableLib.inf

[Components]
  ThunderboltPkg/Platform/TbtForcePower/TbtForcePower.inf

[PcdsFixedAtBuild]
!if $(TARGET) == RELEASE
  # DEBUG_PRINT_ENABLED
  gEfiMdePkgTokenSpaceGuid.PcdDebugPropertyMask|2
  # DEBUG_ERROR | DEBUG_WARN
  gEfiMdePkgTokenSpaceGuid.PcdDebugPrintErrorLevel|0x80000002
  gEfiMdePkgTokenSpaceGuid.PcdFixedDebugPrintErrorLevel|0x80000002
!else
  # DEBUG_ASSERT_ENABLED | DEBUG_PRINT_ENABLED | DEBUG_CODE_ENABLED | CLEAR_MEMORY_ENABLED | ASSERT_DEADLOOP_ENABLED
  gEfiMdePkgTokenSpaceGuid.PcdDebugPropertyMask|0x2f
  # DEBUG_ERROR | DEBUG_WARN | DEBUG_INFO
  gEfiMdePkgTokenSpaceGuid.PcdDebugPrintErrorLevel|0x80000042
  gEfiMdePkgTokenSpaceGuid.PcdFixedDebugPrintErrorLevel|0x80000042
!endif

[BuildOptions]
  GCC:DEBUG_*_*_CC_FLAGS        = -D DISABLE_NEW_DEPRECATED_INTERFACES
  GCC:NOOPT_*_*_CC_FLAGS        = -D DISABLE_NEW_DEPRECATED_INTERFACES
  GCC:RELEASE_*_*_CC_FLAGS      = -D DISABLE_NEW_DEPRECATED_INTERFACES
  MSFT:DEBUG_*_*_CC_FLAGS       = -D DISABLE_NEW_DEPRECATED_INTERFACES
  MSFT:NOOPT_*_*_CC_FLAGS       = -D DISABLE_NEW_DEPRECATED_INTERFACES
  MSFT:RELEASE_*_*_CC_FLAGS     = -D DISABLE_NEW_DEPRECATED_INTERFACES
  XCODE:DEBUG_*_*_CC_FLAGS      = -D DISABLE_NEW_DEPRECATED_INTERFACES
  XCODE:NOOPT_*_*_CC_FLAGS      = -D DISABLE_NEW_DEPRECATED_INTERFACES
  XCODE:RELEASE_*_*_CC_FLAGS    = -Oz -flto -D DISABLE_NEW_DEPRECATED_INTERFACES
  CLANGPDB:DEBUG_*_*_CC_FLAGS   = -D DISABLE_NEW_DEPRECATED_INTERFACES
  CLANGPDB:NOOPT_*_*_CC_FLAGS   = -D DISABLE_NEW_DEPRECATED_INTERFACES
  CLANGPDB:RELEASE_*_*_CC_FLAGS = -D DISABLE_NEW_DEPRECATED_INTERFACES
