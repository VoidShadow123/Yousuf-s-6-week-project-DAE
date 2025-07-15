import tkinter as tk
import random

def start_battle():
    # Get random monster HP and player attack
    monster_hp = random.randint(5, 10)
    attack = random.randint(1, 5)
    bonus = random.choice([0, 0, 0, 0, 0, 3])  # 1 in 6 chance for +3
    total_attack = attack + bonus

    # Create result text
    result = f"monster HP: {monster_hp}\n"
    result += f"Your base attack: {attack}\n"
    result += f"Bonus: {bonus}\n"
    result += f"Total attack: {total_attack}\n\n"

    # Determine outcome
    if total_attack >= monster_hp:
        result += "🎉 You defeated the monster!"
    else:
        result += "☠️ The monster was too strong!"

    # Show result
    result_text.set(result)

# Set up the Tkinter window
window = tk.Tk()
window.title("Mini Battle Game")

# Instructions
title_label = tk.Label(window, text="Mini Battle Game", font=("Arial", 18))
title_label.pack(pady=10)

# Start battle button
start_button = tk.Button(window, text="Attack!", font=("Arial", 14), command=start_battle)
start_button.pack(pady=10)

# Result text area
result_text = tk.StringVar()
result_label = tk.Label(window, textvariable=result_text, font=("Courier", 12), justify="left")
result_label.pack(pady=10)

# Start the GUI
window.mainloop()