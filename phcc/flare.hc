void()CrashFlash;
void() flare_rings_wipe =
{
	if (time < self.splash_time)
	{
		self.scale = ((1.00000 - ((self.splash_time - time) / self.lifetime)) * (1.65000*self.spellradiusmod));
		if (self.scale < 1.0) {
			sound (self, CHAN_AUTO, "exp3.wav", 1, ATTN_NORM);
		}
		AdvanceThinkTime(self, HX_FRAME_TIME);
		self.think = flare_rings_wipe;
	} else {
		AdvanceThinkTime(self, 0.02);
		self.think = SUB_Remove;
	}
};
void() flare_rings =
{
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	newmis.effects = EF_BRIGHTLIGHT;
	newmis.lifetime = 0.36250;
	newmis.splash_time = time + newmis.lifetime;
	setorigin(newmis, self.origin);
	newmis.movetype = MOVETYPE_NONE;
	newmis.solid = SOLID_NOT;
	newmis.scale = 0.02;
	setmodel(newmis, "models/expring.mdl");
	newmis.drawflags |= ((MLS_ABSLIGHT) | (DRF_TRANSLUCENT));
	newmis.abslight = 1.5;
	//sound (newmis, CHAN_WEAPON, "exp3.wav", 1, ATTN_NORM);
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = flare_rings_wipe;

};

void() flare_wipe = {
	local entity head;
	local vector random_vector = '0.00000 0.00000 0.00000';
	
	if (time < self.splash_time)
	{
		self.scale = ((1.00000 - ((self.splash_time - time) / self.lifetime)) * (1.65000*self.spellradiusmod));
		
		self.cnt = 5;
		while ( (self.cnt > 0) ) {
			random_vector_x = random((self.scale * -225.00000),(self.scale * 225.00000));
			random_vector_y = random((self.scale * -225.00000),(self.scale * 225.00000));
			random_vector_z = random((self.scale * -225.00000),(self.scale * 225.00000));
			
			self.cnt -= 1;
			if ( (random() > 0.80000) ) {
				CreateExplosion29 ( (self.origin + random_vector));
			} else {
				CreateFireCircle ( (self.origin + random_vector));
			}
		}
		
		head = findradius ( self.origin, self.scale * (355.00000*self.spellradiusmod));
		while (head)
		{
			//if ((head.takedamage == DAMAGE_YES) && visible2ent(head, self) && (head != self.owner)) {
			//if ((head.takedamage == DAMAGE_YES) && (head != self.owner)) {
			if ((head.takedamage == DAMAGE_YES) && (visible2ent(head, self) || (head.solid == SOLID_BSP)) && (head != self.owner)) {
				T_Damage (head, self, self.owner, self.spelldamage + random(self.spelldamage*(-0.25000), self.spelldamage*0.25000));
			}
			head = head.chain;
		}
		
		AdvanceThinkTime(self, 0.12500);
		self.think = flare_wipe;
	} 
	else 
	{
		remove(self);
	}
};

void() flare_blast =
{
	local entity found;

	found = nextent (world);

	while ( found ) {

		if ( (found.classname == "player") ) {

			sound (found, CHAN_BODY, "exp3.wav", 1, ATTN_NORM);
			MonsterQuake(200.0, found);

		}
		found = find ( found, classname, "player");
	}

	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.lifetime = 3.00000;
	newmis.splash_time = time + newmis.lifetime;
	newmis.owner = self.owner;
	newmis.effects = EF_BRIGHTLIGHT;
	setorigin(newmis, self.origin);
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.solid = SOLID_NOT;
	newmis.scale = 0.02;
	setmodel(newmis, "models/nukeball.mdl");
	newmis.avelocity_y = random(-200.00000, 200.00000);
	newmis.drawflags |= ((MLS_ABSLIGHT) | (DRF_TRANSLUCENT));
	newmis.abslight = 1.00000;
	sound (newmis, CHAN_WEAPON, "exp3.wav", 1, ATTN_NORM);
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = flare_wipe;
};

void() flare_build =
{
	if (self.model != "models/star2.mdl") {
		self.flags ^= FL_ONGROUND;
		self.movetype = MOVETYPE_FLY;
		self.scale = 2.5;
		self.origin += '0 0 80';
		self.drawflags |= ((MLS_ABSLIGHT) | (DRF_TRANSLUCENT));
		self.abslight = 2;
		self.avelocity = '300 300 300';
		setmodel(self, "models/star2.mdl");
	}
	if (self.scale>0.05) {
		self.scale -= 0.04;
		AdvanceThinkTime(self, 0.02);
		self.think = flare_build;
	} else {
		AdvanceThinkTime(self, 0.02);
		self.think = GasserThink;
	}

};

void() flare_drop = {
	self.classname = "flare";
	CrashFlash();
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	newmis.classname = "flare";
	newmis.hull = HULL_POINT;
	setorigin (newmis, self.origin);
	newmis.solid = SOLID_NOT;
	newmis.scale = 0.2;
	newmis.movetype = MOVETYPE_FLY;
	newmis.think = flare_build;
	newmis.nextthink = (time + 0.02);
};

//		particle2 ( (self.origin + random('-30 -30 0', '30 30 100')), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(128, 143), 2, 80.00000);
