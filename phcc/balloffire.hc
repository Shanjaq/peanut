void() splashy;
void() firewave_touch;
void() FireWaveThink;
void (float radius, float duration, entity source)ShockWave;

void() bubble_bob;

void() bubble_spawner_think = {
	local entity bubble;
	local float pc;
	
	pc = pointcontents(self.origin);
	if ( (((pc == CONTENT_WATER) || (pc == CONTENT_SLIME)) || (pc == CONTENT_LAVA)) )
	{
		bubble = spawn_temp ( );
		setmodel ( bubble, "models/s_bubble.spr");
		setorigin ( bubble, self.origin);
		bubble.movetype = MOVETYPE_NOCLIP;
		bubble.solid = SOLID_NOT;
		bubble.velocity = '0.00000 0.00000 17.00000';
		AdvanceThinkTime(bubble,0.50000);
		bubble.think = bubble_bob;
		bubble.classname = "bubble";
		bubble.frame = 0.00000;
		bubble.cnt = 0.00000;
		bubble.abslight = 0.50000;
		bubble.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
		setsize ( bubble, '-8.00000 -8.00000 -8.00000', '8.00000 8.00000 8.00000');
	}
	self.think = bubble_spawner_think;
	AdvanceThinkTime(self, HX_FRAME_TIME);
};

void() balloffire_water_blast = {
	if (self.cnt == 0)
	{
		T_RadiusDamageFlat (self, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*3.60000, 200.00000 * self.spellradiusmod, self.owner, FALSE);
		//MonsterQuake ( 400.00000, self);  
		ShockWave(400, 0.5, self);
		self.movetype = MOVETYPE_NOCLIP;
		self.solid = SOLID_NOT;
		self.avelocity = '0 0 0';
		self.velocity = '0 0 0';
		self.angles_z = 0;
		self.angles_x = 0;
		setmodel(self, "models/blast.mdl");
		self.skin = 0;
		//sound (newmis, CHAN_WEAPON, "deepexp.wav", 1, ATTN_NORM); 
		sound (newmis, CHAN_WEAPON, "eidolon/stomp.wav", 1, ATTN_NORM); 
		sound (newmis, CHAN_WEAPON, "eidolon/stomp.wav", 1, ATTN_NORM); 
		self.drawflags |= ((MLS_ABSLIGHT) | (DRF_TRANSLUCENT) | (SCALE_TYPE_XYONLY));
		self.abslight = 1;
		//self.skin = 5;
		self.cnt += 1;
	}
	
	if (self.cnt == 1)
	{
		if (time < self.splash_time)
		{
			particle2 ( self.origin + (random('-64 -64 -64', '64 64 64') * self.scale) - '0 0 64', '-7.00000 -7.00000 150.00000', '7.00000 7.00000 300.00000', 255.00000, 17, random(48.00000, 72.00000));
			setorigin (self.oldenemy, self.origin + (random('-64 -64 -64', '64 64 64') * self.scale));
			self.goalentity.lip = (self.scale * 64);
			self.scale = ((1.00000 - ((self.splash_time - time) / self.lifetime)) * 2.50000);
			self.abslight = ((self.splash_time - time) / self.lifetime);
			self.think = balloffire_water_blast;
			AdvanceThinkTime(self, HX_FRAME_TIME);
		}
		else
		{
			self.cnt += 1;
			self.skin = 1;
			//self.drawflags ^= SCALE_TYPE_XYONLY;
			self.lifetime = 0.36250;
			self.splash_time = (time + self.lifetime);
			self.think = balloffire_water_blast;
			AdvanceThinkTime(self, HX_FRAME_TIME);
		}
	}
	else if (self.cnt == 2)
	{
		if (time < self.splash_time)
		{
			particle2 ( self.origin + (random('-64 -64 -64', '64 64 64') * self.scale) - '0 0 64', '-7.00000 -7.00000 150.00000', '7.00000 7.00000 300.00000', 255.00000, 17, random(48.00000, 72.00000));
			setorigin (self.oldenemy, self.origin + (random('-64 -64 -64', '64 64 64') * self.scale));
			self.scale = (((self.splash_time - time) / self.lifetime) * 2.50000);
			self.abslight = (1.00000 - ((self.splash_time - time) / self.lifetime));
			self.think = balloffire_water_blast;
			AdvanceThinkTime(self, HX_FRAME_TIME);
		}
		else
		{
			remove(self.oldenemy);
			remove(self);
		}
	}
};

void() balloffire_crash = {
	local entity found;
	if (self.classname != "swelterment") {
		if ((other == self.owner) || (other.solid == SOLID_TRIGGER)) {
			return;
		}
	}
	if (other.movetype == MOVETYPE_FLYMISSILE || other.movetype == MOVETYPE_BOUNCEMISSILE)
		return;

	self.dmg = (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500));
	self.spelldamage *= 0.25000;
	
	if (other.takedamage == DAMAGE_YES)
	{
		T_Damage ( other, self, self.owner, self.dmg);
		if (other.flags & FL_ONGROUND) {
			other.flags ^= FL_ONGROUND;
		}
		other.velocity += random('-32 -32 10', '32 32 24');
		
		if (random() < 0.63750)
			apply_status(other, STATUS_BURNING, (self.spelldamage * 0.12500), 8);
	}
	
	found = T_RadiusDamageFlat (self, self.owner, self.dmg, 75.00000 * self.spellradiusmod, other, FALSE);
	if (self.classname == "balloffire") {
		//if (!(coop) && !(deathmatch))
		while (found)
		{
			if (random() < 0.5)
				apply_status(found, STATUS_BURNING, (self.spelldamage * 0.12500), 8);
			
			found = found.chain2;
		}
	
		lavamess((random(1, 3) * self.spellradiusmod), (10 * self.spellradiusmod), 100);
	}
	
	sound (self, CHAN_WEAPON, "raven/littorch.wav", 1, ATTN_NORM); 
	particle2 ( self.origin, '-30.00000 -30.00000 -30.00000', '30.00000 30.00000 30.00000', 255.00000, PARTICLETYPE_EXPLODE, random(64.00000, 96.00000));
	self.auraV = 1;
	self.cscale = 1.2 * self.spellradiusmod;
	splashy();
	remove(self);
};

void  (float num_bubbles)DeathBubbles;



void() balloffire_fly = {
	local float pc;
	if (self.lifetime > 0) {
		pc = pointcontents(self.origin);
		if ( (((pc == CONTENT_WATER) || (pc == CONTENT_SLIME)) || (pc == CONTENT_LAVA)) ) {
			self.goalentity = firefizz_smoke_generator();
			self.goalentity.dest = self.origin;
			self.oldenemy = spawn();
			self.oldenemy.think = bubble_spawner_think;
			AdvanceThinkTime(self.oldenemy, HX_FRAME_TIME);
			self.cnt = 0;
			sound (newmis, CHAN_WEAPON, "bombinriver.wav", 1, ATTN_NORM);
			self.touch = SUB_Null;
			self.think = balloffire_water_blast;
			self.skin = 0;
			self.lifetime = 0.25000;
			self.splash_time = (time + self.lifetime);
			AdvanceThinkTime(self, HX_FRAME_TIME);
		}
		else
		{
			particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 140.00000, 16, 10.00000);
			if (self.skin >= 2) {
				self.skin = 0;
			} else {
				self.skin += 1;
			}
			self.angles = vectoangles(self.velocity); 
			self.lifetime -= 1;
			AdvanceThinkTime(self, 0.1);
			self.think = balloffire_fly;
		}
	} else {
		remove(self);
	}
};

void() balloffire_launch = {

	local vector vec;
	makevectors (self.angles);
	vec = normalize(v_forward);
	self.magic_finished = (time + 2);
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	//traceline (self.origin , (self.origin+(vec * 55)) , FALSE , self);
	//setorigin (newmis, trace_endpos);
	setorigin (newmis, self.origin);
	sound (newmis, CHAN_WEAPON, "weapons/vorppwr.wav", 1, ATTN_NORM); 

	setmodel(newmis, "models/fball1.mdl");
	setsize(newmis, '0 0 0', '0 0 0');
	newmis.owner = self.owner;
	newmis.velocity = (vec * 1200);

	newmis.angles = vectoangles(newmis.velocity); 
	newmis.avelocity_z = 200.00000;
	newmis.lifetime = 50;
	newmis.classname = "balloffire";
	newmis.cnt = random(3, 10);
	newmis.scale = 1.00000 * newmis.spellradiusmod;
	newmis.solid = SOLID_BBOX;
	newmis.movetype = MOVETYPE_TOSS;
	
	newmis.drawflags |= (MLS_ABSLIGHT | MLS_FIREFLICKER);
	newmis.effects = EF_DIMLIGHT;
	//newmis.drawflags = MLS_ABSLIGHT;
	//newmis.effects = EF_LIGHT;
	newmis.abslight = 1;
	newmis.exploderadius = 1;
	newmis.touch = balloffire_crash;
	AdvanceThinkTime(newmis, 0.1);
	newmis.think = balloffire_fly;
};
