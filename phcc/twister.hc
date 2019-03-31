vector stormwind;
void() tsunami_rubble;
void() junker;

void() twister_twist = {
	if (self.model != "models/twister.mdl") {
		setmodel(self, "models/twister.mdl");
		self.drawflags |= SCALE_ORIGIN_BOTTOM;
	}
	if (random() < 0.36250)
		sound (self, CHAN_AUTO, "crusader/tornado.wav", 1, ATTN_NORM);
	
	stormwind = random('-3 -3 0', '3 3 0');
	self.velocity += stormwind;
	if (self.cnt == 0) {
		if (self.frame >= 122) {
			self.cnt = 1;
			junker();
		} else {
			self.frame += 1;
		}
	}
	if (self.cnt == 1) {
		if (self.frame > 23) {
			self.frame = 0;
		} else {
			self.frame += 1;
		}
	}
	if (self.lifetime == 50) {
		self.cnt = 2;
		self.frame = 76;
	}
	if (self.cnt == 2) {
		if(self.frame > 100) {
			self.cnt = 3;
		} else {
			self.frame += 1;
		}
	}
	if (self.cnt == 3) {
		if(self.frame > 74) {
			remove(self);
			stormwind = '0 0 0';
		} else {
			self.frame += 1;
		}
	}
	self.lifetime -= 1;
	AdvanceThinkTime(self, 0.1);
	self.think = twister_twist;
};

void() twister_drop = {
	traceline (self.origin, (self.origin-('0 0 800')) , TRUE , self);
	newmis = spawn();
	newmis.classname = "twister_part";
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	self.controller = newmis;
	setorigin(newmis, trace_endpos);
	newmis.frame = 100;
	//newmis.scale = 1.6 * newmis.spellradiusmod;
	newmis.scale = (2.00000 * trace_fraction);
	newmis.lifetime = 200;
	//setmodel(newmis, "models/twister.mdl");
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	AdvanceThinkTime(newmis, 3);
	newmis.think = twister_twist;
};

void() twister_cloud_think = {
	//self.velocity += stormwind;
	if (self.controller != world)
	{
		self.origin_x = self.controller.origin_x;
		self.origin_y = self.controller.origin_y;
	}
	
	if (self.goalentity != world)
	{
		self.goalentity.origin_x = self.origin_x;
		self.goalentity.origin_y = self.origin_y;
	}
	
	if (time < self.splash_time) {
		
		if ((self.glow_dest > self.glow_last) && (self.scale >= self.glow_dest))
		{
			self.glow_last = self.glow_dest;
			self.glow_dest = (random(1.25000, 1.60000) * self.spellradiusmod);
			self.glow_delay = random(0.62500, 1.36250);
			self.glow_time = (time + self.glow_delay);
		}
		else if ((self.glow_dest < self.glow_last) && (self.scale <= self.glow_dest))
		{
			self.glow_last = self.glow_dest;
			self.glow_dest = (random(1.25000, 1.60000) * self.spellradiusmod);
			self.glow_delay = random(0.62500, 1.25000);
			self.glow_time = (time + self.glow_delay);
		}
		
		self.scale = (self.glow_last + ((1.00000 - ((self.glow_time - time) / self.glow_delay)) * (self.glow_dest - self.glow_last)));
		
		/*
		if ((self.health == 1) && (self.scale < 2.3)) {
			self.scale += 0.1;
		} else {
			self.health = 0;
		}
		if (self.health == 0) {
			if (self.scale > self.frags) {
				self.scale -= 0.05;
			} 
			if (self.scale < self.frags) {
				self.scale += 0.05;
			}
			if ((self.scale < (self.frags + 0.05)) && (self.scale > (self.frags - 0.05))) {
				self.frags = random(15, 23)/10;
			}
		}
		*/
		if (self.frame>28) {
			self.frame = 1;
		} else {
			self.frame += 1;
		}

		AdvanceThinkTime(self, 0.1);
		self.think = twister_cloud_think;
	} else {
		if (self.auraV != 1) {
			self.auraV = 1;
		}
		if (self.scale < 2.5) {
			self.scale += 0.05;
			self.abslight -= 0.01;
			if (self.frame>28) {
				self.frame = 1;
			} else {
				self.frame += 1;
			}
			AdvanceThinkTime(self, 0.1);
			self.think = twister_cloud_think;

		} else {
			AdvanceThinkTime(self, HX_FRAME_TIME);
			self.think = SUB_Remove;
		}
	}
};

void() junker_think = {
	local vector pull;
	local float  pull_speed;
	local entity head;
	head = findradius(self.origin, 400);

	while (head) {
		pull = self.origin - head.origin;

		if ( ((head.takedamage == DAMAGE_YES) || (head.classname == "razorwind") || (head.classname == "aero")) && ((head.solid != SOLID_BSP) && (head.touch != puzzle_touch) && (head.touch != weapon_touch)) ) {
			if (((head.classname == "razorwind") || (head.classname == "aero"))&& (head.auraV != 1)) {
				head.auraV = 1;
			}
			if ((vlen(head.origin - self.origin) < 400) ) {
				pull_speed = 0.5;
				normalize(pull);
				pull *= pull_speed;
				if (head.flags & FL_ONGROUND) {
					head.flags ^= FL_ONGROUND;
				}
				pull_z = 0;
				head.velocity += pull;
			}

			if ((vlen(head.origin - self.origin) < 300) ) {
				pull_speed = 1;
				normalize(pull);
				pull *= pull_speed;
				if (head.flags & FL_ONGROUND) {
					head.flags ^= FL_ONGROUND;
				}
				pull_z = 0;
				head.velocity += pull;
			}
			if ((vlen(head.origin - self.origin) < 200) ) {
				pull_speed = 2;
				normalize(pull);
				pull *= pull_speed;
				if (head.flags & FL_ONGROUND) {
					head.flags ^= FL_ONGROUND;
				}
				pull_z = 0;
				head.velocity += pull;

			}
			if ((vlen(head.origin - self.origin) < 100) ) {
				if (head.flags & FL_ONGROUND) {
					head.flags ^= FL_ONGROUND;
				}
				if (random(1, 20) < 8)
				{
					sound ( head, CHAN_VOICE, "weapons/gauntht1.wav", 1.00000, ATTN_NORM);
					if ((head.model == "models/tree2.mdl") || (head.model == "models/ntree.mdl") || (head.model == "models/tree.mdl") || (head.classname == "ntreetop") || (head.classname == "tree2top")) {
						T_Damage (head, self, self.owner, random(700, 1000));
					}
					if ((head.classname != "razorwind") && (head.classname != "aero") && (head != self.owner))
						T_Damage (head, self, self.owner, self.spelldamage + random(self.spelldamage*(-0.25000), self.spelldamage*0.25000));

				}
				if (head.classname == "razorwind")
					head.velocity += '0 0 12';
				else if (head.classname == "aero")
					head.velocity += '0 0 96';
				else
					head.velocity += '0 0 600';
			}
		}
		head = head.chain;
	}
	
	if (self.lifetime > 0) 
	{
		setorigin(self, self.controller.origin);
		particle2 ( (self.origin + random('-30 -30 0', '30 30 100')), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 150.00000', random(15, 25), 7, 50.00000);
		particle2 ( (self.origin + random('-30 -30 0', '30 30 100')), '-30.00000 -30.00000 25.00000', '30.00000 30.00000 50.00000', random(15, 25), 2, 50.00000);

		self.lifetime -= 1;
		AdvanceThinkTime(self, 0.1);
		self.think = junker_think;
	} else {
		remove(self);
	}
};

void() junker = {
	newmis = spawn();
	newmis.classname = "twister_part";
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.controller = self;
	newmis.owner = self.owner;
	setorigin (newmis, self.origin);
	newmis.scale = 1.7;
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.solid = SOLID_NOT;
	newmis.lifetime = 155;
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = junker_think;
};

void() twister_cloud = {
	self.cnt = 0;
	self.scale = 0.01250;
	setmodel(self, "models/cloud.mdl");
	self.velocity = '0 0 0';
	self.avelocity_y = random(-16, -38);
	self.lifetime = 18;
	self.splash_time = (time + self.lifetime);
	self.classname = "twister_part";
	self.glow_last = 0.001250;
	self.glow_dest = random(0.25000, 0.80000);
	self.glow_delay = random(0.62500, 1.25000);
	self.glow_time = (time + self.glow_delay);
	twister_drop();
	self.movetype = MOVETYPE_NOCLIP;
	AdvanceThinkTime(self, 0.02);
	self.think = twister_cloud_think;
};

void() twister_missile_touch =
{
	if (self.controller.origin != VEC_ORIGIN)
		self.controller.cnt -= 1;
	
	T_RadiusDamageFlat (self, world, (self.dmg + random(self.dmg*(-0.12500), self.dmg*0.12500)), (self.dmg * 4), world, FALSE);
	if ((random() < 0.63750) && (self.model == "models/tree2.mdl"))
		sound (self, CHAN_AUTO, "dsgarstp.wav", 1, ATTN_NORM);
	
	self.velocity = VEC_ORIGIN;
	chunk_death();
};

void() twister_missile_remove =
{
	if (self.controller.origin != VEC_ORIGIN)
		self.controller.cnt -= 1;
	
	remove(self);
};

void() twister_missile = 
{
	local vector org;
	local float i;
	
	org = (self.origin + (random('-150 -150 -32', '150 150 -10') * self.spellradiusmod));
	while ((pointcontents(org) != CONTENT_EMPTY) && (i < 4))
	{
		org = (self.origin + (random('-150 -150 -32', '150 150 -10') * self.spellradiusmod));
		i += 1;
	}
	
	if (i < 4)
	{
		newmis = spawn();
		newmis.spelldamage = self.spelldamage;
		newmis.spellradiusmod = self.spellradiusmod;
		newmis.owner = self.owner;
		newmis.controller = self.controller;
		newmis.hull = HULL_POINT;		
		
		i = random();
		if (i < 0.16)
		{
			setmodel(newmis, "models/chair.mdl");
			setsize(newmis, '-5 -5 -5', '5 5 5');
			newmis.thingtype = THINGTYPE_WOOD;
		}
		else if (i < 0.32)
		{
			setmodel(newmis, "models/stool.mdl");
			setsize(newmis, '-5 -5 -5', '5 5 5');
			newmis.thingtype = THINGTYPE_WOOD;
		}
		else if (i < 0.48)
		{
			setmodel(newmis, "models/bench.mdl");
			setsize(newmis, '-10 -10 -10', '10 10 10');
			newmis.thingtype = THINGTYPE_WOOD;
		}
		else if (i < 0.64)
		{
			setmodel(newmis, "models/cart.mdl");
			setsize(newmis, '-20 -20 -20', '20 20 20');
			newmis.thingtype = THINGTYPE_WOOD;
		}
		else if (i < 0.80)
		{
			setmodel(newmis, "models/bush1.mdl");
			setsize(newmis, '-10 -10 -10', '10 10 10');
			newmis.thingtype = THINGTYPE_WOOD_LEAF;
		}
		else if (i <= 1.0)
		{
			setmodel(newmis, "models/tree2.mdl");
			setsize(newmis, '-40 -40 -50', '40 40 50');
			newmis.thingtype = THINGTYPE_WOOD_LEAF;
		}
		setorigin(newmis, org - ('0 0 1' * newmis.size_z));
		
		newmis.solid = SOLID_BBOX;
		newmis.movetype = MOVETYPE_FLYMISSILE;
		newmis.velocity = random('-128.00000 -128.00000 -190.00000', '128.00000 128.00000 -490.00000');
		newmis.angles = RandomVector ( '360.00000 360.00000 360.00000'); 
		newmis.avelocity = RandomVector ( '360.00000 360.00000 360.00000');
		newmis.dmg = newmis.size_x;
		
		newmis.touch = twister_missile_touch;
		newmis.think = twister_missile_remove;
		AdvanceThinkTime(newmis, 2.00000);
	}
};

void() twister_melee = {
	local entity head;
	self.dest2 = self.origin;
	self.dest2_z = self.auraV;
	self.dest2 = (self.dest2 + (random('-500 -500 0', '500 500 196')* self.spellradiusmod));
	
	//particle2 ( self.dest2, '-10.00000 -10.00000 50.00000', '10.00000 10.00000 300.00000', random(243, 246), 17, 80.00000);
	
	head = findradius(self.dest2, 256);
	while(head) {
		if (head.takedamage == DAMAGE_YES)
		{
			if (head.flags & FL_ONGROUND) {
				head.flags ^= FL_ONGROUND;
			}
			head.velocity += random('-300 -300 0', '300 300 300');
		}
		else if (head.movetype == MOVETYPE_FLYMISSILE)
		{
			head.velocity += random('-300 -300 0', '300 300 0');
		}
		else if ((head.movetype == MOVETYPE_BOUNCEMISSILE) || (head.movetype == MOVETYPE_BOUNCE))
		{
			head.velocity += random('-300 -300 96', '300 300 128');
		}
		head = head.chain;
	}
};

void() twister_launch = {
	local entity cloudspawner;
	
	if ( (deathmatch || coop) )
	{
		cloudspawner = find(world, classname, "twister_part");
		while ( cloudspawner ) {
			if ((cloudspawner != world) && (cloudspawner.owner == self.owner))
			{
				if (cloudspawner.model == "models/twister.mdl")
					cloudspawner.lifetime = 50;
				else
					cloudspawner.lifetime = 0;
				
				cloudspawner.splash_time = time;
			}
			
			cloudspawner = find ( cloudspawner, classname, "twister_part");
		}
	}
	
	cloudspawner = spawn();
	cloudspawner.classname = "twister_part";
	cloudspawner.cloud_style = 1;
	cloudspawner.cloud_height = 728;
	cloudspawner.melee_rate_low = 0.36250;
	cloudspawner.melee_rate_high = 1.00000;
	cloudspawner.th_melee = twister_melee;
	cloudspawner.missile_rate_low = 0.14286;
	cloudspawner.missile_rate_high = 0.63750;
	cloudspawner.missile_count = (2.00000 * self.spellradiusmod);
	cloudspawner.th_missile = twister_missile;
	clouds_spawner(cloudspawner);
	
	newmis = spawn();
	newmis.classname = "twister_part";
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	newmis.goalentity = cloudspawner;
	setorigin(newmis, self.origin);
	newmis.hull = HULL_POINT;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	setorigin(newmis, (cloudspawner.origin - '0 0 30'));

	AdvanceThinkTime(newmis, 0.1);
	newmis.think = twister_cloud;
};
