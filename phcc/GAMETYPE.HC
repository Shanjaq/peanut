void() GotoNextMap;
void() monster_sheep_run;
void() squelch;
void() select_mage;
void(entity magician) make_mage;
void() player_sheep;
void() sheep_wait;
void() sheep_pain;
void() obj_push;
void() sheep_graze_a;

float siege_time;

void ()savechars = {
	local entity found, char_data, lastchar;
	local float i, hash;
	
	dprint("Saving Chars\n");
	
	found = find(world, classname, "player");
	while (found)
	{
		char_data = chars;
		hash = strhash(found.netname);
		while((char_data != world) && (char_data.cnt != hash))
		{
			char_data = char_data.chain2;
		}
		
		if (char_data == world)
		{
			char_data = spawn();
			setorigin(char_data, VEC_ORIGIN);
			setmodel(char_data, "models/null.spr");
			char_data.classname = "char_data";
			char_data.solid = SOLID_NOT;
			char_data.movetype = MOVETYPE_NOCLIP;
			char_data.hull = HULL_POINT;
			char_data.takedamage = DAMAGE_NO;
			char_data.cnt = strhash(found.netname);
			
			if (chars == world)
			{
				char_data.chain2 = world;
				chars = char_data;
			}
			else
			{
				char_data.chain2 = chars;
				chars = char_data;
			}
		}
		
		char_data.experience_value = found.experience;
		char_data.intelligence = found.intelligence;
		char_data.wisdom = found.wisdom;
		char_data.dexterity = found.dexterity;
		char_data.strength = found.strength;
		char_data.Lfinger1S = found.Lfinger1S;
		char_data.Lfinger2S = found.Lfinger2S;
		char_data.Lfinger3S = found.Lfinger3S;
		char_data.Lfinger4S = found.Lfinger4S;
		char_data.Lfinger5S = found.Lfinger5S;
		char_data.Rfinger1S = found.Rfinger1S;
		char_data.Rfinger2S = found.Rfinger2S;
		char_data.Rfinger3S = found.Rfinger3S;
		char_data.Rfinger4S = found.Rfinger4S;
		char_data.Rfinger5S = found.Rfinger5S;
		char_data.Lfinger1Support = found.Lfinger1Support;
		char_data.Lfinger2Support = found.Lfinger2Support;
		char_data.Lfinger3Support = found.Lfinger3Support;
		char_data.Lfinger4Support = found.Lfinger4Support;
		char_data.Lfinger5Support = found.Lfinger5Support;
		char_data.Rfinger1Support = found.Rfinger1Support;
		char_data.Rfinger2Support = found.Rfinger2Support;
		char_data.Rfinger3Support = found.Rfinger3Support;
		char_data.Rfinger4Support = found.Rfinger4Support;
		char_data.Rfinger5Support = found.Rfinger5Support;
		char_data.inv_spellmods = found.inv_spellmods;
		char_data.money = found.money;
		char_data.items = found.items;
		char_data.sheep = found.sheep;
		char_data.arrows = found.arrows;
		char_data.bluemana = found.bluemana;
		char_data.greenmana = found.greenmana;
		char_data.elemana = found.elemana;
		char_data.armor_amulet = found.armor_amulet;
		char_data.armor_bracer = found.armor_bracer;
		char_data.armor_breastplate = found.armor_breastplate;
		char_data.armor_helmet = found.armor_helmet;
		
		found.charsaved = 1.00000;
		found = find ( found, classname, "player");
	}
	
	//prune oldest chars
	char_data = chars;
	i = 0;
	while(char_data != world)
	{
		//dprintf("charlist: %s\n", char_data.cnt);

		if (i > 15)
		{
			if (lastchar != world)
				lastchar.chain2 = world;
			
			lastchar = char_data;
			char_data = char_data.chain2;
			
			remove(lastchar);
			lastchar = world;
		}
		else
		{
			lastchar = char_data;
			char_data = char_data.chain2;
		}
		
		i += 1;
	}
	//dprintf("charCount: %s\n", i);
	
};


void (entity forwhom)restorechar = {
	local entity char_data;
	local float hash;

	char_data = chars;
	if (forwhom != world)
		hash = strhash(forwhom.netname);
	
	while((char_data != world) && (char_data.cnt != hash))
	{
		char_data = char_data.chain2;
	}

	if (char_data != world)
	{
		dprint("Restoring Char: \n");
		dprint(forwhom.netname);
		dprint("\n");
		forwhom.experience = char_data.experience_value;
		AwardExperience ( forwhom, world, 1);
		forwhom.intelligence = char_data.intelligence;
		forwhom.wisdom = char_data.wisdom;
		forwhom.dexterity = char_data.dexterity;
		forwhom.strength = char_data.strength;
		forwhom.Lfinger1S = char_data.Lfinger1S;
		forwhom.Lfinger2S = char_data.Lfinger2S;
		forwhom.Lfinger3S = char_data.Lfinger3S;
		forwhom.Lfinger4S = char_data.Lfinger4S;
		forwhom.Lfinger5S = char_data.Lfinger5S;
		forwhom.Rfinger1S = char_data.Rfinger1S;
		forwhom.Rfinger2S = char_data.Rfinger2S;
		forwhom.Rfinger3S = char_data.Rfinger3S;
		forwhom.Rfinger4S = char_data.Rfinger4S;
		forwhom.Rfinger5S = char_data.Rfinger5S;
		forwhom.Lfinger1Support = char_data.Lfinger1Support;
		forwhom.Lfinger2Support = char_data.Lfinger2Support;
		forwhom.Lfinger3Support = char_data.Lfinger3Support;
		forwhom.Lfinger4Support = char_data.Lfinger4Support;
		forwhom.Lfinger5Support = char_data.Lfinger5Support;
		forwhom.Rfinger1Support = char_data.Rfinger1Support;
		forwhom.Rfinger2Support = char_data.Rfinger2Support;
		forwhom.Rfinger3Support = char_data.Rfinger3Support;
		forwhom.Rfinger4Support = char_data.Rfinger4Support;
		forwhom.Rfinger5Support = char_data.Rfinger5Support;
		forwhom.inv_spellmods = char_data.inv_spellmods;
		forwhom.money = char_data.money;
		forwhom.items = char_data.items;
		forwhom.sheep = char_data.sheep;
		forwhom.arrows = char_data.arrows;
		forwhom.bluemana = char_data.bluemana;
		forwhom.greenmana = char_data.greenmana;
		forwhom.elemana = char_data.elemana;
		forwhom.armor_amulet = char_data.armor_amulet;
		forwhom.armor_bracer = char_data.armor_bracer;
		forwhom.armor_breastplate = char_data.armor_breastplate;
		forwhom.armor_helmet = char_data.armor_helmet;

		//include weapons?
		
		forwhom.charsaved = 1.00000;
	}
};


void() gametype_think = {
	if (self.enemy.stepy == 0) {
		centerprint(self.enemy, "Gametype:@1:  Survivor@2: Heresy");
		if (self.enemy.selection == 1) {
			heresy = 0;
			survivor = 0;
			local entity found;
			found = nextent (world);
			while ( found ) {

				if ( (found.classname == "player") && (found.mage == 0) ) {
					stuffcmd(found, "impulse 55");
					make_mage(found);
				}
				found = find ( found, classname, "player");
			}

			self.enemy.selection = 0;
			self.enemy.shopping = 0;
			remove(self);
		}
		if (self.enemy.selection == 2) {
			self.enemy.stepy += 1;
			self.enemy.selection = 0;
		}
	}

	if (self.enemy.stepy == 1) {
		centerprint(self.enemy, "Time Limit:@1:  2:00@2:  3:00@3:  4:00@4:  5:00");
		if (self.enemy.selection == 1) {
			siege_time = 120;
			self.enemy.stepy += 1;
		}
		if (self.enemy.selection == 2) {
			siege_time = 180;
			self.enemy.stepy += 1;
		}
		if (self.enemy.selection == 3) {
			siege_time = 240;
			self.enemy.stepy += 1;
		}
		if (self.enemy.selection == 4) {
			siege_time = 300;
			self.enemy.stepy += 1;
		}
	}

	if (self.enemy.stepy == 2) {
		local entity found;
		found = nextent (world);
		while ( found ) {

			if ( (found.mage == 0) ) {
				sprint(found, "Time to destroy Chaos Sphere: ");
				sprint(found, ftos(siege_time));
				sprint(found, " seconds\n");
			}
			if ( (found.mage == 1) ) {
				sprint(found, "Time to defend Chaos Sphere: ");
				sprint(found, ftos(siege_time));
				sprint(found, " seconds\n");
			}

			found = find ( found, classname, "player");

		}
		heresy = 1;
		survivor = 0;
		self.enemy.selection = 0;
		self.enemy.shopping = 0;
		self.enemy.stepy = 0;
		select_mage();
		remove(self);
	}


	AdvanceThinkTime(self, 0.1);
	self.think = gametype_think;
};


void() gametype = {
	self.shopping = 1;
	newmis = spawn();
	newmis.enemy = self;
	AdvanceThinkTime(newmis, 0.1);
	newmis.think = gametype_think;
};

void() chaos_sphere_death = {
	local entity found;
	found = nextent (world);
	while ( found ) {

		if ( (found.classname == "player") && (found.mage == 1) ) {
			sound(found, 3, "chaos.wav", 1, 1);
			centerprint(found, "You are not worthy to guard the Chaos Sphere...");
			AdvanceThinkTime(found, 0.02);
			found.think = squelch;
		}
		if (found.mage == 0) {
			centerprint(found, "You have defeated the Chaos Sphere and its Mage!!");
		}
		found = find ( found, classname, "player");
	}
	AdvanceThinkTime(self, 0.02);
	self.think = chunk_death;
};

void() chaos_sphere_think = {
	local entity found;
	setorigin(self, self.stickydir);
	self.velocity = '0 0 0';
	if (heresy) {
		siege_time -= 1;
		if (siege_time < 1) {
			found = nextent (world);
			while ( found ) {
				if ( (found.classname == "player") && (found.mage == 0) ) {
					AdvanceThinkTime(found, 0.02);
					found.think = squelch;
				}
				if (found.mage == 1) {
					centerprint(found, "You have successfully defended the Chaos Sphere!!");
				}
				found = find ( found, classname, "player");
			}
		} else {
			if (self.cnt > 5) {
				self.cnt = 0;
				clap = 0;
				found = nextent (world);
				while ( found ) {
					if (found.flags2 & FL_ALIVE) {
						clap |= found.mage;
					}
					found = find ( found, classname, "player");
				}
				if (clap == 0) {
					select_mage();
				}
			} else {
				self.cnt += 1;
			}
		}
	}
	AdvanceThinkTime(self, 1);
	self.think = chaos_sphere_think;
};

void() baddie_bomb;

void() chaos_sphere_entity = {
	newmis = spawn();
	newmis.classname = "Chaos";
	setorigin(newmis, self.origin);
	newmis.stickydir = newmis.origin;
	newmis.movetype = MOVETYPE_FLY;
	newmis.mass = 9999;
	newmis.solid = SOLID_BBOX;
	newmis.takedamage = DAMAGE_YES;
	newmis.health = 350;
	newmis.thingtype = THINGTYPE_GREYSTONE;
	setmodel(newmis, "models/dwarf.mdl");
	setsize(newmis, '-4 -4 -25', '4 4 25');
	newmis.th_die = baddie_bomb;
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = chaos_sphere_think;
};


.float shepstate;

void() tell_flock = {
	local entity head;
	head = findradius ( self.origin, 300);
	traceline ((self.origin + self.proj_ofs) , ((self.origin + self.proj_ofs)+(v_forward * 450)) , FALSE , self);
	if ((trace_ent.takedamage == DAMAGE_YES) && (trace_ent.model != "models/sheep.mdl")) {
		self.shepstate = 2;
	} else {
		if (self.shepstate == 0) {
			self.shepstate = 1;
		} else {
			self.shepstate = 0;
		}
	}
	while (head)
	{
		if (head.model == "models/sheep.mdl") {
			if (self.shepstate == 1) {
				head.goalentity = self;
				head.enemy = self;
			} 
			if (self.shepstate == 2) {
				head.goalentity = trace_ent;
				head.enemy = trace_ent;
			}
			head.controller = self;
			if (self.shepstate == 0) {
				head.think = sheep_wait;
			} else {
				head.think = monster_sheep_run;
			}
			if ((head.classname != "player") && (head.classname != "woolysheep"))
			{
				head.classname = "woolysheep";
				head.controller = self;
				self.sheep += 1;
			}
		}
		head = head.chain;
	}
	sound ( self, CHAN_AUTO, "ambience/birds.wav", 1.00000, ATTN_NORM);
};



void() make_flock = {
	
	local float i;
	local entity found;
	
	found = find ( world, classname, "woolysheep");
	while ( found ) {
		
		if (found.controller == self)
			remove(found);
		
		found = find ( found, classname, "woolysheep");
	}
	
	
	i = 1;
	while (self.sheep > 0) {
		newmis = spawn();

		setorigin(newmis, self.origin);

		
		CreateEntityNew ( newmis, ENT_SHEEP, "models/sheep.mdl", chunk_death);

		if (i > 0) {
			if ((self.sheep / 2.0) == ceil(self.sheep / 2.0)) {
				newmis.origin_x += (i * 40);
			} else {
				newmis.origin_y += (i * 40);
				i *= -1;
			}
		} else {
			if (((self.sheep * -1) / 2.0) == ceil((self.sheep * -1) / 2.0)) {
				newmis.origin_x += (i * 40);
			} else {
				newmis.origin_y += (i * 40);
				i -= 1;
				i *= -1;
			}
		}
		newmis.th_pain = sheep_pain;
		newmis.touch = obj_push;
		newmis.flags |= FL_PUSH;
		newmis.flags2 |= FL_ALIVE;
		newmis.yaw_speed = 2.00000;
		newmis.controller = self;
		//newmis.classname = "woolysheep";
		AdvanceThinkTime(newmis, 0.02);
		newmis.think = sheep_graze_a;
		self.sheep -= 1;
	}
	
	/*
	found = nextent (world);
	while ( found ) {

		found.sheep = 0;
		found = find ( found, classname, "player");
	}
	*/

};









/*
void() map_changer_think = {
if (self.enemy.stepy == 0) {
	centerprint(self.enemy, "If you have the map pack,@Choose a map category@1:  single player@2:  dm@3:  heresy");
	if (self.enemy.selection == 1) {
		self.enemy.stepy = 1;
		self.enemy.selection = 0;
	}
	if (self.enemy.selection == 2) {
		self.enemy.stepy = 2;
		self.enemy.selection = 0;
	}
	if (self.enemy.selection == 3) {
		self.enemy.stepy = 3;
		self.enemy.selection = 0;
	}
}

if (self.enemy.stepy == 1) {
	centerprint(self.enemy, "Choose a single player map@1:  Fortress of 4 Doors@((Special feature mission pack!!))@2:  Outdoors@3:  Discourtious Bisect@4:  Temple Chaos");
	if (self.enemy.selection == 1) {
		localcmd("map hexn1\n");
	}
	if (self.enemy.selection == 2) {
		localcmd("map dram9\n");
	}
	if (self.enemy.selection == 3) {
		localcmd("map martimh2\n");
	}
	if (self.enemy.selection == 4) {
		localcmd("map temchaos\n");

	}
}


if (self.enemy.stepy == 2) {
	centerprint(self.enemy, "Choose a DM map size@1:  small@2:  big");
	if (self.enemy.selection == 1) {
		self.enemy.selection = 0;
		self.enemy.stepy = 4;
	}
	if (self.enemy.selection == 2) {
		self.enemy.selection = 0;
		self.enemy.stepy = 5;
	}
}

if (self.enemy.stepy == 3) {
	centerprint(self.enemy, "Choose a heresy map@1:  bar n tower");
	if (self.enemy.selection == 1) {
		localcmd("map newsiege9\n");
	}
}


if (self.enemy.stepy == 4) {
	centerprint(self.enemy, "Choose a small DM map@1:  AD arena@2:  be quick@3:  cipdm@4:  cowabunga@5:  gauntlet@6:  havdm1@7:  helix@8:  inchwdm5@9:  kinghill@10:  (next page)");
	if (self.enemy.selection == 1) {
		localcmd("map adarena1\n");
	}
	if (self.enemy.selection == 2) {
		localcmd("map bequick\n");
	}
	if (self.enemy.selection == 3) {
		localcmd("map cipdm1b2\n");
	}
	if (self.enemy.selection == 4) {
		localcmd("map cowabunga\n");
	}
	if (self.enemy.selection == 5) {
		localcmd("map gauntlet\n");
	}
	if (self.enemy.selection == 6) {
		localcmd("map havdm1\n");
	}
	if (self.enemy.selection == 7) {
		localcmd("map helix\n");
	}
	if (self.enemy.selection == 8) {
		localcmd("map inchwdm5\n");
	}
	if (self.enemy.selection == 9) {
		localcmd("map kinghill\n");
	}
	if (self.enemy.selection == 10) {
		self.enemy.stepy = 6;
		self.enemy.selection = 0;
	}
}


if (self.enemy.stepy == 5) {
	centerprint(self.enemy, "Choose a big DM map@1:  agony@2:  agony2@3:  apocalypse@4:  assultdm@5:  asylum@6:  breakdown@7:  dark coliseum@8:  citadel@9:  outdoors@10:  (next page)");
	if (self.enemy.selection == 1) {
		localcmd("map agony\n");
	}
	if (self.enemy.selection == 2) {
		localcmd("map agony2\n");
	}
	if (self.enemy.selection == 3) {
		localcmd("map apocalypse\n");
	}
	if (self.enemy.selection == 4) {
		localcmd("map assultdm\n");
	}
	if (self.enemy.selection == 5) {
		localcmd("map asylum\n");
	}
	if (self.enemy.selection == 6) {
		localcmd("map breakdown\n");
	}
	if (self.enemy.selection == 7) {
		localcmd("map darkcoliseum2\n");
	}
	if (self.enemy.selection == 8) {
		localcmd("map dmcitadel\n");
	}
	if (self.enemy.selection == 9) {
		localcmd("map dram13\n");
	}
	if (self.enemy.selection == 10) {
		self.enemy.stepy = 7;
		self.enemy.selection = 0;
	}
}



if (self.enemy.stepy == 6) {
	centerprint(self.enemy, "Choose a small DM map@1:  lostabusers@2:  lostart@3:  lostfighters@4:  lostsheep@5:  lw1h2dm@6:  lw2h2dm@7:  n2@8:  n5@9: q1dm4@10:  rbdm");
	if (self.enemy.selection == 1) {
		localcmd("map lostabusers\n");
	}
	if (self.enemy.selection == 2) {
		localcmd("map lostart\n");
	}
	if (self.enemy.selection == 3) {
		localcmd("map lostfighters\n");
	}
	if (self.enemy.selection == 4) {
		localcmd("map lostsheep\n");
	}
	if (self.enemy.selection == 5) {
		localcmd("map lw1h2dm\n");
	}
	if (self.enemy.selection == 6) {
		localcmd("map lw2h2dm\n");
	}
	if (self.enemy.selection == 7) {
		localcmd("map n2\n");
	}
	if (self.enemy.selection == 8) {
		localcmd("map n5\n");
	}
	if (self.enemy.selection == 9) {
		localcmd("map q1dm4\n");
	}
	if (self.enemy.selection == 10) {
		localcmd("map rbdm\n");
	}
}


if (self.enemy.stepy == 7) {
	centerprint(self.enemy, "Choose a big DM map@1:  egypt@2:  foadfactory@3:  h2dmx1@4:  harbour@5:  osiris@6:  temple@7:  tomb@8:  inchwdm3@9:  inchwdm4@10:  (next page)");
	if (self.enemy.selection == 1) {
		localcmd("map egypthwdm\n");
	}
	if (self.enemy.selection == 2) {
		localcmd("map foadfactory\n");
	}
	if (self.enemy.selection == 3) {
		localcmd("map h2dmx1\n");
	}
	if (self.enemy.selection == 4) {
		localcmd("map harbour\n");
	}
	if (self.enemy.selection == 5) {
		localcmd("map hwosiris\n");
	}
	if (self.enemy.selection == 6) {
		localcmd("map hwtemple\n");
	}
	if (self.enemy.selection == 7) {
		localcmd("map hwtomb\n");
	}
	if (self.enemy.selection == 8) {
		localcmd("map inchwdm3\n");
	}
	if (self.enemy.selection == 9) {
		localcmd("map inchwdm4\n");
	}
	if (self.enemy.selection == 10) {
		self.enemy.stepy = 8;
		self.enemy.selection = 0;
	}
}


if (self.enemy.stepy == 8) {
	centerprint(self.enemy, "Choose a big DM map@1:  int18@2:  kinghill2@3:  kinghill3@4:  lavagarden@5:  lovelava@6:  martimh1@7:  modhwdm1@8:  mouthofhell@9:  n1@10:  (next page)");
	if (self.enemy.selection == 1) {
		localcmd("map int18\n");
	}
	if (self.enemy.selection == 2) {
		localcmd("map kinghill2\n");
	}
	if (self.enemy.selection == 3) {
		localcmd("map kinghill3\n");
	}
	if (self.enemy.selection == 4) {
		localcmd("map lavagarden\n");
	}
	if (self.enemy.selection == 5) {
		localcmd("map lovelava\n");
	}
	if (self.enemy.selection == 6) {
		localcmd("map martimh1\n");
	}
	if (self.enemy.selection == 7) {
		localcmd("map modhwdm1\n");
	}
	if (self.enemy.selection == 8) {
		localcmd("map mouthofhell\n");
	}
	if (self.enemy.selection == 9) {
		localcmd("map n1\n");
	}
	if (self.enemy.selection == 10) {
		self.enemy.stepy = 9;
		self.enemy.selection = 0;
	}
}



if (self.enemy.stepy == 9) {
	centerprint(self.enemy, "Choose a big DM map@1:  pmid16@2:  q1dm3@3:  q1dm6@4:  sibh2dm1@5:  speeed@6:  streets@7:  towerdeath@8:  unholy@9:  worldmix@10:  (next page)");
	if (self.enemy.selection == 1) {
		localcmd("map pmid16\n");
	}
	if (self.enemy.selection == 2) {
		localcmd("map q1dm3\n");
	}
	if (self.enemy.selection == 3) {
		localcmd("map q1dm6\n");
	}
	if (self.enemy.selection == 4) {
		localcmd("map sibh2dm1\n");
	}
	if (self.enemy.selection == 5) {
		localcmd("map speeed\n");
	}
	if (self.enemy.selection == 6) {
		localcmd("map streets\n");
	}
	if (self.enemy.selection == 7) {
		localcmd("map towerdeath\n");
	}
	if (self.enemy.selection == 8) {
		localcmd("map unholy\n");
	}
	if (self.enemy.selection == 9) {
		localcmd("map worldmix\n");
	}
	if (self.enemy.selection == 10) {
		self.enemy.stepy = 10;
		self.enemy.selection = 0;
	}
}


if (self.enemy.stepy == 10) {
	centerprint(self.enemy, "Choose a big DM map@1:  wpdm1@2:  promenade@10:  (next page)");
	if (self.enemy.selection == 1) {
		localcmd("map wpdm1\n");
	}
	if (self.enemy.selection == 2) {
		localcmd("map prom\n");
	}
	if (self.enemy.selection == 10) {
		self.enemy.stepy = 5;
		self.enemy.selection = 0;
	}
}



if (self.enemy.stepy == 11) {
	self.enemy.selection = 0;
	self.enemy.shopping = 0;
	self.enemy.stepy = 0;
	remove(self);
}

AdvanceThinkTime(self, 0.1);
self.think = map_changer_think;
};



void() map_changer = {
	self.shopping = 1;
	newmis = spawn();
	newmis.enemy = self;
	AdvanceThinkTime(newmis, 0.1);
	newmis.think = map_changer_think;
};

*/


void(string lastmap) enter_magic_shop = {
	local entity found;
	local float go;

	found = nextent (world);
	while ( found ) {

		if (found.classname == "player") {
			if (found.blizzcount == 0) {
				found.nexttarget = lastmap;
				go = 1;
				found.pos2 = found.origin;
				found.blizzcount = 2;
			} else {
				go = 0;
				found.blizzcount = 1;
			}
		}
		found = find ( found, classname, "player");
	}
	if (go == 1) {
		changelevel("peanutshop", found.target);
	} else {
		if (self.predebt == 0) {
			changelevel(self.map, found.target);
		}
	}
};


void() cleanup_objects =
{
	local entity found;

	found = find ( world, classname, "player");
	while ( found ) {

		found.predebt = 0;
		found.click = 0;
		found.spellfired = 0;
		found.cskin = 0;
		found.handy = 0;
		found.menuhand = 0;

		found = find ( found, classname, "player");
	}
	
	found = find ( world, classname, "woolysheep");
	while ( found ) {

		remove(found);
		found = find ( found, classname, "woolysheep");
	}

	found = find ( world, classname, "finger");
	while ( found ) {

		remove(found);
		found = find ( found, classname, "finger");
	}

	found = find ( world, classname, "shopportal");
	while ( found ) {

		remove(found);
		found = find ( found, classname, "shopportal");
	}
};


void() magic_shop_portal_think = {
	local float total, net;
	local entity found, first;

	found = find ( world, classname, "player");
	first = world;
	total = 0;
	net = 0;

	while ( found ) {

		if (mapname == "peanutshop")
		{
			if (found.nexttarget != "")
			{
				self.map = found.nexttarget;
			}
		}
		total += 1;
		if (vlen(found.origin - self.origin) <= 120)
		{
			if (first == world)
				first = found;
			else
			{
				found.chain = first;
				first = found;
			}
			
			net += 1;
		}
		
		found = find ( found, classname, "player");
	}
	if (net == total) {
		cleanup_objects();
		//		remove(self);
		enter_magic_shop(mapname);
	} else {
		if (net > 0)
		{
			found = first;
			while (found)
			{
				centerprint(found, "Where is my friend?");
				found = found.chain;
			}
		}
		
		AdvanceThinkTime(self, 1.00000);
		self.think = magic_shop_portal_think;
	}
};

void() magic_shop_portal = {
	local entity found;
	
	newmis = find ( world, classname, "shopportal");
	while ( newmis ) {

		remove(newmis);
		newmis = find ( newmis, classname, "shopportal");
	}
	
	newmis = spawn();
	if (mapname == "peanutshop")
	{
		setorigin(newmis, '869 430 36');
		newmis.angles_y = 45;
	}
	else
	{
		traceline (self.origin , (self.origin - '0 0 500') , TRUE , self);
		setorigin (newmis, trace_endpos);
		newmis.angles_y = self.angles_y;
		self.map = "peanutshop";
	}
	
	setmodel(newmis, "maps/portal.bsp");
	setsize(newmis, '-60 -60 0', '60 60 120');
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.classname = "shopportal";
	AdvanceThinkTime(newmis, 5.00000);
	newmis.think = magic_shop_portal_think;
};



float(vector spot, float radius) sense_furniture = {
	local float total, net;
	local entity found;
	found = nextent (world);
	total = 0;
	net = 0;
	while ( found ) {

		if (found.lastweapon == "furniture") {
			if (vlen(found.origin - spot) <= radius) {
				net += 1;
			}
			total += 1;
		}
		found = find ( found, lastweapon, "furniture");
	}

	if (total > 0) {
		return ceil((net / total) * 100);
	} else {
		return 100;
	}

};


void() furniture_sensor_think = {

	if (sense_furniture(self.origin, 128) == 100) {
		bprint ( "Finished!\n");
	}
	AdvanceThinkTime(self, 2.00000);
	self.think = furniture_sensor_think;
};



void() furniture_sensor = {
	newmis = spawn();
	traceline (self.origin , (self.origin - '0 0 500') , TRUE , self);
	setorigin (newmis, trace_endpos);
	setmodel(newmis, "models/dwarf.mdl");
	setsize(newmis, '-60 -60 0', '60 60 120');
	newmis.angles_y = self.angles_y;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	AdvanceThinkTime(newmis, 5.00000);
	newmis.think = furniture_sensor_think;
};