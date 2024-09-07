const std = @import("std");

pub fn GenerateIPV4(a: u8, b: u8, c: u8, d: u8) void {
    var ipv4_output = [4]u8{ 0, 0, 0, 0 };

    ipv4_output[0] = a;
    ipv4_output[1] = b;
    ipv4_output[2] = c;
    ipv4_output[3] = d;

    std.debug.print("IPV4: {x}", .{ipv4_output});
}
