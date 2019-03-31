void() cloud_think = {
	local entity nearest;

	if (time < self.splash_time)
	{
		if (self.type_index == 0)
		{
			if (self.frame > 23) {
				self.frame = 0;
			} else {
				self.frame += 1;
			}
		}
		else if (self.type_index == 1)
		{
			if (self.frame > 3) {
				self.frame = 0;
			} else {
				self.frame = self.frame + 1;
			}
		}

		if (self.cloud_style == 0)
		{
			self.abslight = random(0.12500, 0.3500);
			if (self.effects & EF_BRIGHTLIGHT)
				self.effects ^= EF_BRIGHTLIGHT;
		}
		else if (self.cloud_style == 1)
		{
			if (random() < 0.500)
			{
				particle2 ( (self.origin + (random('-170 -170 -30', '170 170 0') * self.spellradiusmod)), '-30.00000 -30.00000 -190.00000', '30.00000 30.00000 -490.00000', random(144, 159), 0, 1.00000);
				particle2 ( (self.origin + (random('-170 -170 -30', '170 170 0') * self.spellradiusmod)), '-30.00000 -30.00000 -190.00000', '30.00000 30.00000 -490.00000', random(144, 159), 0, 1.00000);
				particle2 ( (self.origin + (random('-170 -170 -30', '170 170 0') * self.spellradiusmod)), '-30.00000 -30.00000 -190.00000', '30.00000 30.00000 -490.00000', random(144, 159), 0, 1.00000);
			}
		}
		else if (self.cloud_style == 2)
		{
			if (random() < 0.500)
			{
				particle2 ( (self.origin + (random('-170 -170 -30', '170 170 0') * self.spellradiusmod)), '-30.00000 -30.00000 -190.00000', '30.00000 30.00000 -490.00000', random(128, 143), 0, 1.00000);
				particle2 ( (self.origin + (random('-170 -170 -30', '170 170 0') * self.spellradiusmod)), '-30.00000 -30.00000 -190.00000', '30.00000 30.00000 -490.00000', random(128, 143), 0, 1.00000);
				particle2 ( (self.origin + (random('-170 -170 -30', '170 170 0') * self.spellradiusmod)), '-30.00000 -30.00000 -190.00000', '30.00000 30.00000 -490.00000', random(128, 143), 0, 1.00000);
				particle2 ( (self.origin + (random('-170 -170 -30', '170 170 0') * self.spellradiusmod)), '-30.00000 -30.00000 -190.00000', '30.00000 30.00000 -490.00000', random(128, 143), 0, 1.00000);
			}
			
			if ((self.glow_dest > self.glow_last) && (self.abslight >= self.glow_dest))
			{
				self.glow_last = self.glow_dest;
				self.glow_dest = random(0.25000, 0.80000);
				self.glow_delay = random(0.62500, 1.25000);
				self.glow_time = (time + self.glow_delay);
			}
			else if ((self.glow_dest < self.glow_last) && (self.abslight <= self.glow_dest))
			{
				self.glow_last = self.glow_dest;
				self.glow_dest = random(0.25000, 0.80000);
				self.glow_delay = random(0.62500, 1.25000);
				self.glow_time = (time + self.glow_delay);
			}
			
			self.abslight = (self.glow_last + ((1.00000 - ((self.glow_time - time) / self.glow_delay)) * (self.glow_dest - self.glow_last)));
		}
		
		if (time >= self.attack_finished)
		{
			self.attack_finished = (time + random((1.00000 / self.melee_rate_high), (1.00000 / self.melee_rate_low)));
			self.th_melee();
		}

		if ((time >= self.magic_finished) && (self.controller.origin != VEC_ORIGIN) && (self.controller.cnt < self.controller.missile_count))
		{
			self.magic_finished = (time + random((1.00000 / self.missile_rate_high), (1.00000 / self.missile_rate_low)));
			self.controller.cnt += 1;
			self.th_missile();
		}
		
		self.think = cloud_think;
		AdvanceThinkTime(self,0.15625);
	} else {
		AdvanceThinkTime(self, HX_FRAME_TIME);
		self.think = SUB_Remove;
	}
};


void(vector start, float type) cloud_spawn = {
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.type_index = type;
	newmis.cloud_style = self.cloud_style;
	newmis.owner = self.owner;
	newmis.auraV = self.auraV;
	newmis.controller = self;
	setorigin(newmis, start);
	newmis.angles_y = random(-180, 180);
	newmis.avelocity_y = random(-32, 32);
	newmis.velocity = random('-20 -20 -8', '20 20 0');
	newmis.lifetime = random(3, 7);
	newmis.splash_time = (time + newmis.lifetime);
	
	if (self.cloud_style == 0) //thundercloud
	{
		if (random() < 0.5)
		{
			setmodel(newmis, "models/cloud.mdl");
			newmis.skin = 0;
			newmis.type_index = 0;
		}
		else
		{
			setmodel(newmis, "models/ghail.mdl");
			newmis.skin = 0;
			newmis.type_index = 1;
		}
		newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
		newmis.abslight = random(0.25000, 0.62500);
	}
	else if (self.cloud_style == 1) //raincloud
	{
		setmodel(newmis, "models/cloud.mdl");
		newmis.type_index = 0;
		newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
		newmis.abslight = random(0.25000, 0.62500);
	}
	else if (self.cloud_style == 2) //sweltering cloud
	{
		setmodel(newmis, "models/cloud.mdl");
		newmis.skin = 4;
		newmis.type_index = 0;
		newmis.glow_last = 0.001250;
		newmis.glow_dest = random(0.25000, 0.80000);
		newmis.glow_delay = random(0.62500, 1.25000);
		newmis.glow_time = (time + newmis.glow_delay);
		newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
		newmis.abslight = newmis.glow_last;
	}
	
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.scale = (random(1.00000, 1.60000) * self.spellradiusmod);
	newmis.th_melee = self.th_melee;
	newmis.th_missile = self.th_missile;
	newmis.melee_rate_low = self.melee_rate_low;
	newmis.melee_rate_high = self.melee_rate_high;
	newmis.missile_rate_low = self.missile_rate_low;
	newmis.missile_rate_high = self.missile_rate_high;
	newmis.missile_count = self.missile_count;
	newmis.attack_finished = (time + random((1.00000 / newmis.melee_rate_high), (1.00000 / newmis.melee_rate_low)));
	newmis.magic_finished = (time + random((1.00000 / newmis.missile_rate_high), (1.00000 / newmis.missile_rate_low)));
	newmis.think = cloud_think;
	AdvanceThinkTime(newmis,0.20000);
};


void() clouds_build =
{
	local float i;
	local vector pos;
	
	if (time < self.splash_time)
	{
		i = 0;
		pos = (self.origin + (random('-250 -250 -64', '250 250 0')*self.spellradiusmod));
		while ((pointcontents(pos) != CONTENT_EMPTY) && (i < 4))
		{
			pos = (self.origin + (random('-250 -250 -64', '250 250 0')*self.spellradiusmod));
			i += 1;
		}
		
		if (i < 4)
		{
			cloud_spawn(pos, 0);
		}
		
		AdvanceThinkTime(self, (random(0.35000, 0.75000) / self.spellradiusmod));
		self.think = clouds_build;
	} else {
		AdvanceThinkTime(self, 3.00000);
		self.think = SUB_Remove;
	}
};


void(entity spawner) clouds_spawner =
{
	spawner.spelldamage = self.spelldamage;
	spawner.spellradiusmod = self.spellradiusmod;
	//setmodel(spawner, "models/dwarf.mdl");
	spawner.owner = self.owner;
	spawner.solid = SOLID_NOT;
	spawner.movetype = MOVETYPE_NONE;
	spawner.hull = HULL_POINT;
	spawner.lifetime = random(14, 19);
	spawner.splash_time = (time + spawner.lifetime);
	
	traceline (self.origin, (self.origin-('0 0 600')) , TRUE , self);
	spawner.auraV = trace_endpos_z;
	traceline (trace_endpos, (self.origin+(('0 0 1' * spawner.cloud_height) * spawner.spellradiusmod)) , TRUE , self);
	setorigin(spawner, (trace_endpos - '0 0 30'));
	
	if (spawner.melee_rate_low == 0)
		spawner.melee_rate_low = 1;
	if (spawner.melee_rate_high == 0)
		spawner.melee_rate_high = 1;
	if (spawner.missile_rate_low == 0)
		spawner.missile_rate_low = 1;
	if (spawner.missile_rate_high == 0)
		spawner.missile_rate_high = 1;

	spawner.attack_finished = (time + random((1.00000 / spawner.melee_rate_high), (1.00000 / spawner.melee_rate_low)));
	spawner.magic_finished = (time + random((1.00000 / spawner.missile_rate_high), (1.00000 / spawner.missile_rate_low)));
	
	AdvanceThinkTime(spawner, HX_FRAME_TIME);
	spawner.think = clouds_build;
};
