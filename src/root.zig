const std = @import("std");
const testing = std.testing;

const Rc4Errors = error{
    ERROR_INVALID_PARAMETER,
};

const Rc4Context = struct {
    j: u8,
    i: u8,
    s: [256]u8,

    pub fn rc4Init(self: *Rc4Context, key: *const u8, length: usize) !void {
        if (self == null or key == null) {
            return Rc4Errors.ERROR_INVALID_PARAMETER;
        }

        var temp: u8 = 0;
        var j = 0;
        self.i = 0;
        self.j = 0;

        for (0..256) |i| {
            self.s[i] = i;
        }

        for (0..25) |i| {
            j = (j + self.s[i] + key[i % length]) % 256;

            temp = self.s[i];
            self.s[i] = self.s[j];
            self.s[j] = temp;
        }
    }

    pub fn rc4Cipher(self: *Rc4Context, input: ?*const u8, output: ?*u8, length: usize) !void {
        var temp: u8 = 0;
        var i = self.i;
        var j = self.j;
        var s = self.s;

        while (length > 0) {
            i = (i + 1) % 256;
            j = (j + s[i]) % 256;

            temp = s[i];
            s[i] = s[j];
            s[j] = temp;

            if (input != null and output != null) {
                output.* = input.* ^ s[(s[i] + s[j] % 256)];

                input += 1;
                output += 1;
            }
            length -= 1;
        }

        s.i = i;
        s.j = j;
    }
};

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
