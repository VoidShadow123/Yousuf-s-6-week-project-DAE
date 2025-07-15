import random
print ("An enemy has approached")
enemy_hp = random.randint(5, 20)
player_hp = 20
print ("Pikachu HP:", enemy_hp)
print ("Your HP:", player_hp)
print ("-----------------------------")
while player_hp > 0 and enemy_hp > 0:
    input("Press Enter to attack Pikachu")
    player_attack = random.randint(1, 8)
crit = random.choice([0, 0, 0, 0, 0, 0, 0, 0, 3, 3])
total_attack = player_attack + crit
enemy_hp -= total_attack
if enemy_hp < 0:
    enemy_hp = 0
print ("You attacked the Pikachu")
print ("Base Attack :", player_attack-crit)
print ("Critical Hit:", crit)
print ("Total Attack:", player_attack)
print (f"Pikachu HP: {enemy_hp}")
if enemy_hp == 0:
    print("🎉 You defeated the monster!")
    # Monster counter-attack
monster_attack = random.randint(2, 5)
player_hp -= monster_attack
if player_hp < 0:
        player_hp = 0
print(f"The monster hits back for {monster_attack} damage.")
print(f"Your HP: {player_hp}")
print("--------------------------")

if player_hp == 0:
        print("You were defeated by the Pikachu.")

if player_attack >= enemy_hp:
    print ("You defeated the Pikachu")
    print ("Its HP was", enemy_hp)
else:
    print ("The Pikachu was too strong. Its HP was", enemy_hp)