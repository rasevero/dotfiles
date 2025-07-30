#!/bin/bash

# Original focused border color
FOCUSED_COLOR="0xd33682"

# Alternate blink color (e.g., white)
BLINK_COLOR="0xffffff"

# Number of blinks
BLINKS=3

# Delay between toggles in seconds (0.15 = 150ms)
DELAY=0.15

for i in $(seq 1 $BLINKS); do
  # Set blink color
  riverctl border-color-focused $BLINK_COLOR
  sleep $DELAY

  # Restore original color
  riverctl border-color-focused $FOCUSED_COLOR
  sleep $DELAY
done

