void() shell_dissipate = {
	self.controller.takedamage = DAMAGE_YES;
	AdvanceThinkTime(self.controller, 0.02);
	if (((self.controller.classname == "player") && (self.controller.elemana < 1)) || (self.health < 1)) {
		self.controller.elemana = 0;
		AdvanceThinkTime(self, 0.02);
		self.think = chunk_death;
	} else {
		remove(self);
	}
};


void() shell_maintain = {
	if ((self.controller.elemana > 0) && (self.controller.click == 1)) {

		if (self.health < self.elemana) {
			self.controller.elemana -= (self.elemana - self.health);
			self.health = 100;
		}
		setorigin(self, ((self.controller.absmin + self.controller.absmax) * 0.5));
		self.velocity = '0 0 0';
		AdvanceThinkTime(self, 0.02);
		self.think = shell_maintain;
	} else {
		AdvanceThinkTime(self, 0.02);
		self.think = shell_dissipate;
	}
};


void() monster_shell = {
	self.takedamage = DAMAGE_NO;
	newmis = spawn();
	newmis.controller = self;
	setorigin(newmis, (self.origin + '0 0 40'));
	newmis.scale = 2.5;
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.abslight = 2.00000;
	setmodel(newmis, "models/dwarf.mdl");
	setsize(newmis, '-40 -40 -40', '40 40 40');
	newmis.solid = SOLID_BBOX;
	newmis.mass = 9999;
	newmis.movetype = MOVETYPE_FLY;
	newmis.thingtype = THINGTYPE_ICE;
	newmis.th_die = shell_dissipate;
	newmis.health = 100;
	newmis.classname = "lshield";
	newmis.takedamage = DAMAGE_YES;
	AdvanceThinkTime(newmis, random(0.5, 3.5));
	newmis.think = shell_dissipate;
};



void() light_shell = {


	if (self.elemana > 0) {
		self.shield = spawn();
		self.shield.controller = self;
		//self.shield.owner = self;
		self.shield.controller.takedamage = DAMAGE_NO;
		setorigin(self.shield, (self.origin + '0 0 40'));
		self.shield.scale = 2.5;
		self.shield.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
		self.shield.abslight = 2.00000;
		setmodel(self.shield, "models/dwarf.mdl");
		setsize(self.shield, '-40 -40 -40', '40 40 40');
		self.shield.solid = SOLID_BBOX;
		self.shield.movetype = MOVETYPE_FLY;
		self.shield.thingtype = THINGTYPE_ICE;
		self.shield.th_die = shell_dissipate;
		self.shield.health = 100;
		self.shield.elemana = 100;
		self.shield.mass = 9999;
		self.shield.classname = "lshield";
		self.shield.takedamage = DAMAGE_YES;
		AdvanceThinkTime(self.shield, 0.02);
		self.shield.think = shell_maintain;
	} else {
		centerprint(self, "you don't have enough mana!");
		return;
	}
};