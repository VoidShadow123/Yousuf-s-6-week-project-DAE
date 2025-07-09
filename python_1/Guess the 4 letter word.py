import random

# List of 4-letter words (you can add more!)
words = ["cold", "fire", "mask", "hope", "dark", "game", "code", "void", "moon", "wind", "fuck", "told", "fish", "flat", "jade", "glad", "reef", "drip"]

# Choose a random word
secret = random.choice(words)

# Welcome
print("🎯 Welcome to 'Guess the 4-Letter Word'!")
print("Try to guess the word. You have 6 attempts.\n")

# Attempts
attempts = 6

while attempts > 0:
    guess = input(f"Attempt {7 - attempts}/6 - Enter your 4-letter guess: ").lower()

    if len(guess) != 4:
        print("⚠️ Please enter exactly 4 letters.")
        continue

    if guess == secret:
        print("🎉 You guessed it! The word was:", secret.upper())
        break

    # Feedback
    feedback = ""
    for i in range(4):
        if guess[i] == secret[i]:
            feedback += f"{guess[i]} ✅  "
        elif guess[i] in secret:
            feedback += f"{guess[i]} ⚠️  "
        else:
            feedback += f"{guess[i]} ❌  "
    print("Hint:", feedback.strip())

    attempts -= 1

if attempts == 0:
    print("💀 Out of attempts! The word was:", secret.upper())
