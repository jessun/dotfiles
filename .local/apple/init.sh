#!/bin/sh

echo 0 > /sys/module/hid_apple/parameters/swap_fn_leftctrl

echo disable > /sys/firmware/acpi/interrupts/gpe06

setxkbmap -option caps:swapescape
