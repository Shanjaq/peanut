void(entity targ) spells_compute;
float(entity forwhom, float themod) spellmod_give;

void() personal_magic_shop_think = {
	if ( (self.enemy.shopping == 0) ) {

		remove ( self);
		self.enemy.selection = 0;

	}
	if (self.stepy == 0) {
		centerprint(self.enemy, "What color interests you?@1:  White@2:    Red@3: Yellow@4:  Green@5:   Blue@6:  Black@@7: What's my affinity?@8: EXIT");
		if ((self.enemy.selection >= 1) && (self.enemy.selection <= 7)) {
			self.stepy += 1;
			self.step1 = self.enemy.selection;
			self.enemy.selection = 0;
		}
		if (self.enemy.selection == 8) {
			self.enemy.shopping = 0;
			self.enemy.selection = 0;
			remove(self);
		}
	}
	if (self.stepy == 1) {
		if (self.step1 == 1) {
			centerprint(self.enemy, "Which White spells do you want to buy?@@1: Telekinesis(200)@2: Shell of Light(250)@3: Teleportation(350)@4: Summon Meteorite(400)@5: Photon Beam(500)@6:Radiant Matter(725)@@7: Back@8: EXIT");
		}
		if (self.step1 == 2) {
			centerprint(self.enemy, "Which Red spells do you want to buy?@@1: Flame Wave(150)@2: Boot of Ignius(300)@3: Fireball(350)@4: Sweltering Sky(450)@5: Pillar of Fire(550)@6: Giga Flare(700)@@7: Back@8: EXIT");
		}
		if (self.step1 == 3) {
			centerprint(self.enemy, "Which Yellow spells do you want to buy?@@1: Lightning Strike(250)@2: Mole Spike(300)@3: Arc of Death(350)@4: Chain Lightning(375)@5: Landslide (400)@6: Electrical Storm (650)@@7: Back@8: EXIT");
		}
		if (self.step1 == 4) {
			centerprint(self.enemy, "Which Green spells do you want to buy?@@1: Razor Wind(300)@2: Aero(350)@3: Bush Bash(400)@4: Telluric Regeneration(425)@5: Tree of Life(550)@6: Tornado(650)@@7: Back@8: EXIT");
		}
		if (self.step1 == 5) {
			centerprint(self.enemy, "Which Blue spells do you want to buy?@@1: Arctic Wind(200)@2: Cold Spike(250)@3: Ice Cage(320)@4: Crush Drop(450)@5: Glacial Hail(500)@6: Tsunami(600)@@7: Back@8: EXIT");
		}
		if (self.step1 == 6) {
			centerprint(self.enemy, "Which Black spells do you want to buy?@@1: Swarm of Rats(300)@2: Black Death(350)@3: Toxic Cloud(400)@4: Dark Matter(450)@5: Abyss(580)@6: Black Hole(725)@@7: Back@8: EXIT");
		}
		if (self.step1 == 7) {
			if (self.enemy.playerclass == CLASS_PALADIN)
				centerprint(self.enemy, "Your magic affinities are@@White:  +1@Red:    -1@Yellow: +0@Green:  +0@Blue:   +1@Black:  -1@(Magic Affinity improves the efficiency of spells)@@7: Back@8: EXIT");
			else if (self.enemy.playerclass == CLASS_CRUSADER)
				centerprint(self.enemy, "Your magic affinities are@@White:  +0@Red:    -1@Yellow: +1@Green:  +1@Blue:   +0@Black:  -1@(Magic Affinity improves the efficiency of spells)@@7: Back@8: EXIT");
			else if (self.enemy.playerclass == CLASS_NECROMANCER)
				centerprint(self.enemy, "Your magic affinities are@@White:  -1@Red:    +1@Yellow: +0@Green:  +0@Blue:   -1@Black:  +1@(Magic Affinity improves the efficiency of spells)@@7: Back@8: EXIT");
			else if (self.enemy.playerclass == CLASS_ASSASSIN)
				centerprint(self.enemy, "Your magic affinities are@@White:  -1@Red:    +0@Yellow: +1@Green:  -1@Blue:   +1@Black:  +0@(Magic Affinity improves the efficiency of spells)@@7: Back@8: EXIT");
		}
		if (self.step1 == 8) {
			self.enemy.shopping = 0;
			self.enemy.selection = 0;
			remove(self);
		}

		if (self.enemy.selection == 7)
		{
			self.stepy = 0;
			self.step1 = 0;
			self.enemy.selection = 0;
		}
		else if (self.enemy.selection == 8)
		{
			self.enemy.shopping = 0;
			self.enemy.selection = 0;
			remove(self);
		}
		else if ((self.enemy.selection >= 1) && (self.enemy.selection <= 6)) 
		{
			if (self.step1 <= 6)
			{
				self.step2 = self.enemy.selection;
				self.enemy.selection = 0;
				if (self.enemy.money < spell_price->((((self.step1 - 1) * 6) + self.step2) - 1)) {
					sprint(self.enemy, "you don't have enough money!\n");
					self.enemy.shopping = 0;
					remove(self);
				} else {
					self.stepy += 1;
				}
			}
		}
	}

	if (self.stepy == 2) {
		centerprint(self.enemy, "which hand will you equip?@@1:  Left@2: Right@@7: Back@8: EXIT");
		if (self.enemy.selection == 1) {
			self.step3 = 1;
		}
		if (self.enemy.selection == 2) {
			self.step3 = 2;
		}
		if (self.enemy.selection == 7) {
			self.enemy.selection = 0;
			self.enemy.step2 = 0;
			self.stepy -= 1;
		}
		if (self.enemy.selection == 8) {
			self.enemy.shopping = 0;
			self.enemy.selection = 0;
			remove(self);
		}

		if ((self.enemy.selection == 1) || (self.enemy.selection == 2)) {
			self.stepy += 1;
			self.step3 = self.enemy.selection;
			self.enemy.selection = 0;
		}

	}


	if (self.stepy == 3) {
		centerprint(self.enemy, "which finger will you equip?@1: Thumb@2: Index@3: Middle@4: Ring@5: Pinky@@7: Back@8: EXIT");
		if (self.enemy.selection == 1) {
			self.step4 == self.enemy.selection;
		}
		if (self.enemy.selection == 2) {
			self.step4 == self.enemy.selection;
		}
		if (self.enemy.selection == 3) {
			self.step4 == self.enemy.selection;
		}
		if (self.enemy.selection == 4) {
			self.step4 == self.enemy.selection;
		}
		if (self.enemy.selection == 5) {
			self.step4 == self.enemy.selection;
		}

		if (self.enemy.selection == 7) {
			self.enemy.selection = 0;
			self.enemy.step3 = 0;
			self.stepy -= 1;
		}
		if (self.enemy.selection == 8) {
			self.enemy.shopping = 0;
			self.enemy.selection = 0;
			remove(self);
		}

		if ((self.enemy.selection >= 1) && (self.enemy.selection <= 5)) {
			self.stepy += 1;
			self.step4 = self.enemy.selection;
			self.enemy.selection = 0;
		}
	}
	
	if (self.stepy == 4) {

		self.enemy.handy = (self.step3 - 1);
		if (self.step3 == 1) {
			self.enemy.Lfinger = (self.step4 - 1);
			spells_compute(self.enemy);
			if (self.enemy.Lspell) {
				self.enemy.money += spell_price->(self.enemy.Lspell - 1);
				sprint(self.enemy, "you already had a spell there!  selling it for ");
				sprint(self.enemy, ftos(spell_price->(self.enemy.Lspell - 1)));
				sprint(self.enemy, " gold.\n");
				if (self.enemy.Lsupport & SUPPORT_CASTSPEED)
					self.enemy.debt -= ((1 - spellmod_give(self.enemy, SUPPORT_CASTSPEED)) * 1500);
				if (self.enemy.Lsupport & SUPPORT_MULTI)
					self.enemy.debt -= ((1 - spellmod_give(self.enemy, SUPPORT_MULTI)) * 1500);
				if (self.enemy.Lsupport & SUPPORT_DAMAGE)
					self.enemy.debt -= ((1 - spellmod_give(self.enemy, SUPPORT_DAMAGE)) * 1500);
				if (self.enemy.Lsupport & SUPPORT_RADIUS)
					self.enemy.debt -= ((1 - spellmod_give(self.enemy, SUPPORT_RADIUS)) * 1500);
				if (self.enemy.Lsupport & SUPPORT_TRAP)
					self.enemy.debt -= ((1 - spellmod_give(self.enemy, SUPPORT_TRAP)) * 1500);
			}
		}
		if (self.step3 == 2) {
			self.enemy.Rfinger = (self.step4 - 1);
			spells_compute(self.enemy);
			if (self.enemy.Rspell) {
				self.enemy.money += spell_price->(self.enemy.Rspell - 1);
				sprint(self.enemy, "you already had a spell there!  selling it for ");
				sprint(self.enemy, ftos(spell_price->(self.enemy.Rspell - 1)));
				sprint(self.enemy, " gold.\n");
				if (self.enemy.Rsupport & SUPPORT_CASTSPEED)
					self.enemy.debt -= ((1 - spellmod_give(self.enemy, SUPPORT_CASTSPEED)) * 1500);
				if (self.enemy.Rsupport & SUPPORT_MULTI)
					self.enemy.debt -= ((1 - spellmod_give(self.enemy, SUPPORT_MULTI)) * 1500);
				if (self.enemy.Rsupport & SUPPORT_DAMAGE)
					self.enemy.debt -= ((1 - spellmod_give(self.enemy, SUPPORT_DAMAGE)) * 1500);
				if (self.enemy.Rsupport & SUPPORT_RADIUS)
					self.enemy.debt -= ((1 - spellmod_give(self.enemy, SUPPORT_RADIUS)) * 1500);
				if (self.enemy.Rsupport & SUPPORT_TRAP)
					self.enemy.debt -= ((1 - spellmod_give(self.enemy, SUPPORT_TRAP)) * 1500);
			}
		}


		if (self.step4 == 1) {

			if (self.step3 == 1) {
				self.enemy.Lfinger1S = (((self.step1 - 1) * 6) + self.step2);
				self.enemy.Lfinger1Support = 0.00000;
			}
			if (self.step3 == 2) {
				self.enemy.Rfinger1S = (((self.step1 - 1) * 6) + self.step2);
				self.enemy.Rfinger1Support = 0.00000;
			}

		}
		if (self.step4 == 2) {

			if (self.step3 == 1) {
				self.enemy.Lfinger2S = (((self.step1 - 1) * 6) + self.step2);
				self.enemy.Lfinger2Support = 0.00000;
			}
			if (self.step3 == 2) {
				self.enemy.Rfinger2S = (((self.step1 - 1) * 6) + self.step2);
				self.enemy.Rfinger2Support = 0.00000;
			}

		}
		if (self.step4 == 3) {

			if (self.step3 == 1) {
				self.enemy.Lfinger3S = (((self.step1 - 1) * 6) + self.step2);
				self.enemy.Lfinger3Support = 0.00000;
			}
			if (self.step3 == 2) {
				self.enemy.Rfinger3S = (((self.step1 - 1) * 6) + self.step2);
				self.enemy.Rfinger3Support = 0.00000;
			}

		}
		if (self.step4 == 4) {

			if (self.step3 == 1) {
				self.enemy.Lfinger4S = (((self.step1 - 1) * 6) + self.step2);
				self.enemy.Lfinger4Support = 0.00000;
			}
			if (self.step3 == 2) {
				self.enemy.Rfinger4S = (((self.step1 - 1) * 6) + self.step2);
				self.enemy.Rfinger4Support = 0.00000;
			}

		}
		if (self.step4 == 5) {

			if (self.step3 == 1) {
				self.enemy.Lfinger5S = (((self.step1 - 1) * 6) + self.step2);
				self.enemy.Lfinger5Support = 0.00000;
			}
			if (self.step3 == 2) {
				self.enemy.Rfinger5S = (((self.step1 - 1) * 6) + self.step2);
				self.enemy.Rfinger5Support = 0.00000;
			}

		}
		
		if ((self.step4 >= 1) && (self.step4 <= 5))
			self.enemy.money -= spell_price->((((self.step1 - 1) * 6) + self.step2) - 1);
		
		self.stepy += 1;
	}
	if (self.stepy == 5) {
		self.enemy.selection = 0;
		self.enemy.shopping = 0;
		remove(self);
	} else {
		AdvanceThinkTime(self, 0.1);
		self.think = personal_magic_shop_think;
	}
};

void(entity shopper) personal_magic_shop = {

	newmis = spawn();
	newmis.enemy = shopper;
	shopper.shopping = 1;
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = personal_magic_shop_think;
};




void() ShopCheck;
void() ActivateShop =
{

	// 	sound (self, CHAN_AUTO, "misc/basekey.wav", 1, ATTN_NORM);
	//  sprint(self.owner,"start your shopping!\n");
	self.nextthink=time+0.1;
	self.think=ShopCheck;
};

void() ShopTouch =
{
	//if (self.owner)
	//{
		//sprint(self.owner,"Shop will be open in 3 seconds.\n");
	//}
	self.nextthink=time+3;
	self.think=ActivateShop;
	return;
};


void() ShopCheck = {
	local string dotz;
	local entity head, tracker;
	
	if (self.owner != world)
	{
		head = findradius ( self.owner.origin, 192.00000);
		while ( head ) {

			if ( (((head.health > 0) && (head.classname == "player")) && visible ( head)) ) {

				if ( (vlen ( (head.origin - self.owner.origin)) < 96) ) {

					bee = 0;
					if ( ((self.cnt == 0) && (head.shopping == 0)) ) {

						centerprint ( head, "Hello, what can I do for you?@@1 = Buy Items@2 = Buy Spells");
						head.sale = 1;
						if ( (head.choice == 1) ) {

							self.cnt = 1;
							head.choice = 0;

						}
						if ( (head.choice == 2) ) {

							head.choice = 0;
							head.sale = 0;
							personal_magic_shop ( head);

						}

					}
					if ( (self.cnt == 1) ) {

						centerprint ( head, "Ready to purchase?@1 = yes@2 = no@3 = how much?");
						if ( (head.choice == 1) ) {

							if ( (head.money < head.debt) ) {
								sprint(head, ftos(head.money));
								sprint(head, " gold?  No sale!  Trade some items back and ask me again.\n");
								head.choice = 0;
								head.sale = 0;
								self.cnt = 0;
							} else {

								sprint ( head, "Thank you, come again!\n");
								head.money = (head.money - head.debt);
								head.debt = 0;
								head.choice = 0;
								head.predebt = 0;
								head.sale = 0;
								tracker = find ( world, classname, "item_tracker");
								while (tracker != world)
								{
									if (tracker.owner == head)
									{
										head.inv_spellmods = tracker.inv_spellmods;
										remove(tracker);
									}
									tracker = find ( tracker, classname, "item_tracker");
								}
								
								self.cnt = 0;
							}

						}
						if ( (head.choice == 2) ) {

							sprint ( head, "Come back when you're ready to make a deal!\n");
							head.choice = 0;
							head.sale = 0;
							self.cnt = 0;

							tracker = find ( world, classname, "item_tracker");
							while (tracker != world)
							{
								if (tracker.owner == head)
								{
									sprint(head, "Returning Spell Modifiers to the shelf.\n");
									head.debt -= tracker.debt;
									remove(tracker);
								}
								tracker = find ( tracker, classname, "item_tracker");
							}
						}
						if ( (head.choice == 3) ) {

							sprint(head, "Those items are worth ");
							sprint(head, ftos(head.debt));
							sprint(head, " gold.\n");
							head.choice = 0;

						}

					}
				} else {

					if ( (vlen ( (head.origin - self.owner.origin)) > 96) ) {

						head.sale = 0;
						self.cnt = 0;
						head.shopping = 0;
						head.selection = 0;
						head.choice = 0;
						centerprint ( head, "@");

					}
					ActivateShop ( );
					return ;

				}

			}
			head = head.chain;

		}
		self.nextthink = 0.50000;
		self.think = ShopCheck;
	}
	else
	{
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
};

void() DropShop =
{
	local	entity missile, mpuff;

	//  if (self.ammo_rockets<5) return;
	//self.ammo_rockets = self.ammo_rockets - 5;  //took out invalid syntax - rockets not subtracting
	//	self.currentammo = self.ammo_rockets = self.ammo_rockets - 5;  //fix by mjmorgan@usa.net
	//	sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

	missile = spawn ();
	missile.owner = self;
	missile.movetype = MOVETYPE_TOSS;
	missile.solid = SOLID_BBOX;
	missile.classname = "mine";

	// set missile speed

	makevectors (self.v_angle);
	missile.velocity = aim2(self, 0);
	missile.velocity = missile.velocity * 0;
	//  missile.angles = vectoangles(missile.velocity);

	missile.touch = ShopTouch;

	// set missile duration

	//	setmodel (missile, "models/dwarf.mdl");
	setsize (missile, '0 0 0', '0 0 0');
	missile.view_ofs = '0 0 48';
	setorigin (missile, self.origin + v_forward*8 + '0 0 16');

};
