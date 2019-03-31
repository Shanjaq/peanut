void(entity spawner) clouds_spawner;
void() lchain_launch;

void() storm_ball_think =
{
	local float i;
	local vector dir;
	if (time < self.splash_time)
	{
		//dir = vectoangles (self.velocity);
		//makevectors (dir);
		if (random() < 0.1)
		{
			newmis = world; //shan track new projectile.  could this cause random crashing?
			lchain_launch();
			
			if (newmis.origin != VEC_ORIGIN)
				self.goalentity = newmis.enemy;
		}
	
		//if ((self.effects & EF_BRIGHTLIGHT) && (self.goalentity.origin == VEC_ORIGIN))
		//	self.effects = EF_DIMLIGHT;
		
		
		if (random() < 0.25)
		{
			i = 0;
			self.dest = self.dest2 + random('-768 -768 -32', '768 768 -32');
			self.dest_z = self.origin_z + 32;
			while ((pointcontents(self.dest) != CONTENT_EMPTY) && (i < 4))
			{
				self.dest = self.dest2 + random('-768 -768 0', '768 768 0');
				self.dest_z = self.origin_z + 32;
				i += 1;
			}
			
			if (i < 4)
			{
				if (self.goalentity.origin != VEC_ORIGIN)
				{
					self.dest_z = self.goalentity.origin_z + random(32, 128);
					sound ( self, CHAN_VOICE, "lghturn.wav", 1.00000, ATTN_NORM);
				}
				else
				{
					traceline(self.dest , (self.dest - '0 0 1024') , FALSE , self);
					if ((trace_fraction < 1.00000) || (pointcontents(trace_endpos + '0 0 10') == CONTENT_EMPTY))
					{
						self.dest_z = trace_endpos_z + random(32, 128);
						sound ( self, CHAN_VOICE, "lghturn.wav", 1.00000, ATTN_NORM);
					}
				}
			}
		}
		self.velocity = ((self.dest - self.origin) * 0.5);
		//particle2 ( self.origin, '-3.00000 -3.00000 -3.00000', '3.00000 3.00000 3.00000', (160.00000 + random(15.00000)), PARTICLETYPE_BLOB2, 2.00000);
		particle2 ( self.origin, '-3.00000 -3.00000 -3.00000', '3.00000 3.00000 3.00000', (153.00000 + random(6.00000)), PARTICLETYPE_BLOB2, 2.00000);
		particle2 ( self.origin, '-1.00000 -1.00000 -1.00000', '1.00000 1.00000 1.00000', (160.00000 + random(15.00000)), PARTICLETYPE_BLOB2, 3.00000);
		
		
		self.think = storm_ball_think;
		AdvanceThinkTime(self, 0.1);
	}
	else
	{
		if (self.controller.origin != VEC_ORIGIN)
			self.controller.cnt -= 1;
		
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
};

void() storm_ball_effect_think =
{
	if (time < self.splash_time)
	{
		setorigin(self, self.controller.origin);
		
		self.scale = ((self.splash_time - time) / self.lifetime) + 0.01250;
		
		self.think = storm_ball_effect_think;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
	else
	{
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
};

void() storm_ball_trail_think =
{
	if ((time < self.splash_time) && (self.controller.origin != VEC_ORIGIN))
	{
		setorigin(self, self.controller.origin);
		self.velocity = self.controller.velocity;
		//self.scale = random(2.5);
		
		self.think = storm_ball_trail_think;
		AdvanceThinkTime(self, 0.12500);
	}
	else
	{
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
	
};

void() storm_ball =
{
	local entity stormball;
	stormball = spawn();
	stormball.spelldamage = (self.spelldamage * 0.63750);
	stormball.spellradiusmod = self.spellradiusmod;
	stormball.owner = self.owner;
	stormball.controller = self.controller;
	stormball.dest = (self.origin + random('-64 -64 -256', '64 64 -64'));
	stormball.dest2 = self.origin;
	
	stormball.solid = SOLID_NOT;
	stormball.movetype = MOVETYPE_NOCLIP;
	
	setorigin(stormball, self.origin);
	//sound ( stormball, CHAN_WEAPON, "rw11thuf.wav", 1.00000, ATTN_NORM);
	sound ( stormball, CHAN_WEAPON, "zap4.wav", 1.00000, ATTN_NORM);
	setmodel(stormball, "models/glowball.mdl");
	stormball.classname = "stormball";
	setsize(stormball, '-5 -5 -5', '5 5 5');
	stormball.avelocity = random('-700.00000 -700.00000 -700.00000','700.00000 700.00000 700.00000');
	stormball.drawflags |= MLS_ABSLIGHT;
	stormball.abslight = 1;
	stormball.scale = stormball.spellradiusmod;
	
	stormball.lifetime = random(7, 11);
	stormball.splash_time = (time + stormball.lifetime);
	stormball.think = storm_ball_think;
	AdvanceThinkTime(stormball, HX_FRAME_TIME);

	
	newmis = spawn();
	newmis.controller = stormball;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	setorigin(newmis, self.origin);
	setmodel(newmis, "models/star2.mdl");
	newmis.skin = 1;
	newmis.avelocity = random('-700.00000 -700.00000 -700.00000','700.00000 700.00000 700.00000');
	newmis.drawflags |= (MLS_ABSLIGHT | DRF_TRANSLUCENT);
	newmis.abslight = 1;
	newmis.scale = 1.00000;
	newmis.lifetime = random(0.50000, 1.25000);
	newmis.splash_time = (time + newmis.lifetime);
	newmis.think = storm_ball_effect_think;
	AdvanceThinkTime(newmis, HX_FRAME_TIME);

	newmis = spawn();
	newmis.controller = stormball;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	setorigin(newmis, self.origin);
	setmodel(newmis, "models/star2.mdl");
	newmis.skin = 1;
	newmis.avelocity = random('-700.00000 -700.00000 -700.00000','700.00000 700.00000 700.00000');
	newmis.drawflags |= (MLS_ABSLIGHT | DRF_TRANSLUCENT);
	newmis.abslight = 1;
	newmis.scale = 1.00000;
	newmis.lifetime = random(0.36250, 0.63750);
	newmis.splash_time = (time + newmis.lifetime);
	newmis.think = storm_ball_effect_think;
	AdvanceThinkTime(newmis, HX_FRAME_TIME);
	
	newmis = spawn();
	newmis.controller = stormball;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	setorigin(newmis, self.origin);
	setmodel(newmis, "models/boss/star.mdl");
	newmis.avelocity = random('-700.00000 -700.00000 -700.00000','700.00000 700.00000 700.00000');
	//newmis.drawflags |= (MLS_ABSLIGHT | DRF_TRANSLUCENT | MLS_TORCH | MLS_FIREFLICKER);
	newmis.drawflags |= (MLS_ABSLIGHT | DRF_TRANSLUCENT | MLS_FIREFLICKER);
	newmis.effects = EF_DIMLIGHT;
	//newmis.drawflags |= (MLS_ABSLIGHT);
	newmis.abslight = 1;
	newmis.scale = stormball.spellradiusmod;
	newmis.lifetime = stormball.lifetime;
	newmis.splash_time = stormball.splash_time;
	newmis.think = storm_ball_trail_think;
	AdvanceThinkTime(newmis, HX_FRAME_TIME);

	
	
};


void() storm_melee = {
	local entity nearest;
	
	if (random() < 0.36250)
	{
		self.cnt = random(0, 5);
		if (self.cnt < 1)
			sound ( self, CHAN_VOICE, "thnd1.wav", 1.00000, ATTN_NORM);
		else if (self.cnt < 2)
			sound ( self, CHAN_VOICE, "thnd2.wav", 1.00000, ATTN_NORM);
		else if (self.cnt < 3)
			sound ( self, CHAN_VOICE, "thnd3.wav", 1.00000, ATTN_NORM);
		else if (self.cnt < 4)
			sound ( self, CHAN_VOICE, "thnd4.wav", 1.00000, ATTN_NORM);
	}
	
	self.abslight = 1.00000;
	self.effects |= EF_BRIGHTLIGHT;
	
	self.dest = self.origin;
	self.dest_z = self.auraV;
	
	nearest = findNearestHurtable(self.dest, 500.00000, 1, 0, TRUE);
	if ((nearest != world) && (random() < 0.40000))
	{
		do_lightning ( self.owner, 3, STREAM_ATTACHED, 1.00000, self.origin + random('-100 -100 0', '100 100 20'), nearest.origin, self.spelldamage + random(self.spelldamage*(-0.250000), self.spelldamage*1.750000));
	}
	else
	{
		if (random() < 0.5)
		{
			self.dest2 = self.origin + (random('-256 -256 -10', '256 256 5') * self.spellradiusmod);
			
			//shan lightning effect
			WriteByte ( MSG_BROADCAST, SVC_TEMPENTITY);
			WriteByte ( MSG_BROADCAST, TE_STREAM_LIGHTNING);
			WriteEntity ( MSG_BROADCAST, self);
			WriteByte ( MSG_BROADCAST, 1);
			WriteByte ( MSG_BROADCAST, 3);
			WriteCoord ( MSG_BROADCAST, self.dest2_x);
			WriteCoord ( MSG_BROADCAST, self.dest2_y);
			WriteCoord ( MSG_BROADCAST, self.dest2_z);
			WriteCoord ( MSG_BROADCAST, self.origin_x + (random(-96, 96) * self.spellradiusmod));
			WriteCoord ( MSG_BROADCAST, self.origin_y + (random(-96, 96) * self.spellradiusmod));
			WriteCoord ( MSG_BROADCAST, self.origin_z + (random(-10, 5) * self.spellradiusmod));
			//shan lightning effect end
		}
		else
		{
			self.dest2 = self.origin + (random('-128 -128 -10', '128 128 0') * self.spellradiusmod);
			traceline ((self.dest2 - '0 0 30') , (self.dest2 - '0 0 1024') , FALSE , self);
		
			newmis = spawn_temp();
			newmis.thingtype = THINGTYPE_BROWNSTONE;
			setsize(newmis, '-5 -5 0', '5 5 5');
			newmis.think = chunk_death;
			setorigin(newmis, trace_endpos + '0 0 5');
			AdvanceThinkTime(newmis, HX_FRAME_TIME);

			CreateWhiteSmoke ( (newmis.origin + '0.00000 0.00000 10.00000'), '0.00000 0.00000 8.00000', (HX_FRAME_TIME * 3.00000));
			
			WriteByte ( MSG_BROADCAST, SVC_TEMPENTITY);
			WriteByte ( MSG_BROADCAST, TE_STREAM_LIGHTNING);
			WriteEntity ( MSG_BROADCAST, self);
			WriteByte ( MSG_BROADCAST, 1);
			WriteByte ( MSG_BROADCAST, 4);
			WriteCoord ( MSG_BROADCAST, newmis.origin_x);
			WriteCoord ( MSG_BROADCAST, newmis.origin_y);
			WriteCoord ( MSG_BROADCAST, newmis.origin_z);
			WriteCoord ( MSG_BROADCAST, self.origin_x + (random(-96, 96) * self.spellradiusmod));
			WriteCoord ( MSG_BROADCAST, self.origin_y + (random(-96, 96) * self.spellradiusmod));
			WriteCoord ( MSG_BROADCAST, self.origin_z + (random(-10, 5) * self.spellradiusmod));
		}
	}
	
};

void() storm_launch = {
	local entity cloudspawner;
	
	if ( (deathmatch || coop) )
	{
		cloudspawner = find(world, classname, "thestorm");
		while ( cloudspawner ) {
			if ((cloudspawner != world) && (cloudspawner.owner == self.owner))
				cloudspawner.splash_time = time;
			
			cloudspawner = find ( cloudspawner, classname, "thestorm");
		}
	}
	
	cloudspawner = spawn();
	cloudspawner.classname = "thestorm";
	cloudspawner.cloud_style = 0;
	cloudspawner.cloud_height = 650;
	cloudspawner.th_melee = storm_melee;
	cloudspawner.melee_rate_low = 0.18125;
	cloudspawner.melee_rate_high = 8;
	cloudspawner.th_missile = storm_ball;
	cloudspawner.missile_rate_low = 0.09063;
	cloudspawner.missile_rate_high = 0.62500;
	cloudspawner.missile_count = rint(2.00000 * self.spellradiusmod);
	clouds_spawner(cloudspawner);
	/*
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	setmodel(newmis, "models/dwarf.mdl");
	newmis.owner = self.owner;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NONE;
	newmis.hull = HULL_POINT;
	newmis.lifetime = (time + random(14, 19));
	traceline (self.origin, (self.origin-('0 0 600')) , TRUE , self);
	newmis.auraV = trace_endpos_z;
	traceline (trace_endpos, (self.origin+('0 0 600')) , TRUE , self);
	setorigin(newmis, (trace_endpos - '0 0 30'));
	sound ( newmis, CHAN_VOICE, "thnd1.wav", 1.00000, ATTN_NORM);
	AdvanceThinkTime(newmis, HX_FRAME_TIME);
	newmis.think = storm_build;
	*/
};

//		particle2 ( (self.origin + random('-30 -30 -30', '30 30 30')), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(1, 6), 2, 80.00000);
