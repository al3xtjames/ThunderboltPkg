ThunderboltPkg
==============

Various incomplete attempts to fix Thunderbolt on macOS

### TbtForcePower

UEFI driver that attempts to force the internal Thunderbolt controller to power
on at boot. This aims to replicate the functionality of the [`\_SB.TBFP`][1]
ACPI method at boot time. See the [FAQ][2] for additional information.

### Building

It is assumed that you have a functional [EDK2][3] workspace.

TbtForcePower uses various chipset GPIO libraries from the Kaby Lake platform
code in [edk2-platforms][4]. Ensure that `edk2-platforms/Platform/Intel` and
`edk2-platforms/Silicon/Intel` are included in `PACKAGES_PATH` before building.

Additionally, [the following patch][5] must be applied to edk2-platforms:

```bash
$ curl 'https://github.com/al3xtjames/edk2-platforms/commit/ed9fae7b7e4621c391d3d485ddb18c3fdfb5507a.patch' | git apply
```

[1]: https://github.com/tianocore/edk2-platforms/blob/009ff27e0bc0ba02f0697e778d5527c518d29ab0/Platform/Intel/KabylakeOpenBoardPkg/Features/Tbt/AcpiTables/Tbt.asl#L1228
[2]: https://github.com/al3xtjames/ThunderboltPkg/blob/master/Docs/FAQ.md
[3]: https://github.com/tianocore/edk2
[4]: https://github.com/tianocore/edk2-platforms
[5]: https://github.com/al3xtjames/edk2-platforms/commit/ed9fae7b7e4621c391d3d485ddb18c3fdfb5507a
