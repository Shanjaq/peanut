void ()aero_dissolve = {
	local entity found;
	local vector dir;
	local float pc;
	
	if (self.frame >= 2) {
		self.frame = 0;
	} else {
		self.frame += 1;
	}

	if (time < self.splash_time)
	{
		pc = pointcontents(self.origin);
		
		if ((pc != CONTENT_WATER) && (pc != CONTENT_SLIME))
		{
			if (self.status_effects & STATUS_BURNING)
			{
				if (self.skin != 4)
					self.skin = 4;
			}
			else
			{
				if (self.skin >= 2)
					self.skin = 0;
				else
					self.skin += 1;
				}
			}
		else
		{
			if (self.skin != 3)
				self.skin = 3;
			
			if (self.oldenemy != world)
				setorigin (self.oldenemy, self.origin + (random('-64 -64 0', '64 64 128') * self.scale));
		}
		
		if (self.frame == 0)
		{
			makevectors(RandomVector('0 360 0'));
			//particle2 ( (self.origin + ((v_forward * 16.00000) * self.spellradiusmod)), ('-96.00000 -96.00000 50.00000' + (v_right * 64)), ('96.00000 96.00000 300.00000' + (v_right * 128)), random(243, 246), PARTICLETYPE_BLOB, random(20.00000, 80.00000));

			if ((pc != CONTENT_WATER) && (pc != CONTENT_SLIME))
				if (self.status_effects & STATUS_BURNING)
					particle2 ( (self.origin + ((v_forward * 16.00000) * self.spellradiusmod)), ('-96.00000 -96.00000 50.00000' + (v_right * 64)), ('96.00000 96.00000 300.00000' + (v_right * 128)), (251.00000 + random(3.00000)), PARTICLETYPE_BLOB, random(20.00000, 80.00000));
				else
					particle2 ( (self.origin + ((v_forward * 16.00000) * self.spellradiusmod)), ('-96.00000 -96.00000 50.00000' + (v_right * 64)), ('96.00000 96.00000 300.00000' + (v_right * 128)), random(243, 246), PARTICLETYPE_FASTGRAV, random(20.00000, 80.00000));
			else
				particle2 ( (self.origin + ((v_forward * 16.00000) * self.spellradiusmod)), ('-32.00000 -32.00000 6.00000' + (v_right * 64)), ('32.00000 32.00000 64.00000' + (v_right * 128)), random(151, 159), PARTICLETYPE_BLOB, random(20.00000, 80.00000));
			
			/*
			if ((pc != CONTENT_WATER) && (pc != CONTENT_SLIME))
				if (self.status_effects & STATUS_BURNING)
					particle2 ( self.origin, '-32.00000 -32.00000 6.00000', '32.00000 32.00000 64.00000', (251.00000 + random(3.00000)), PARTICLETYPE_BLOB, 80.00000);
				else
					particle2 ( self.origin, '-190.00000 -190.00000 50.00000', '190.00000 190.00000 300.00000', random(243, 246), PARTICLETYPE_FASTGRAV, 80.00000);
	
			else
				particle2 ( self.origin, '-32.00000 -32.00000 6.00000', '32.00000 32.00000 64.00000', random(151, 159), PARTICLETYPE_BLOB, 80.00000);
			*/
			
			if (random() > 0.5)
			{
				if ((pc != CONTENT_WATER) && (pc != CONTENT_SLIME) && (pc != CONTENT_LAVA))
					if ((self.status_effects & STATUS_BURNING) && (random() < 0.25000))
						sound ( self, CHAN_AUTO, "eidolon/flambrth.wav", 0.63750, ATTN_NORM);
					else
						sound ( self, CHAN_AUTO, "aeroturn.wav", 1.00000, ATTN_NORM);
				else
				{
					if ((pc == CONTENT_LAVA) && !(self.status_effects & STATUS_BURNING))
						self.status_effects |= STATUS_BURNING;
					else if (((pc == CONTENT_WATER) || (pc == CONTENT_SLIME)) && (self.status_effects & STATUS_BURNING))
						self.status_effects ^= STATUS_BURNING;
					
					if (random() < 0.50000)
						sound ( self, CHAN_AUTO, "player/swim1.wav", 1.00000, ATTN_NORM);
					else
						sound ( self, CHAN_AUTO, "ambience/water.wav", 1.00000, ATTN_NORM);
				}
			}
		}
		self.abslight = ((self.splash_time - time) / self.lifetime);
		found = T_RadiusDamageFlat (self, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*0.12500, 125.00000 * self.spellradiusmod, self.owner, FALSE);
		while(found)
		{
			dir = normalize(self.origin - found.origin);
			SpawnPuff ( (found.origin + random(found.mins, found.maxs)) + (dir * ((found.size_x + found.size_y) * 0.25000)), '360.00000 360.00000 360.00000', 3.00000, found);
			if ((found.solid != SOLID_BSP) && (found.movetype != MOVETYPE_NOCLIP) && (found.classname != "aero") && (found.classname != "bloodspot"))
			{
				if (found.flags & FL_ONGROUND) {
					found.flags ^= FL_ONGROUND;
				}
				
				if (self.status_effects & STATUS_BURNING)
				{
					if (random() < 0.36250)
						ignite(found, 1);
					
				}
				else
				{
					if (found.status_effects & STATUS_BURNING)
						self.status_effects |= STATUS_BURNING;
				}
				
				makevectors(dir);
				found.velocity += ((v_right * 12) + '0 0 12');
			}
			found = found.chain2;
		}
		
	} else {
		if (self.oldenemy != world)
			remove(self.oldenemy);

		self.scale -= 0.075;
	}
	if (self.scale < 0.1) {
		remove(self);
	}
	self.think = aero_dissolve;
	AdvanceThinkTime(self, 0.06250);
};

void ()aero_whip = {
	local entity head;
	head = findradius ( self.origin, 100);
	
	while (head)
	{
		//if (head.takedamage == DAMAGE_YES) {
		if ((head.solid != SOLID_BSP) && (head.movetype != MOVETYPE_NOCLIP) && (head.classname != "aero") && (head.classname != "bloodspot") && (head.touch != puzzle_touch) && (head.touch != weapon_touch))
		{
			if (head.flags & FL_ONGROUND) {
				head.flags ^= FL_ONGROUND;
			}
			head.velocity += random('-90 -90 400', '90 90 900');
			if (head != self.owner)
				T_Damage (head, self, self.owner, self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500));
			sound ( self, CHAN_AUTO, "aerostart.wav", 1.00000, ATTN_NORM);
		}
		head = head.chain;
	}
	AdvanceThinkTime(self, 0.05);
	self.think = aero_dissolve;
};

void ()aero_expand = {
	if (self.scale < (1.50000 * self.spellradiusmod)) {
		if (self.frame >= 2) {
			self.frame = 0;
		} else {
			self.frame += 1;
			particle2 ( self.origin, '-190.00000 -190.00000 50.00000', '190.00000 190.00000 300.00000', random(243, 246), 17, 80.00000);
			sound ( self, CHAN_AUTO, "skullwiz/push.wav", 1.00000, ATTN_NORM);
		}		
		self.abslight += 0.05;
		self.scale += 0.2;
		AdvanceThinkTime(self, 0.05);
		self.think = aero_expand;
	} else {
		AdvanceThinkTime(self, 0.05);
		self.think = aero_whip;
	}
};

void ()aero_init = {
	local float pc;
	
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	newmis.classname = "aero";
	newmis.lifetime = 5.00000;
	newmis.splash_time = (time + newmis.lifetime);
	traceline (self.origin+('0 0 20') , (self.origin-('0 0 600')) , TRUE , self);
	//newmis.hull = HULL_POINT;
	setorigin(newmis, (trace_endpos + '0 0 24'));
	//setsize(newmis, '-12 -12 0', '12 12 24');
	//setsize(newmis, '-20 -20 0', '20 20 60');
	sound (newmis, CHAN_WEAPON, "skullwiz/push.wav", 1, ATTN_NORM); 
	//makevectors(self.v_angle);

	newmis.solid = SOLID_TRIGGER;
	//newmis.movetype = MOVETYPE_NOCLIP;
	newmis.movetype = MOVETYPE_BOUNCE;
	newmis.scale = 0.02;
	setmodel(newmis, "models/aero.mdl");
	newmis.hull = HULL_POINT;
	setsize(newmis, '0 0 0', '0 0 0');
	newmis.frame = random(0, 2);
	newmis.drawflags |= ((MLS_ABSLIGHT) | (DRF_TRANSLUCENT) | (SCALE_TYPE_XYONLY));
	newmis.abslight = 1.0;
	newmis.frame = random(0, 2);
	newmis.angles = random('0 -180 0', '0 180 0');
	newmis.avelocity_y = random(100, 350);
	AdvanceThinkTime(newmis, 0.1);
	newmis.think = aero_expand;
	
	pc = pointcontents(newmis.origin + '0 0 12');
	if ((pc == CONTENT_WATER) || (pc == CONTENT_SLIME))
	{
		dprint("BARF27\n");
		newmis.oldenemy = spawn();
		newmis.oldenemy.think = bubble_spawner_think;
		AdvanceThinkTime(newmis.oldenemy, HX_FRAME_TIME);
	}

};

//	particle2 ( (self.origin + random('-30 -30 0', '30 30 30')), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(243, 246), 2, 20.00000);

