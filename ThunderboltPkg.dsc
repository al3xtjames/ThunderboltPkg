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
  ConfigBlockLib|KabylakeSiliconPkg/Library/BaseConfigBlockLib/BaseConfigBlockLib.inf
  DebugLib|MdePkg/Library/UefiDebugLibConOut/UefiDebugLibConOut.inf
  DebugPrintErrorLevelLib|MdePkg/Library/BaseDebugPrintErrorLevelLib/BaseDebugPrintErrorLevelLib.inf
  DevicePathLib|MdePkg/Library/UefiDevicePathLib/UefiDevicePathLib.inf
  GpioExpanderLib|KabylakeOpenBoardPkg/Library/BaseGpioExpanderLib/BaseGpioExpanderLib.inf
  GpioLib|KabylakeSiliconPkg/Pch/Library/PeiDxeSmmGpioLib/PeiDxeSmmGpioLib.inf
  HobLib|MdePkg/Library/DxeHobLib/DxeHobLib.inf
  I2cAccessLib|KabylakeOpenBoardPkg/Library/PeiI2cAccessLib/PeiI2cAccessLib.inf
  IoLib|MdePkg/Library/BaseIoLibIntrinsic/BaseIoLibIntrinsic.inf
  MemoryAllocationLib|MdePkg/Library/UefiMemoryAllocationLib/UefiMemoryAllocationLib.inf
  MmPciLib|KabylakeSiliconPkg/Library/PeiDxeSmmMmPciLib/PeiDxeSmmMmPciLib.inf
  PcdLib|MdePkg/Library/BasePcdLibNull/BasePcdLibNull.inf
  PchCycleDecodingLib|KabylakeSiliconPkg/Pch/Library/PeiDxeSmmPchCycleDecodingLib/PeiDxeSmmPchCycleDecodingLib.inf
  PchInfoLib|KabylakeSiliconPkg/Pch/Library/PeiDxeSmmPchInfoLib/PeiDxeSmmPchInfoLib.inf
  PchP2sbLib|KabylakeSiliconPkg/Pch/Library/PeiDxeSmmPchP2sbLib/PeiDxeSmmPchP2sbLib.inf
  PchPcrLib|KabylakeSiliconPkg/Pch/Library/PeiDxeSmmPchPcrLib/PeiDxeSmmPchPcrLib.inf
  PchPsfLib|KabylakeSiliconPkg/Pch/Library/PeiDxeSmmPchPsfLib/PeiDxeSmmPchPsfLib.inf
  PchSbiAccessLib|KabylakeSiliconPkg/Pch/Library/PeiDxeSmmPchSbiAccessLib/PeiDxeSmmPchSbiAccessLib.inf
  PchSerialIoLib|KabylakeSiliconPkg/Pch/Library/PeiDxeSmmPchSerialIoLib/PeiDxeSmmPchSerialIoLib.inf
  PciCf8Lib|MdePkg/Library/BasePciCf8Lib/BasePciCf8Lib.inf
  PrintLib|MdePkg/Library/BasePrintLib/BasePrintLib.inf
  SmiHandlerProfileLib|MdePkg/Library/SmiHandlerProfileLibNull/SmiHandlerProfileLibNull.inf
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
  GCC:DEBUG_*_*_CC_FLAGS     = -D DISABLE_NEW_DEPRECATED_INTERFACES
  GCC:NOOPT_*_*_CC_FLAGS     = -D DISABLE_NEW_DEPRECATED_INTERFACES
  GCC:RELEASE_*_*_CC_FLAGS   = -D DISABLE_NEW_DEPRECATED_INTERFACES
  MSFT:DEBUG_*_*_CC_FLAGS    = -D DISABLE_NEW_DEPRECATED_INTERFACES
  MSFT:NOOPT_*_*_CC_FLAGS    = -D DISABLE_NEW_DEPRECATED_INTERFACES
  MSFT:RELEASE_*_*_CC_FLAGS  = -D DISABLE_NEW_DEPRECATED_INTERFACES
  XCODE:DEBUG_*_*_CC_FLAGS   = -D DISABLE_NEW_DEPRECATED_INTERFACES
  XCODE:NOOPT_*_*_CC_FLAGS   = -D DISABLE_NEW_DEPRECATED_INTERFACES
  XCODE:RELEASE_*_*_CC_FLAGS = -Oz -flto -D DISABLE_NEW_DEPRECATED_INTERFACES
