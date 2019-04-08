void ()rainstorm_think = {
	if (time < self.splash_time)
	{
		particle2 ( (self.origin + random('-200 -200 0', '200 200 64')), '-30.00000 -30.00000 -190.00000', '30.00000 30.00000 -490.00000', random(144, 159), 0, 2.00000);
		self.think = rainstorm_think;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
	else
	{
		if (random() < 0.25000)
		{
			sound ( self, CHAN_VOICE, "thnd2.wav", 1.00000, ATTN_NONE);
		}
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
};


void ()tol_think = {
	local float i;
	local entity head;


	if ( (pointcontents ( self.origin) == CONTENT_SKY) ) {
		remove ( self);
		return ;

	}

	if ((self.health < self.max_health) || ((self.owner != world) && (self.owner.health < self.max_health)))
	{
		if (self.owner != world)
		{
			if (self.owner.health < self.health)
				self.health = self.owner.health;
			else
				self.owner.health = self.health;
			
			self.owner.health += 10;
			if (self.owner.health > self.max_health)
				self.owner.health = self.max_health;
			
		}
		
		self.health = self.health + 10;
		if (self.health > self.max_health)
			self.health = self.max_health;
	}

	head = findradius (self.origin, (128.00000 * self.spellradiusmod));
	while (head)
	{
		if ((head.classname == "player") && visible(head)) {
			if (self.goalentity.origin == VEC_ORIGIN) {
				newmis = spawn();
				self.goalentity = newmis;
				newmis.solid = SOLID_NOT;
				newmis.movetype = MOVETYPE_NOCLIP;
				setorigin (newmis, self.origin + random('-200 -200 200', '200 200 512'));
				newmis.lifetime = random(5, 7);
				newmis.splash_time = (time + newmis.lifetime);
				AdvanceThinkTime(newmis, 0.1);
				newmis.think = rainstorm_think;
			}

			if (head.health < head.max_health) {
				head.health += self.spelldamage;
			}
			if (head.elemana < head.max_mana) {
				head.elemana += self.spelldamage;
			}
			//			sound ( self, CHAN_AUTO, "ambience/birds.wav", 1.00000, ATTN_NORM);
		}
		head = head.chain;
	}

	i = random(1, 5);
	while (i > 0)
	{
		makevectors(RandomVector('0 360 0'));
		particle2 ( (self.origin + ((v_forward * 128.00000) * self.spellradiusmod)), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(243, 246), 2, 20.00000);
		i -= 1;
	}
	traceline (self.origin + '0 0 24', self.origin - '0 0 400' , TRUE , self);
	setorigin (self, trace_endpos);
	AdvanceThinkTime(self, random(0.3, 1.8));
	self.think = tol_think;
};


void ()tol_grow = {
	local entity top;
	local entity oself;

	if (self.scale >= 1.2) {
		if (self.click != 1)
		{
			self.click = 1;
			/*
			self.solid = SOLID_BBOX;
			self.thingtype = THINGTYPE_WOOD;
			self.movetype = MOVETYPE_PUSHPULL;
			self.health = 200;
			self.th_die = chunk_death;
			self.mass = 9999;
			self.takedamage = DAMAGE_YES;
			*/
			//oself = self.controller;
			CreateEntityNew ( self, ENT_TREE, "models/tree2.mdl", tree2_death);
			//dprint("BARF28: ");
			//dprint(vtos(self.size));
			//dprint("\n");
			//setsize(self, '-40 -40 0', '40 40 256');
			particle2 ( (self.origin + random('-30.00000 -30.00000 -30.00000','30.00000 30.00000 30.00000')), '-200.00000 -200.00000 -20.00000', '200.00000 200.00000 200.00000', 255.00000, 1, 80.00000);
			particle2 ( (self.origin + random('-90 -90 0', '90 90 30')), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(243, 246), 2, 20.00000);
			
			top = spawn ( );
			top.scale = self.scale;
			
			//oself = self;
			//self = top;
			CreateEntityNew ( top, ENT_TREETOP, top.model, tree2_death);
			//self.size_z = 30;
			setsize(top, '-136 -136 0', '136 136 100');
			top.solid = SOLID_BBOX;
			top.thingtype = THINGTYPE_WOOD_LEAF;
			top.movetype = MOVETYPE_NOCLIP;
			
			//self = oself;
			setorigin(top, self.origin);
			//self.classname = "the_tree";
			//self.controller = oself;
			
			if ( self.scale ) {

				top.origin_z += (top.scale * 104.00000);
			} else {

				top.origin_z += 104.00000;

			}
			top.health = self.health;
			top.classname = "tree2top";
			top.owner = self;
			self.owner = top;
			
			AdvanceThinkTime(self, HX_FRAME_TIME);
			self.think = tol_think;
		}
	} else {
		self.scale += 0.02;
		particle2 ( (self.origin + random('-90 -90 0', '90 90 30')), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(243, 246), 2, 20.00000);
		AdvanceThinkTime(self, 0.1);
		self.think = tol_grow;
	}
};




void ()launch_tol = {
	local entity found;

	found = find(world, classname, "the_tree");
	while ( found ) {
		if ((found != world) && (found.controller == self.owner))
		{
			if (found.th_die)
				found.think = found.th_die;
			else
				found.think = SUB_Remove;
			
			AdvanceThinkTime(found, HX_FRAME_TIME);
		}
		
		found = find ( found, classname, "the_tree");
	}
	
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.controller = self.owner;
	makevectors (self.angles);
	traceline (self.origin , (self.origin+(v_forward * 55)) , FALSE , self);
	setorigin (newmis, trace_endpos);
	traceline (newmis.origin , (self.origin-('0 0 300')) , FALSE , self);
	setorigin (newmis, trace_endpos + ('0 0 20'));
	setmodel(newmis, "models/tree2.mdl");
	newmis.classname = "the_tree";
	setsize(newmis, '-40 -40 0', '40 40 256');
	newmis.hull = HULL_POINT;
	newmis.angles = random('0 -180 0', '0 180 0'); 
	newmis.scale = 0.5;
	newmis.solid = SOLID_NOT;
	newmis.max_health = 1000;
	newmis.movetype = MOVETYPE_NOCLIP;
	//newmis.drawflags |= (SCALE_TYPE_ZONLY | SCALE_ORIGIN_BOTTOM);
	newmis.drawflags |= SCALE_ORIGIN_BOTTOM;
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = tol_grow;
};

