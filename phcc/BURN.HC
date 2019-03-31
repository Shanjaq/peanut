void  (entity victim, float amount)ignite;

void ()burn_flame_think = {
	if (time < self.splash_time)
	{
		if (self.oldenemy.health)
		{
			setorigin (self, random(self.oldenemy.absmin, self.oldenemy.absmax));
			if (self.oldenemy.lockentity != world)
				self.scale = (0.75000 + ((self.oldenemy.lockentity.dmg / 10.00000) * 1.6)) * random();
			else
				self.scale = (0.75000 * random());
		}
		else
		{
			setorigin (self, self.owner.origin + random('-32 -32 0', '32 32 12'));
			self.scale = (0.75000 * random());
		}
		
		if ((self.owner != world) && (self.owner.auraV))
			self.splash_time = time;
		
		particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 140.00000, 16, random(4.00000, 10.00000));
		self.think = burn_flame_think;
		AdvanceThinkTime(self, 0.16250);
	}
	else
	{
		if (self.owner != world)
			self.owner.stepy -= 1;
		self.think = ChunkShrink;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
};

void ()burn_flame = {
	newmis = spawn();
	newmis.owner = self;
	newmis.oldenemy = self.oldenemy;
	newmis.hull = HULL_POINT;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	setmodel (newmis, "models/flamec.mdl");
	newmis.classname = "flame";
	
	if (self.oldenemy.health)
		setorigin (newmis, newmis.oldenemy.origin);
	else
		setorigin (newmis, self.origin);
	
	newmis.angles_x = 270;
	newmis.drawflags |= (MLS_ABSLIGHT | DRF_TRANSLUCENT);
	newmis.effects = EF_DIMLIGHT;
	newmis.abslight = 1.00000;
	newmis.lifetime = 3.00000;
	newmis.splash_time = (time + newmis.lifetime);
	AdvanceThinkTime(newmis, 0.1);
	newmis.think = burn_flame_think;
};

void ()burn_think = {
	local float average_width;
	local float  pc;
	
	pc = pointcontents (self.origin);
	if ((pc == CONTENT_WATER) || (pc == CONTENT_SLIME) || (self.auraV == 1))
	{
		if (self.oldenemy.health)
		{
			if (self.oldenemy.status_effects & STATUS_BURNING)
				self.oldenemy.status_effects ^= STATUS_BURNING;
			
			self.oldenemy.lockentity = world;
		}
		sound (self, CHAN_WEAPON, "misc/fout.wav", 1, ATTN_NORM);
		self.classname = "fizz_generator";
		setsize ( self, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
		self.th_die = SUB_Remove;
		self.think = smoke_generator_run;
		self.lifespan = 1;
		self.auraV = 1;
		self.wait = HX_FRAME_TIME * 4;
		self.lifetime = time + random(1,5);
		AdvanceThinkTime(self, HX_FRAME_TIME);
		return;
	}
	
	local entity nearest;
	if (time < self.splash_time)
	{
		if (self.cnt == 2)
		{
			if (self.dmg < 8)
				sound ( self, CHAN_WEAPON, "misc/fburn_md.wav", 1.00000, ATTN_NORM);
			else
				sound ( self, CHAN_WEAPON, "misc/fburn_bg.wav", 1.00000, ATTN_NORM);
			
			self.cnt = 1;
		}
		
		if (self.cnt == 1)
		{
			if (self.oldenemy.health > 0.00000)
			{
				setorigin (self, self.oldenemy.origin);
			}
			else
			{
				//self.cnt = 0;
				//traceline ((self.origin+'0 0 24'), (self.origin-'0 0 800') , TRUE , self);
				//setorigin(self, trace_endpos);
				sound ( self, CHAN_WEAPON, "misc/null.wav", 0.30000, ATTN_NORM);
				self.think = SUB_Remove;
				AdvanceThinkTime(self, HX_FRAME_TIME);
				return;
			}
		}

		if (time > self.attack_finished)
		{
			self.attack_finished = time + 0.75000;
			if (self.oldenemy.health)
			{
				if ((self.oldenemy.health<5) && (self.lip == 0) && (self.oldenemy != world) && (self.oldenemy.flags2 & FL_ALIVE)) {
					self.oldenemy.drawflags = MLS_ABSLIGHT;
					self.oldenemy.abslight = 0.05;
					self.lip = 1;
					
					if ((self.oldenemy.classname == "monster_archer") || (self.oldenemy.classname == "monster_archer_lord") || (self.oldenemy.classname == "monster_mezzoman") || (self.oldenemy.classname == "monster_werepanther") || (self.oldenemy.classname == "player"))
						sound ( self, CHAN_VOICE, "burnme.wav", 1.00000, ATTN_NORM);
				}
				
				average_width = (self.oldenemy.size_x + self.oldenemy.size_y) * 0.50000;
				T_RadiusDamageFlat (self, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*((self.dmg / 10) * 2.00000), (((average_width*0.50000) + 64.00000) * self.spellradiusmod), self.owner, FALSE);
			}
			else
			{
				T_RadiusDamageFlat (self, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*((self.dmg / 10) * 2.00000), (64.00000 * self.spellradiusmod), self.owner, FALSE);
			}
		}
		
		if (random() < 0.2)
		{
			if (self.stepy < 5)
			{
				self.stepy += 1;
				burn_flame();
			}
			
			if ((random() < 0.30000) && (self.oldenemy.origin != VEC_ORIGIN))
			{
				average_width = (self.oldenemy.size_x + self.oldenemy.size_y) * 0.5;
				if (average_width < 5)
					average_width = 64;
				
				//dprintf("average_width %s\n", average_width);
				
				nearest = findNearestHurtable(self.origin, ((average_width*0.50000) + 64.00000) * self.spellradiusmod, 1, 0, TRUE);
				if ((nearest != world) && ((nearest.lockentity == world) || (nearest.lockentity.dmg < self.dmg)))
				{
					ignite(nearest, 1);
				}
			}
		}
		
		
		self.think = burn_think;
		AdvanceThinkTime(self, 0.18250);
	}
	else
	{
		sound ( self, CHAN_WEAPON, "misc/null.wav", 0.30000, ATTN_NORM);
		if (self.oldenemy.health)
		{
			self.oldenemy.lockentity = world;
			if (self.oldenemy.status_effects & STATUS_BURNING)
				self.oldenemy.status_effects ^= STATUS_BURNING;
		}
		
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
};

void (entity victim, float amount)ignite = {
	local entity burn;
	if ((victim == world) || (victim.thingtype == THINGTYPE_GREYSTONE) || (victim.thingtype == THINGTYPE_BROWNSTONE) || (victim.thingtype == THINGTYPE_CLAY) || (victim.thingtype == THINGTYPE_GLASS) || (victim.thingtype == THINGTYPE_ICE) || (victim.thingtype == THINGTYPE_CLEARGLASS))
	{
		SpawnPuff ( self.origin, self.velocity, 10.00000, other);
	}
	else
	{
		//if (victim.lockentity == world)
		if (!(victim.status_effects & STATUS_BURNING))
		{
			burn = spawn();
			burn.spelldamage = self.spelldamage;
			burn.spellradiusmod = self.spellradiusmod;
			burn.owner = self.owner;
			burn.oldenemy = victim;
			victim.lockentity = burn;
			victim.status_effects |= STATUS_BURNING;
			burn.hull = HULL_POINT;
			burn.solid = SOLID_NOT;
			burn.movetype = MOVETYPE_NOCLIP;
			setorigin (burn, burn.oldenemy.origin);
			setmodel (burn, "models/null.spr");
			burn.lifetime = 8;
			burn.splash_time = (time + burn.lifetime);
			burn.attack_finished = time;
			burn.cnt = 2;
			
			if (amount <= 10)
				burn.dmg = amount;
			else
				burn.dmg = 10;
			
			AdvanceThinkTime(burn, 0.1);
			burn.think = burn_think;
		}
		else
		{
			if (victim.lockentity != world)
			{
				victim.lockentity.splash_time = (time + victim.lockentity.lifetime);
				victim.lockentity.cnt = 2;
				if ((victim.lockentity.dmg + amount) <= 10)
					victim.lockentity.dmg += amount;
				else
					victim.lockentity.dmg = 10;
			}
		}
	}
};
