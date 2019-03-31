void() darkness_fall = {
	if(self.cnt < 25) {
		self.cnt += 1;
		self.origin_z -= 5;
		self.think = darkness_fall;
	} else {
		self.cnt = 0;
		self.think = squelch;
	}
	AdvanceThinkTime(self, 0.02);
};

void () dark_tendrils_think = {
	if (time < self.splash_time)
	{
		if (self.origin_z >= self.dest_z)
			self.velocity_z = 0;
		if (random(0.00000, 4.00000) < 1.00000)
		{
			particle2 ( (self.origin + random('-30 -30 40', '30 30 100')), '-30.00000 -30.00000 60.00000', '30.00000 30.00000 200.00000', random(128, 143), 2, random(2.00000, 24.00000));
			particle2 ( (self.origin + random('-100 -100 100', '100 100 400')), '-30.00000 -30.00000 -4.00000', '30.00000 30.00000 -16.00000', random(1, 6), 2, random(2.00000, 16.00000));
			self.avelocity_y = random(-40, 40);
			if ((T_RadiusDamageFlat (self, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*0.12500, 145.00000 * self.spellradiusmod, self.owner, FALSE)) && (random() < 0.36250))
				sound (self, CHAN_VOICE, "hydra/tent.wav", 1.00000, ATTN_NORM);
		}
		
		self.frame = random(0, 3);
		self.think = dark_tendrils_think;
		AdvanceThinkTime(self, random(0.06250, 0.25000));
	} else {
		self.velocity_z -= random(48, 64);
		sound (self, CHAN_AUTO, "dsamaln6.wav", 1.00000, ATTN_NORM);
		self.think = SUB_Remove;
		AdvanceThinkTime(self, 1.5000);
	}
};

void(vector start) dark_tendrils = {
	traceline (start + '0 0 128', (start - '0 0 400'), TRUE, newmis);
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.lifetime = 4.00000;
	newmis.splash_time = (time + newmis.lifetime);
	setorigin(newmis, trace_endpos - '0 0 100');
	newmis.owner = self.owner;
	newmis.dest = newmis.origin;
	newmis.dest_z += random(10, 40);
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	setmodel(newmis, "models/bushbash.mdl");
	newmis.scale = random(0.9, 1.3);
	newmis.drawflags |= MLS_ABSLIGHT;
	newmis.abslight += 0.05;
	newmis.avelocity_y += random(-200, 200);
	newmis.velocity_z += random(10, 40);
	newmis.effects = EF_DARKLIGHT;
	//sound ( newmis, CHAN_AUTO, "darkness.wav", 1.00000, ATTN_NORM);
	//sound ( newmis, CHAN_AUTO, "ambience/newhum1.wav", 1.00000, ATTN_NORM);
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = dark_tendrils_think;
};

void() darkbeam_think = {
	local entity head;
	local vector start;

	if (time < self.splash_time)
	{
		self.cscale = (300.00000*(1.00000 - ((self.splash_time - time) / self.lifetime)))*self.spellradiusmod;
		if (random(0.00000, 3.00000) < 1.00000)
		{
			start = self.origin;
			start_x += random(self.cscale*(-1), self.cscale);
			start_y += random(self.cscale*(-1), self.cscale);
			dark_tendrils(start);
		}
		
		self.dmg = (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*0.12500;
		head = findradius(self.origin, self.cscale);
		while(head) {
			if (((head.takedamage == DAMAGE_YES) || (head.halted == 1)) && (head != self.owner)) {
				if((head.origin_z - self.origin_z) < 20) {
					if (((head.health > self.dmg) && (head.halted == 0)) || (head.health <= -1.00000))
					{
						T_Damage (head, self, self.owner, self.dmg);
					} else {
						if (head.solid != SOLID_BSP) {
							if (head.classname == "player") {
								head.solid = SOLID_NOT;
								head.movetype = MOVETYPE_NOCLIP;
								head.origin_z -= 10;
								AdvanceThinkTime(head, 0.1);
								head.think = darkness_fall;
							} else {
								if (head.halted == 0)
								{
									head.halted = 1;
									head.movetype = MOVETYPE_NOCLIP;
									head.velocity_z = -36;
									head.drawflags |= MLS_ABSLIGHT;
									head.abslight = 0.75;
									
									if (self.owner != world)
										AwardExperience ( self.owner, head, head.experience_value);
									
									AdvanceThinkTime(head, 5);
									head.think = SUB_Remove;
								} else {
									if (head.abslight > 0.07500)
										head.abslight -= 0.07500;
								}
							}
						} else {
							T_Damage ( head, self, self.owner, self.dmg);
						}
					}
				}
			}
			head = head.chain;
		}
		
		self.think = darkbeam_think;
		AdvanceThinkTime(self, 0.10000);
	} else {
		sound ( self, CHAN_AUTO, "ambience/newhum1.wav", 1.00000, ATTN_NORM);
		self.think = SUB_Remove;
		AdvanceThinkTime(self, 3);
	}
};

void() darkbeam = {
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.lifetime = 8.00000;
	newmis.splash_time = time + newmis.lifetime;
	newmis.auraV = 100;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.effects = EF_DARKLIGHT;
	newmis.owner = self.owner;
	traceline (self.origin, (self.origin - '0 0 800'), TRUE, self);
	setorigin(newmis, trace_endpos);
	setmodel(newmis, "models/null.spr");
	sound ( self, CHAN_WEAPON, "darkblast.wav", 1.00000, ATTN_NORM);
	sound ( self, CHAN_BODY, "darkburst.wav", 1.00000, ATTN_NORM);
	sound ( newmis, CHAN_AUTO, "ambience/newhum1.wav", 1.00000, ATTN_NORM);
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = darkbeam_think;
};