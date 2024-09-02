//! By convention, root.zig is the root source file when making a library. If
//! you are making an executable, the convention is to delete this file and
//! start with main.zig instead.
const std = @import("std");
const testing = std.testing;

pub fn XorByOneKey(comptime sShellcodeSize: usize, comptime pShellcode: *[sShellcodeSize]u8, bKey: u8) void {
    for (pShellcode[0..sShellcodeSize]) |*byte| {
        byte.* ^= bKey;
    }
}

pub fn XorByOneKey_Generic(comptime T: type, comptime sShellcodeSize: T, pShellcode: *[sShellcodeSize]T, bKey: T) void {
    for (pShellcode[0..sShellcodeSize]) |*byte| {
        byte.* ^= bKey;
    }
}

pub fn XorByiKeys(comptime sShellcodeSize: usize, comptime pShellcode: *[sShellcodeSize]u8, bKey: u8) void {
    for (pShellcode[0..sShellcodeSize], 0..sShellcodeSize) |*byte, i| {
        byte.* ^= (bKey + i);
    }
}

pub fn XorByInputKey_Generic(comptime T: type, comptime sShellcodeSize: usize, pShellcode: *[sShellcodeSize]T, comptime sKeySize: usize, bKey: *const [sKeySize]T) void {
    var j: u8 = 0;
    for (pShellcode[0..sShellcodeSize]) |*byte| {
        if (j >= sKeySize) {
            j = 0;
        }
        byte.* ^= bKey[j];
        j += 1;
    }
}

pub fn XorByInputKey(comptime sShellcodeSize: usize, comptime pShellcode: *[sShellcodeSize]u8, comptime sKeySize: usize, comptime bKey: *const [sKeySize]u8) void {
    var j: u8 = 0;
    for (pShellcode[0..sShellcodeSize]) |*byte| {
        if (j >= sKeySize) {
            j = 0;
        }

        byte.* ^= bKey[j];
        j += 1;
    }
}
