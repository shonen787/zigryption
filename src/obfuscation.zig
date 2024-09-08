const std = @import("std");

pub fn GenerateIPV4(in: []const u8) !void {
    if (in.len % 4 != 0) {
        std.debug.print("Error: Input has got to be a multiple of 4\n", .{});
        return error.InvalidInputLength;
    }

    var i: u8 = 0;
    std.debug.print("IPV4 Output\n", .{});
    while (i < in.len) {
        std.debug.print("{d}.{d}.{d}.{d}\n", .{ in[i], in[i + 1], in[i + 2], in[i + 3] });
        i += 4;
    }
}

pub fn GenerateIPV6(ipv6_bytes: []const u8) !void {
    if (ipv6_bytes.len % 16 != 0) {
        std.debug.print("Error: Input has got to be a multiple of 16\n", .{});
        return error.InvalidInputLength;
    }

    var i: u8 = 0;
    while (i < ipv6_bytes.len) {
        std.debug.print("{d}{d}:{d}{d}:{d}{d}:{d}{d}:{d}{d}:{d}{d}:{d}{d}:{d}{d}", .{
            ipv6_bytes[i],
            ipv6_bytes[i + 1],
            ipv6_bytes[i + 2],
            ipv6_bytes[i + 3],
            ipv6_bytes[i + 4],
            ipv6_bytes[i + 5],
            ipv6_bytes[i + 6],
            ipv6_bytes[i + 7],
            ipv6_bytes[i + 8],
            ipv6_bytes[i + 9],
            ipv6_bytes[i + 10],
            ipv6_bytes[i + 11],
            ipv6_bytes[i + 12],
            ipv6_bytes[i + 13],
            ipv6_bytes[i + 14],
            ipv6_bytes[i + 15],
        });

        i += 16;
    }
}

pub fn GenerateMAC() void {}
