void  ()Glacier_crash =  {
	particle2 ( self.origin, '-90.00000 -90.00000 150.00000', '90.00000 90.00000 300.00000', 255.00000, 17, 80.00000);
	T_RadiusDamageFlat (self, self.owner, (self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500))*self.scale, (148*self.scale), self.owner, FALSE);
	chunk_death();
};

void ()make_solidity = {
	if (self.origin_z > self.auraV) {
		if (self.cnt == 1) {
			self.cnt = 0;
			self.solid = SOLID_BBOX;
		} 
		if (time < self.splash_time) {
			particle2 ( (random(self.absmin, self.absmax) - ('0 0 1' * self.size_z)), '-90.00000 -90.00000 150.00000', '90.00000 90.00000 300.00000', 255.00000, PARTICLETYPE_ICE, (random(24, 48) * self.scale));
			AdvanceThinkTime(self, 0.01);
			self.think = make_solidity;
		} else {
			AdvanceThinkTime(self, 0.01);
			self.think = SUB_Remove;
		}
	} else {
		AdvanceThinkTime(self, 0.01);
		self.think = Glacier_crash;
	}
};


void() Glacier_fall = {
	local entity hail;
	local vector random_vector;


	hail = spawn();
	hail.spelldamage = self.spelldamage;
	hail.spellradiusmod = self.spellradiusmod;
	hail.cnt = 1;
	hail.lifetime = 5;
	hail.splash_time = time + hail.lifetime;
	hail.owner = self.owner;
	hail.solid = SOLID_NOT;
	hail.movetype = MOVETYPE_FLYMISSILE;
	setmodel (hail, "models/ghail.mdl");
	hail.skin = 0;
	hail.frame = (0 + random(4));
	hail.scale = random(((1.60000 * hail.spellradiusmod)/4.00000), (1.60000 * hail.spellradiusmod));
	setsize ( hail, '-30.00000 -30.00000 -30.00000' * hail.scale, '30.00000 30.00000 30.00000' * hail.scale);
	random_vector_x = random(-150,150)*self.spellradiusmod;
	random_vector_y = random(-150,150)*self.spellradiusmod;
	random_vector_z = 0;
	setorigin (hail, (self.origin + random_vector));
	traceline (hail.origin , (hail.origin-('0 0 895')) , TRUE , self);
	hail.auraV = trace_endpos_z;

	hail.avelocity = random('-700.00000 -700.00000 -700.00000','700.00000 700.00000 700.00000');
	sound ( hail, CHAN_VOICE, "skullwiz/push.wav", 1.00000, ATTN_NORM);
	hail.velocity = ('0 0 -850');
	hail.speed = 10;
	hail.classname = "hail"; 
	hail.thingtype = THINGTYPE_ICE;
	hail.touch = Glacier_crash;

	hail.think = make_solidity;
	AdvanceThinkTime(hail, 0.2);
};


void() glacier_spawner_think = {
	if (self.cnt>0) {
		self.cnt -= 1;
		Glacier_fall();
		AdvanceThinkTime(self, random(0.01, 1.5));
		self.think = glacier_spawner_think;
	} else {
		AdvanceThinkTime(self, 0.01);
		self.think = SUB_Remove;
	}
};


void() LaunchGlacierspawner = {
	newmis = spawn (); 
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner; 
	newmis.movetype = MOVETYPE_NONE; 
	newmis.solid = SOLID_BBOX; 
	newmis.hull = HULL_POINT;
	setmodel (newmis, "models/null.spr"); 
	newmis.cnt = random(7,16);
	newmis.effects = newmis.effects | EF_DIMLIGHT; 
	AdvanceThinkTime(newmis, HX_FRAME_TIME);
	newmis.think = glacier_spawner_think;
	traceline (self.origin , (self.origin+('0 0 1000')) , TRUE , self);
	setorigin (newmis, trace_endpos); 
};
