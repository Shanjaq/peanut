.vector rmark;
.vector umark;
.vector fmark;

void ()razor_blowup = {
};

void ()razor_hit = {
	if (other == self.owner || other.movetype == MOVETYPE_FLYMISSILE || other.movetype == MOVETYPE_BOUNCEMISSILE || other.movetype == MOVETYPE_NOCLIP || other.movetype == MOVETYPE_BOUNCE)
		return;
	
	if (other.takedamage == DAMAGE_YES) {
		if (self.scale < 1.25000)
		{
			T_Damage (other, self, self.owner, self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500));
			sound ( self, CHAN_AUTO, "aerostart.wav", 1.00000, ATTN_NORM);
			self.scale += 0.10000;
			self.abslight -= 0.10000;
		} else {
			remove(self);
		}

	} else {
		remove(self);
	}
};

void ()razor_trail_think = {
	self.scale -= 0.05;
	self.abslight -= 0.02;
	if (self.scale < 0.1) {
		remove(self);
	} else {
		AdvanceThinkTime(self, 0.02);
		self.think = razor_trail_think;
	}
};

void ()razor_trail = {
	newmis = spawn();
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.owner = self;
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.abslight = 0.80000;
	newmis.scale = 0.5;
	setorigin(newmis, self.origin);
	newmis.angles = vectoangles(self.velocity); 
	setmodel (newmis, "models/arazor.mdl");
	newmis.skin = 1;
	setsize(newmis, '0 0 0', '0 0 0');
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = razor_trail_think;
};

void ()razor_think = {
	if (time < self.splash_time) {
		if (self.velocity == '0 0 0') {
			remove(self);
		}
		particle2 ( self.origin, ((self.velocity * -1) + '-20.00000 -20.00000 -20.00000'), ((self.velocity * -1) + '20.00000 20.00000 30.00000'), random(98, 108), 0, 5.00000);
		razor_trail();
		self.angles = vectoangles(self.velocity); 
		if (self.auraV != 1) {
			self.velocity_x -= ((self.rmark_x / 7) + (self.umark_x / 7));
			self.velocity_y -= ((self.rmark_y / 7) + (self.umark_y / 7));
			self.velocity_z -= ((self.rmark_z / 7) + (self.umark_z / 7));
			self.fmark = self.fmark * 1.2;
			self.velocity += self.fmark;
		}
		AdvanceThinkTime(self, 0.1);
		self.think = razor_think;
	} else {
		remove(self);
	}
};

void ()razor_spawn = {
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.lifetime = 5.00000;
	newmis.splash_time = time + newmis.lifetime;
	newmis.solid = SOLID_PHASE;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.owner = self.owner;
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.abslight = 0.80000;
	newmis.scale = 0.5;
	newmis.classname = "razorwind";
	if (self.owner.classname == "player") {
		makevectors (self.owner.v_angle);
	} else {
		makevectors (vectoangles(self.owner.enemy.origin - self.owner.origin));
		v_up_z = v_up_z - (2 * v_up_z);
		v_right_z = v_right_z - (2 * v_right_z);
		v_forward_z = v_forward_z - (2 * v_forward_z);
	}
	newmis.rmark = v_right * random(-420, 420);
	newmis.umark = v_up * random(-20, 150);
	newmis.fmark = v_forward * 10;
	setorigin(newmis, (self.origin + random('-10 -10 -10', '10 10 10')));
	sound ( newmis, CHAN_VOICE, "aeroturn.wav", 1.00000, ATTN_NORM);

	newmis.velocity = ((v_forward * 10) + (newmis.rmark + newmis.umark));

	//if (self.owner.classname != "player") 
	//newmis.velocity_z = newmis.velocity_z - (2 * newmis.velocity_z); //fixes strange bug* 

	newmis.angles = vectoangles(newmis.velocity); 
	setmodel (newmis, "models/arazor.mdl");
	setsize(newmis, '-10 -10 -1', '10 10 1');
	newmis.touch = razor_hit;
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = razor_think;
};




void ()windball_think = {
	if (self.owner.classname == "player") {
		makevectors (self.owner.v_angle);
	} else {
		makevectors (self.owner.angles);
	}
	traceline ((self.owner.origin + '0 0 40') , ((self.owner.origin + '0 0 40')+(v_forward * 50)) , FALSE , self);
	setorigin(self, trace_endpos);
	if (self.owner.click == 2) {
		if (self.cnt < 1.2) {
			self.cnt += 0.05;
			if (random(1, 20) < 9) {
				sound ( self, CHAN_AUTO, "aeroball.wav", 1.00000, ATTN_NORM);
			}
		} else {
			self.owner.click = 3;

		}
		self.scale = self.cnt;
		AdvanceThinkTime(self, 0.1);
		self.think = windball_think;            
	} else {
		//	if (self.owner.click == 3) {
		if (self.scale < 0.09) {
			self.owner.click = 0;
			remove(self);
		} else {
			self.scale -= 0.2;
			if (self.owner.classname == "player") {
				if (self.owner.elemana >=2) {
					razor_spawn();
					self.owner.elemana -= 2;
				}
			} else {
				razor_spawn();
			}
		}               
		AdvanceThinkTime(self, 0.1);
		self.think = windball_think;            
	}
};

void ()windball_spawn = {


	if (self.click == 1) {
		sound ( self, CHAN_AUTO, "aeroball.wav", 1.00000, ATTN_NORM);

		newmis = spawn();
		newmis.spelldamage = self.spelldamage;
		//newmis.cnt = 69;
		newmis.solid = SOLID_NOT;
		newmis.movetype = MOVETYPE_NOCLIP;
		newmis.owner = self;
		newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
		newmis.abslight = 0.80000;
		setmodel (newmis, "models/dwarf.mdl");
		newmis.scale = 0.05;
		AdvanceThinkTime(newmis, 0.02);
		newmis.think = windball_think;
		self.click = 2;
	} else {
		return;
	}
};


