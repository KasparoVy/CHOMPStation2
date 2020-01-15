/*

Hyenas are any feliform carnivoran mammals of the family Hyaenidae. With only four extant species (in three genera), it is the fifth-smallest biological family in the Carnivora, and one of the smallest in the class Mammalia.
They're also cool, and Rykka/Nyria wrote this uwu

*/

// Cataloguer data here
/datum/category_item/catalogue/fauna/hyena
	name = "Desert Fauna - Hyena"
	desc = "Classification: Crocuta crocuta \
	<br><br>\
	It is primarily a hunter but may also scavenge, with the capacity to eat and digest skin, bone and other animal waste. \
	The spotted hyena displays greater plasticity in its hunting and foraging behaviour than other similar carnivores; \
	it hunts alone, in small parties of 2–5 individuals or in large groups. \
	During a hunt, spotted hyenas often run through ungulate herds in order to select an individual to attack. \
	Once selected, their prey is chased over a long distance, often several kilometres, at speeds of up to 60 km/h."
	value = CATALOGUER_REWARD_MEDIUM

// Start Defining the mob here
/mob/living/simple_mob/animal/hyena 
	name = "Hyena"
	desc = "Yeen! Its fur is a dusty yellow-brown color with black spots, and it has rounded ears... and SHARP TEETH! You inexplicably want to pet it, though."
	tt_desc = "Crocuta crocuta"
	catalogue_data = list(/datum/category_item/catalogue/fauna/hyena)

	icon_state = "hyena"
	icon_living = "hyena"
	icon_dead = "hyena_dead"
	has_eye_glow = FALSE // Change this to true for fun spooky eye glow in darkness. <3
	minbodytemp = 175 // Make hyenas able to survive freezing cold. Someone criticize me later uwu
	faction = "yeen" // gon fight any other mobs. grr
	maxHealth = 125 // not as tanky as a spider for obvious reasons, but not a pushover.
	health = 125
	pass_flags = PASSTABLE
	movement_cooldown = 0.25 // Yeen go fast
	// movement_sound = null - TODO: find good animal pawb sounds
	poison_resist = 0.1

	see_in_dark = 25 // Hyenas are nocturnal, they should be able to see anything in the dark. <3

	response_help = "rubrubs"
	response_disarm = "boops aside"
	response_harm = "smacks"

	melee_damage_lower = 12 // hyenas go for the legs/lower bits
	melee_damage_upper = 8 // not as high damage, but faster bites. nomnomnom <3
	attack_sharp = 1
	attack_edge = 1
	base_attack_cooldown = 0.5
	attacktext = list("bit", "nipped", "chomped", "clawed", "scratched", "lewded")
	attack_sound = 'sound/weapons/bite.ogg' // placeholder till I find a better bite

	ai_holder_type = /datum/ai_holder/simple_mob/melee/pack_mob // Define here what type of enemy hyena is.

	heat_damage_per_tick = 20
	cold_damage_per_tick = 20

	speak_emote = list("yaps")

	say_list_type = datum/say_list/hyena

	var/obj/item/clothing/head/hat = null // The hat the yeen is wearing when initialized, var will update with the chosen hat.

// Silly stuff. HATS! Give your yeen a hat today <3
/mob/living/simple_mob/animal/hyena/verb/remove_hat()
	set name = "Remove Hat"
	set desc = "Remove the yeen's hat. You monster. ;~;"
	set category = "Abilities"
	set src in view(1)

	drop_hat(usr)

/mob/living/simple_mob/animal/hyena/proc/drop_hat(var/mob/user)
	if(hat)
		hat.forceMove(get_turf(user))
		hat = null
		update_icon()
		if(user == src)
			to_chat(user, "<span class='notice'>You removed your hat.</span>")
			return
		to_chat(user, "<span class='warning'>You removed \the [src]'s hat. You monster. ;~;</span>")
	else
		if(user == src)
			to_chat(user, "<span class='notice'>You are not wearing a hat!</span>")
			return
		to_chat(user, "<span class='notice'>\The [src] is not wearing a hat!</span>")

/mob/living/simple_mob/animal/hyena/verb/give_hat()
	set name = "Give Hat"
	set desc = "Give the yeen a hat. You wonderful bean. <3"
	set category = "Abilities"
	set src in view(1)

	take_hat(usr)

/mob/living/simple_mob/animal/hyena/proc/take_hat(var/mob/user)
	if(hat)
		if(user == src)
			to_chat(user, "<span class='notice'>You already have a hat!</span>")
			return
		to_chat(user, "<span class='notice'>\The [src] already has a hat!</span>")
	else
		if(user == src)
			if(istype(get_active_hand(), /obj/item/clothing/head))
				hat = get_active_hand()
				drop_from_inventory(hat, src)
				hat.forceMove(src)
				to_chat(user, "<span class='notice'>You put on the hat.</span>")
				update_icon()
			return
		else if(ishuman(user))
			var/mob/living/carbon/human/H = user

			if(istype(H.get_active_hand(), /obj/item/clothing/head) && !get_active_hand())
				var/obj/item/clothing/head/newhat = H.get_active_hand()
				H.drop_from_inventory(newhat, get_turf(src))
				if(!stat)
					intent = I_HELP
					newhat.attack_hand(src)
			else if(src.get_active_hand())
				to_chat(user, "<span class='notice'>\The [src] seems busy with \the [get_active_hand()] already!</span>")

			else
				to_chat(user, "<span class='warning'>You aren't holding a hat...</span>")

/datum/say_list/hyena
	speak = list("Huff.", "|R|rr?", "Yap.", "Grr.", "Yip.", "SCREM!")
	emote_see = list("sniffs", "looks around", "grooms itself", "rolls around")
	emote_hear = list("yawns", "cackles", "playfully yaps")

/mob/living/simple_mob/animal/hyena/Destroy()
	if(hat)
		drop_hat(src) // ;w;
	..()

/mob/living/simple_mob/animal/hyena/update_icon()
	overlays.Cut()
	..()
	if(hat)
		var/hat_state = hat.item_state ? hat.item_state : hat.icon_state
		var/image/I = image('icons/mob/head.dmi', src, hat_state)
		I.pixel_y = -15 // Hyenas are smol! - TODO: Test this.
		I.appearance_flags = RESET_COLOR
		add_overlay(I)

// Start Defining the mob here
/mob/living/simple_mob/animal/hyena/Nyria 
	name = "Nyria"
	desc = "Yeen! This one seems familiar. Its fur is a dark, dusty reddish-brown color with black spots, and it has rounded ears... and SHARP TEETH! You inexplicably want to pet it, though."
	tt_desc = "Crocuta crocuta"

	icon_state = "hyena_nyria"
	icon_living = "hyena_nyria"
	icon_dead = "hyena_nyria_dead"

	maxHealth = 225 // tuff yeen. <3
	health = 225 // tuff yeen. <3