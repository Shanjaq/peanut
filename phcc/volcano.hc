void ()lava_splash = {
	if ((other != world) && (other.classname == "magma")) {
		return;
	} else {
		if (self.model == "models/splat.mdl") {
			if (self.frame < 10) {
				self.frame += 1;
			} else {
				remove(self);
			}
		} else {	
			sound (self, CHAN_AUTO, "tsunami.wav", 1, ATTN_NORM);
			self.avelocity = '0.0 0.0 0.0';
			self.dest = self.origin;
			self.dest_z = self.auraV;
			traceline ( self.dest, (self.dest - '0.00000 0.00000 300.00000'), TRUE, self);
			pitch_roll_for_slope(trace_plane_normal);
			self.angles_y = random(-180, 180);
			setorigin(self, self.dest);
			setmodel (self, "models/splat.mdl");
			T_RadiusDamageFlat (self, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*0.62500, 240.00000 * self.spellradiusmod, self.owner, FALSE);
			self.exploderadius = 0;
			lavamess((random(4, 8) * self.spellradiusmod), (100 * self.spellradiusmod), 180);
		}
		AdvanceThinkTime(self, 0.1);
		self.think = lava_splash;
	}
};

void ()lava_think = {
	if ((self.velocity_z > 0.00000) || (self.origin_z > self.auraV))
	{
		self.velocity_z -= ((time - self.ltime) * 600);
		particle2 ( self.origin + random('-100 -100 -100', '100 100 100'), '-100.00000 -100.00000 -100.00000', '100.00000 100.00000 100.00000', 140.00000, 16, random(1, 15));
		T_RadiusDamageFlat (self, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*0.12500, 160.00000 * self.spellradiusmod, self.owner, FALSE);
		self.think = lava_think;
		AdvanceThinkTime(self, 0.04);
		self.ltime = time;
	}
	else
	{
		self.velocity_z = 0;
		self.think = lava_splash;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
};

void ()volcano_erupt = {
	T_RadiusDamageFlat (self, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500)), 160.00000 * self.spellradiusmod, self.owner, FALSE);
	sound (self, CHAN_AUTO, "exp2.wav", 1, ATTN_NORM);
	//sound (self, CHAN_AUTO, "bh.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "exp2.wav", 1, ATTN_NORM);

	while (self.cnt <= 4) {
		newmis = spawn();
		newmis.spelldamage = self.spelldamage;
		newmis.spellradiusmod = self.spellradiusmod;
		newmis.owner = self.owner;
		newmis.solid = SOLID_NOT;
		newmis.movetype = MOVETYPE_NOCLIP;
		newmis.avelocity = random('-700.00000 -700.00000 -700.00000','700.00000 700.00000 700.00000');
		newmis.auraV = self.origin_z + 24.00000;
		//newmis.touch = lava_splash;
		setmodel (newmis, "models/blast.mdl");
		newmis.classname = "magma";
		newmis.drawflags = MLS_ABSLIGHT;
		setorigin(newmis, self.origin);
		newmis.origin_z += 8;
		newmis.effects |= EF_TORCHLIGHT;
		newmis.abslight = 1.00000;
		newmis.hull = HULL_POINT;
		setsize(newmis, '0 0 0', '0 0 0');
		newmis.scale = (0.80000 * newmis.spellradiusmod);
		//newmis.velocity_z = (self.cnt * (180 * newmis.spellradiusmod));
		newmis.velocity_z = ((self.cnt / 4.00000) * (650.00000 * newmis.spellradiusmod));
		newmis.ltime = time;
		self.cnt += 1;
		AdvanceThinkTime(newmis, 0.02);
		newmis.think = lava_think;
	}

	newmis = spawn_temp();
	newmis.thingtype = THINGTYPE_BROWNSTONE;
	setsize(newmis, ('-96 -96 0') * self.spellradiusmod, ('96 96 64') * self.spellradiusmod);
	newmis.think = chunk_death;
	setorigin(newmis, self.origin + '0 0 5');
	AdvanceThinkTime(newmis, HX_FRAME_TIME);
	
	
	remove(self);
};

void ()volcano_start = {
	self.magic_finished = (time + 5);
	makevectors (self.angles);

	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.cnt = 1;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NONE;
	newmis.owner = self.owner;
	traceline (self.origin + '0 0 30', (self.origin - '0 0 800'), TRUE, self);
	setorigin(newmis, trace_endpos);
	newmis.origin_z += 8;
	setmodel(newmis, "models/null.spr");
	newmis.effects |= EF_DIMLIGHT;
	sound (newmis, CHAN_AUTO, "dsamaln6.wav", 1, ATTN_NORM);
	sound (newmis, CHAN_AUTO, "dsamaln6.wav", 1, ATTN_NORM);
	AdvanceThinkTime(newmis, random(1.0, 2.5));
	newmis.think = volcano_erupt;
	MonsterQuake(600.0, newmis);
};