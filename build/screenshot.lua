-- local date_table = os.date("*t")
-- local hour, minute = date_table.hour, date_table.min
-- local year, month, day = date_table.year, date_table.month, date_table.day
-- local timestamp = string.format("%d %d, %d  %d:%d", month, day, year, hour, minute)

emu.frameadvance();
emu.frameadvance();
emu.frameadvance();
emu.frameadvance();

gui.text(16, 16, "TEST");
gui.savescreenshotas("screenshot.png");