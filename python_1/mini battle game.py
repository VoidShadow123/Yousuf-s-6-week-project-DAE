import random
print ("An enemy has approached")
#Initial Health
enemy_hp = random.randint(5, 20)
player_hp = 20
print ("Pikachu HP:", enemy_hp)
print ("Your HP:", player_hp)
print ("-----------------------------")
#Battle Loop
while player_hp > 0 and enemy_hp > 0:
    input("Press Enter to attack Pikachu")
    print("\nChoose your attack:")
    print("1. Light Attack (2–4 damage, always hits)")
    print("2. Heavy Attack (6-10 damage, 45% chance to miss)")
    print("3. Regular Attack (3–5 + chance for crit)")
    choice = input("> ")

#Players Turn and Attack choices 1, 2, 3
    if choice == "1":
        damage = random.randint(2, 4)
        enemy_hp -= damage
        print(f"Light attack hit for {damage} damage!")

    elif choice == "2":
        if random.random() < 0.5:
            damage = 0
            print("Heavy attack missed!")
        else:
            damage = random.randint(6, 10)
            enemy_hp -= damage
            print(f"Heavy attack hit for {damage} damage!")

    elif choice == "3":
        base_attack = random.randint(3, 5)
        bonus = random.choice([0, 0, 0, 0, 0, 3])
        damage = base_attack + bonus
        enemy_hp -= damage
        print(f"Regular attack!")
        print(f"   Base:  {base_attack}")
        print(f"   Crit:  {bonus}")
        print(f"   Total: {damage}")

    else:
        damage = 0
        print("Invalid choice. You lose your turn.")
#Clamp Pikachu HP
    if enemy_hp < 0:
        enemy_hp = 0
    print ("You attacked the Pikachu")
    print (f"Pikachu HP: {enemy_hp}")
#Check if Pikachu is dead
    if enemy_hp == 0:
            print("You defeated the Pikachu!")
            print ("Pikachu HP was too low, experienced fatal wounds.")
            break
#Pikachu Counterattack
    enemy_attack = random.randint(2, 5)
    player_hp -= enemy_attack
    if player_hp < 0:
        player_hp = 0
    print(f"The Pikachu hits back with Thunderbolt for {enemy_attack} damage.")
    print(f"Your HP: {player_hp}")
    print("--------------------------")

    if player_hp == 0:
        print("You were defeated by the Pikachu.")

    if damage >= enemy_hp:
        print ("You defeated the Pikachu")
        print ("Pikachu HP was too low, experienced fatal wounds.")