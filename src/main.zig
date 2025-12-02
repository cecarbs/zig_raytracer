const std = @import("std");
const raytracer = @import("raytracer");

pub fn main() !void {
    const image_width = 256;
    const image_height = 256;

    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    var stderr_buffer: [1024]u8 = undefined;
    var stderr_writer = std.fs.File.stderr().writer(&stderr_buffer);
    const stderr = &stderr_writer.interface;

    try stdout.print("P3\n{d} {d}\n255\n", .{ image_width, image_height });

    for (0..image_height) |j| {
        for (0..image_width) |i| {
            // std.debug.print("\rScanlines remaining: {d} ", .{image_height - j});
            try stderr.print("\rScanlines remaining: {d} ", .{image_height - j});
            try stdout.flush();

            const r = @as(f64, @floatFromInt(i)) / @as(f64, image_width - 1);
            const g = @as(f64, @floatFromInt(j)) / @as(f64, image_height - 1);
            const b: f64 = 0.0;

            const ir = @as(u8, @intFromFloat(255.999 * r));
            const ig = @as(u8, @intFromFloat(255.999 * g));
            const ib = @as(u8, @intFromFloat(255.999 * b));

            try stdout.print("{d} {d} {d}\n", .{ ir, ig, ib });
        }
    }

    try stdout.flush();
    // std.debug.print("\rDone.                 \n");
    try stderr.print("\rDone.                 \n", .{});
    try stderr.flush();
}
