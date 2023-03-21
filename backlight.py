#!/usr/bin/env python3

import sys

if len(sys.argv) < 2:
    cmd = "get"
else:
    cmd = sys.argv[1]

min_v = 1
max_val = int(open("/sys/class/backlight/intel_backlight/max_brightness").read().strip())

if cmd == "get":
    print(open("/sys/class/backlight/intel_backlight/brightness").read().strip())
elif cmd == "mod":
    add = int(sys.argv[2])
    current = int(open("/sys/class/backlight/intel_backlight/brightness").read().strip())
    new = current + add
    if min_v < new < max_val:
        try:
            with open("/sys/class/backlight/intel_backlight/brightness","w") as f:
                f.write(str(new))
            print("done")
        except Exception as e:
            print(str(e))
    else:
        print("fail")
elif cmd == "set":
    new = int(sys.argv[2])
    if min_v < new < max_val:
        try:
            with open("/sys/class/backlight/intel_backlight/brightness","w") as f:
                f.write(str(new))
            print("done")
        except Exception as e:
            print(str(e))
    else:
        print("fail")
 
