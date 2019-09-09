### What does TbtForcePower do?

The [`\_SB.TBFP`][1] ACPI method
[forces the internal TB3 controller to power on][2]. Unfortunately,
[race conditions with IOPCIFamily][3] make it difficult to actually use this method to
power on the controller in macOS. TbtForcePower aims to replicate this
functionality in a UEFI driver, bypassing any potential race conditions.

Please keep in mind that the only intended functionality of TbtForcePower is to
power on the Thunderbolt controller at boot. Sleep/wake support, hotplugging,
or any other features are strictly out of scope, and will require significant
research.

### Will this work with my hardware?

TbtForcePower should work with TB3 systems that have internal Thunderbolt
controllers. You can verify its functionality by manually loading the debug
version of the driver in the UEFI shell. It should print the GPIO information
stored in the HOB and not display any error messages.

### Will this work with my firmware implementation?

TbtForcePower should work with AMI's implementation of `TBT_INFO_HOB`, which is
used on most TB3 systems as far as I can tell. Unfortunately, the Kaby Lake
platform code in edk2-platforms uses a different structure for `TBT_INFO_HOB`.
The GPIO number is still present, but stored at a different offset. If you are
lucky enough to have a TB3 system with firmware based on EDK2/Intel FSP, feel
free to open an issue.

### How is the GPIO address for MmioWrite8 calculated?

The [initial version][4] of TbtForcePower directly wrote to the MMIO address
corresponding to the chipset GPIO for forcing Thunderbolt controller power;
this address was hardcoded and manually obtained by tracing the `\_SB.SGOV`
ACPI method.

It was later discovered that the Thunderbolt PEI driver publishes a HOB with
the GPIO number, which could be used in conjunction with the GPIO libraries in
the Kaby Lake platform code. The current version of TbtForcePower uses this, so
manual address calculation is no longer needed. If you are still interested for
whatever reason, see [`SSDT-TDBG.dsl`][5] for additional information.

### Additional TB3 notes

 - [osy86's NUC TB3 implementation][6]
 - [whitequark's TB3 research][2]

[1]: https://github.com/tianocore/edk2-platforms/blob/009ff27e0bc0ba02f0697e778d5527c518d29ab0/Platform/Intel/KabylakeOpenBoardPkg/Features/Tbt/AcpiTables/Tbt.asl#L1228
[2]: https://bugzilla.kernel.org/show_bug.cgi?id=189731#c13
[3]: https://osy.gitbook.io/hac-mini-guide/details/thunderbolt-3-fix#force-power
[4]: https://github.com/al3xtjames/ThunderboltPkg/commit/a49ceb5a342b7feae488edb51363bb7f114dd5aa
[5]: https://github.com/al3xtjames/ThunderboltPkg/blob/master/Docs/SSDT-TDBG.dsl
[6]: https://osy.gitbook.io/hac-mini-guide/details/thunderbolt-3-fix
