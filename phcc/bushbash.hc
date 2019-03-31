
void() bushbash_bit_wither = {
	self.drawflags |= SCALE_TYPE_ZONLY;
	AdvanceThinkTime(self, 0.1);
	self.think = ChunkShrink;
};

void() bushbash_bit_spike = {
	if (self.cnt < 3) {
		self.cnt = self.cnt + 1;
		sound ( self, CHAN_VOICE, "weapons/gauntht1.wav", 1.00000, ATTN_NORM);
		particle2 ( (self.origin + random('-30 -30 0', '30 30 300')), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(96, 104), 2, 80.00000);
		AdvanceThinkTime(self, 0.04);
		self.think = bushbash_bit_spike;
	} else {
		AdvanceThinkTime(self, random(9.00000, 17.00000));
		self.think = bushbash_bit_wither;
	}
};

void() bushbash_bit_grow = {
	if (self.scale < 1.2) {
		self.scale += 0.1;
		AdvanceThinkTime(self, 0.05);
		self.think = bushbash_bit_grow;
	} else {
		AdvanceThinkTime(self, 0.05);
		self.think = bushbash_bit_spike;
	}
};

void() bushbash_bit =
{
	newmis = spawn();
	newmis.owner = world;
	newmis.controller = self.owner;
	newmis.solid = SOLID_BBOX;
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.takedamage = DAMAGE_YES;
	newmis.thingtype = THINGTYPE_WOOD_LEAF;
	newmis.health = random(36, 84);
	newmis.mass = 9999;
	newmis.scale = 0.02;
	newmis.dest = self.origin + (random('-64 -64 0', '64 64 0') * self.spellradiusmod);
	setmodel(newmis, "models/bushbash.mdl");
	traceline (newmis.dest+('0 0 196'), (newmis.dest-('0 0 800')) , TRUE , self);
	setorigin(newmis, trace_endpos);
	newmis.frame = random(1, 4);
	newmis.classname = "basher";
	newmis.angles = random('0 -180 0', '0 180 0');
	setsize (newmis, '-24 -24 0', '24 24 96');
	newmis.th_die = cage_break;
	newmis.think = bushbash_bit_grow;
	AdvanceThinkTime(newmis, 0.1);
	
	if (T_RadiusDamageFlat (newmis, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*(1.00000 / self.cnt), 64.00000 * self.spellradiusmod, self.owner, DFL_SKIP_WOOD))
	{
		sound ( newmis, CHAN_VOICE, "weapons/gauntht1.wav", 1.00000, ATTN_NORM);
		particle2 ( (newmis.origin + random('-30 -30 0', '30 30 300')), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(96, 104), 2, 80.00000);
	}
};

void() bushbash_bash = {
	if (self.jones)
	{
		traceline (self.jones.origin , (self.jones.origin-('0 0 800')) , TRUE , self);
		if ((self.jones.origin_z - trace_endpos_z) < 120) {
			if ((self.jones.thingtype == THINGTYPE_FLESH) && (self.jones.netname != "spider")) {
				bloodymess();
			}
		}
	}
	self.think = SUB_Remove;
	AdvanceThinkTime(self, 8.00000);
};

void (entity holdee) bushbash_hold = {
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	newmis.jones = holdee;
	newmis.solid = SOLID_BBOX;
	newmis.movetype = MOVETYPE_FLY;
	newmis.mass = 9999;
	setorigin (newmis, (holdee.origin + '0 0 30'));
	setsize (newmis, '-40 -40 -40', '40 40 40');
	newmis.think = bushbash_bash;
	AdvanceThinkTime(newmis, 0.6);
};

void() bushbash_touch = {
	local float i;
	local entity found;
	
	if ( (deathmatch || coop) )
	{
		found = find(world, classname, "basher");
		while ( found ) {
			if ((found != world) && (found.controller == self.owner))
			{
				found.think = bushbash_bit_wither;
				AdvanceThinkTime(found, HX_FRAME_TIME);
			}
			
			found = find ( found, classname, "basher");
		}
	}
	
	if (other.flags & FL_ONGROUND) {
		setorigin(self, other.origin);
	} else {
		traceline (self.origin , (self.origin-('0 0 600')) , TRUE , self);
		setorigin(self, trace_endpos);
	}
	
	if ((other.takedamage == DAMAGE_YES) && (other.solid != SOLID_BSP)) {
		bushbash_hold(other);
	}
	
	self.cnt = (random(5, 7) * self.spellradiusmod);
	while (i < self.cnt)
	{
		bushbash_bit();
		i += 1;
	}
	
	remove(self);
};

//	particle2 ( (self.origin + random('-30 -30 -30', '30 30 30')), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(98, 108), 2, 80.00000);
