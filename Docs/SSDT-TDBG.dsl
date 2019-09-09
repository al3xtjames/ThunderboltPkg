//
// SSDT for tracing SGOV method calls
//
// Use the following ACPI patch to rename the original declaration of SGOV (so
// existing calls will use the method defined in this SSDT):
// 53 47 4F 56 0A -> 58 47 4F 56 0A
//
// Look at the ACPI debug output in macOS after booting with this SSDT (and the
// dependent ACPI patch); you should see "Calling TBFP" followed by two lines
// from the SGOV method. The first line shows the arguments passed to SGOV; the
// first argument is the GPIO number, and the second argument is the value to
// write. The second line ("GPIO 0x... has MMIO address 0x...") shows the
// calculated MMIO address that corresponds to the specified GPIO number.
//
DefinitionBlock ("", "SSDT", 2, "APPLE ", "TbtDbg", 0x00001000)
{
    External (_SB_.GADR, MethodObj)    // 2 Arguments
    External (_SB_.GGRP, MethodObj)    // 1 Arguments
    External (_SB_.GNMB, MethodObj)    // 1 Arguments
    External (_SB_.TBFP, MethodObj)    // 1 Arguments

    //
    // Many OEM ACPI implementations have a ADBG method which is used for debug
    // logging. In almost all cases, this function calls MDBG, which is
    // supposed to be defined in a ACPI debug SSDT (but is usually missing).
    // This should make ADBG functional.
    //
    // To enable ACPI debug logging in AppleACPIPlatform:
    // Add boot args: acpi_layer=0x8 acpi_level=0x2 debug=0x100
    // (https://pikeralpha.wordpress.com/2013/12/23/enabling-acpi-debugging/)
    //
    // To retrieve the ACPI debug output in macOS:
    // log show --last boot --predicate 'process == "kernel" AND senderImagePath CONTAINS "AppleACPIPlatform"' --style compact | awk '/ACPI Debug/{getline; getline; print}'
    //
    Method (MDBG, 1, NotSerialized)
    {
        Debug = Arg0
    }

    Scope (_SB)
    {
        Device (TEST)
        {
            Name (_HID, "DEB0000")
            Method (_INI, 0, NotSerialized)
            {
                MDBG ("Calling TBFP")
                \_SB.TBFP (One)
            }
        }

        //
        // Set GPIO output value
        // Arg0: GPIO number
        // Arg1: GPIO value
        //
        Method (SGOV, 2, Serialized)
        {
            Name (DBGS, "")
            Fprintf (DBGS, "SGOV(0x%o, 0x%o) called", Arg0, Arg1)
            MDBG (DBGS)

            Local0 = GGRP (Arg0)
            Local1 = GNMB (Arg0)
            Local2 = (GADR (Local0, 0x02) + (Local1 * 0x08))
            Fprintf (DBGS, "GPIO 0x%o has MMIO address 0x%o", Arg0, Local2)
            MDBG (DBGS)

            OperationRegion (PDW0, SystemMemory, Local2, 0x04)
            Field (PDW0, AnyAcc, NoLock, Preserve)
            {
                TEMP,   1,
                Offset (0x04)
            }

            TEMP = Arg1
        }
    }
}
