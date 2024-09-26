#!/bin/bash

# Function to start a session and listen until completion
run_session() {
    session_type="$1"
    session_number="$2"
    message="$3"

    # Jump to the specified session
    uairctl jump "$session_type"
    ~/.local/bin/notify.sh "$message Session $session_number Started!"

    # Listen for the timer to reach 00:00
    uairctl listen | while read -r line
    do
        if [[ "$line" == "00:00" ]]; then
            ~/.local/bin/notify.sh "$message Session $session_number Complete!"
            break
        fi
    done
}

# Number of work/rest cycles
cycles=12

for ((i=1; i<=cycles; i++))
do
    # Run work session
    run_session "work" "$i" "Work"

    # Run rest session
    run_session "rest" "$i" "Rest"
done

# Final notification after all cycles
notify-send "All cycles completed!"

