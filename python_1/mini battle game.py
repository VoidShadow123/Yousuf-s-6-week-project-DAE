import random
print ("An enemy has approached")
enemy_hp = random.randint(5, 10)
print (enemy_hp)
player_attack = random.randint(1, 8)
print ("Your attack was:", player_attack)
if player_attack >= enemy_hp:
    print ("You defeated the enemy")
else:
    print ("The enemy was too strong. Its HP was", enemy_hp)