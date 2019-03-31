

vector tsunami_left;
vector tsunami_right;

void() tsunami_rubble_touch = {
	if (other.takedamage == DAMAGE_YES) {
		sound ( self, CHAN_AUTO, "weapons/gauntht1.wav", 1.00000, ATTN_NORM);
		if ((other.model == "models/tree2.mdl") || (other.model == "models/ntree.mdl") || (other.model == "models/tree.mdl") || (other.classname == "ntreetop") || (other.classname == "tree2top")) {
			T_Damage (other, self, self.owner, random(700, 1000));
		}
		if (self.model == "models/tree2.mdl") {
			T_Damage (other, self, self.owner, random(15, 45));
		}
		if (self.model == "models/cart.mdl") {
			T_Damage (other, self, self.owner, random(5, 15));
		}
		if (self.model == "models/chair.mdl") {
			T_Damage (other, self, self.owner, random(3, 9));
		}
		if (self.model == "models/stool.mdl") {
			T_Damage (other, self, self.owner, random(3, 9));
		}
		if (self.model == "models/bench.mdl") {
			T_Damage (other, self, self.owner, random(5, 15));
		}
	} else {
		self.think = SUB_Remove;
		AdvanceThinkTime(self, 0.02);
	}
};

void() tsunami_rubble_think = {
	if (time < self.splash_time)
	{
		traceline (self.origin+('0 0 400'), (self.origin-('0 0 800')) , TRUE , self);
		if ((trace_ent.classname == "worldspawn") && (trace_fraction < 1))
		{
			self.dest = trace_endpos;
			self.dest_z += self.hoverz;
			setorigin(self, self.dest);
		}
		AdvanceThinkTime(self, 0.1);
		self.think = tsunami_rubble_think;
	} else {
		AdvanceThinkTime(self, 0.02);
		self.think = ChunkShrink;
	}
};

void() tsunami_rubble = {
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.lifetime = 4;
	newmis.splash_time = (time + newmis.lifetime);
	newmis.owner = self.owner;
	if (random(1, 20) < 4) {
		//setorigin(newmis, (self.origin + random('-200 -200 0', '200 200 200')));
		setorigin(newmis, (self.origin + random('-200 -200 5', '200 200 70')));

	} else {
		//setorigin(newmis, random((tsunami_left + random('0 0 0', differencia)), (tsunami_right + random('0 0 0', differencia))));
		setorigin(newmis, random(tsunami_left, tsunami_right));
		newmis.origin_z += (differencia_z / 4);
	}
	newmis.scale = random(0.9, 1.4);
	newmis.auraV = random(1, 5);
	if (newmis.auraV < 6) {
		setmodel(newmis, "models/chair.mdl");
		setsize(newmis, '-5 -5 0', '5 5 10');
	}
	if (newmis.auraV < 5) {
		setmodel(newmis, "models/stool.mdl");
		setsize(newmis, '-5 -5 0', '5 5 10');

	}
	if (newmis.auraV < 4) {
		setmodel(newmis, "models/bench.mdl");
		setsize(newmis, '-10 -10 0', '10 10 20');

	}
	if (newmis.auraV < 3) {
		setmodel(newmis, "models/cart.mdl");
		setsize(newmis, '-20 -20 0', '20 20 40');

	}
	if (newmis.auraV < 2) {
		setmodel(newmis, "models/tree2.mdl");
		setsize(newmis, '-60 -60 0', '60 60 120');

	}

	newmis.touch = tsunami_rubble_touch;
	newmis.movetype = MOVETYPE_FLY;
	newmis.solid = SOLID_PHASE;
	makevectors(self.angles);
	newmis.velocity -= (v_forward * 600);
	newmis.avelocity = random('-200 -200 -200', '200 200 200');
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = tsunami_rubble_think;

};

void() tsunami_washer_touch = {
	if ((other.takedamage == DAMAGE_YES) && ((other.model != "models/tree2.mdl") || (other.model != "models/ntree.mdl") || (other.model != "models/tree.mdl") || (other.classname != "ntreetop") || (other.classname != "tree2top"))) {
		T_Damage (other, self, self.owner, random(1, 5));
		setorigin(other, (other.origin + random('0 0 10', '0 0 20')));
	}
};

void() tsunami_washer_think = {
	local entity head;
	local vector pos;
	
	traceline (self.origin+('0 0 400'), (self.origin-('0 0 800')) , TRUE , self);
	if ((trace_ent.classname == "worldspawn") && (trace_fraction < 1))
	{
		pitch_roll_for_slope (trace_plane_normal);
		self.dest = trace_endpos;
		self.dest_z += self.hoverz;
		setorigin(self, self.dest);
	}
	

	if (self.cnt < 40) {
		self.cnt += 1;
		if (random(1, 20) < 4) {
			sound (self, CHAN_AUTO, "tsunami.wav", 1, ATTN_NORM);
		}
		
		head = findradius ( self.origin, 200);
		while (head)
		{
			if (head.takedamage == DAMAGE_YES) {
				if (head.flags & FL_ONGROUND) {
					head.flags ^= FL_ONGROUND;
				}
				if (head.origin_z < self.origin_z)
					head.velocity += (self.velocity*0.12500) + random('0 0 30', '0 0 90');
				
				if (head != self.owner)
					T_Damage (head, self, self.owner, self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500));
				
				pos = random(head.absmin, head.absmax);
				particle2 ( pos, '-30.00000 -30.00000 -30.00000', '30.00000 30.00000 30.00000', (16.00000 + random(15.00000)), PARTICLETYPE_BLOB2, random(16, 32));

			}
			head = head.chain;
		}

		particle2 ( (self.origin + random('-200 -200 -20', '200 200 200')), '-90.00000 -90.00000 40.00000', '90.00000 90.00000 140.00000', random(144, 159), 17, random(1, 15));
		AdvanceThinkTime(self, 0.1);
		self.think = tsunami_washer_think;
	} else {
		AdvanceThinkTime(self, 0.1);
		self.think = ChunkShrink;
	}
};



void() tsunami_washer = {
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.owner = self.owner;

	if (random(1, 20) < 4) {
		setorigin(newmis, (self.origin + random('-200 -200 0', differencia)));
		sound (newmis, CHAN_AUTO, "tsunami.wav", 1, ATTN_NORM);

	} else {
		if (self.auraT == 0) {
			differencia_z += random(10, 45);
		} else {
			differencia_z -= random(10, 45);
		}
		setorigin(newmis, random((tsunami_left + random('0 0 0', differencia)), (tsunami_right + random('0 0 0', differencia))));
	}
	newmis.hoverz = differencia_z;
	if (random() < 0.5)
		newmis.skin = 2;
	else
		newmis.skin = 3;
	
	newmis.scale = random(1.7, 2.5);
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.abslight = 1.5;
	setmodel(newmis, "models/cloud.mdl");
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.solid = SOLID_NOT;
	makevectors(self.angles);
	newmis.velocity -= (v_forward * 600);
	newmis.avelocity = random('0 -200 0', '0 200 0');
	newmis.classname = "tsunami";
	AdvanceThinkTime(newmis, 0.02);
	newmis.think = tsunami_washer_think;
};

void() tsunami_washing = {
	if (self.cnt > 0) {
		self.cnt -= 1;
		if (self.cnt == 6) {
			self.auraT = 1;
		}
		tsunami_washer();
		tsunami_rubble();
		AdvanceThinkTime(self, 0.2);
		self.think = tsunami_washing;
	} else {
		remove(self);
	}
};

void() tsunami_test = {
	
	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	newmis.owner = self.owner;
	setorigin(newmis, self.origin);
	newmis.hull = HULL_POINT;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.angles = self.angles; 
	newmis.cnt = 15;

	makevectors(newmis.angles);

	traceline (newmis.origin , (newmis.origin-('0 0 600')) , TRUE , newmis);
	setorigin (newmis, trace_endpos);

	traceline (newmis.origin , (newmis.origin-(v_right * 300)) , TRUE , newmis);
	tsunami_left = trace_endpos;
	traceline (newmis.origin , (newmis.origin+(v_right * 300)) , TRUE , newmis);
	tsunami_right = trace_endpos;

	traceline (tsunami_left , (tsunami_left+(v_forward * 400)) , TRUE , newmis);
	tsunami_left = trace_endpos-(v_forward * 65);

	traceline (tsunami_right , (tsunami_right+(v_forward * 400)) , TRUE , newmis);
	tsunami_right = trace_endpos-(v_forward * 65);

	traceline (newmis.origin , (newmis.origin+(v_forward * 400)) , TRUE , newmis);
	setorigin (newmis, (trace_endpos - (v_forward * 80)));
	differencia = '0 0 0';

	AdvanceThinkTime(newmis, 0.02);
	newmis.think = tsunami_washing;
};

// particle2 ( (self.origin + random('-30 -30 0', '30 30 300')), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(96, 104), 15, 80.00000);

void() tsunami_launch_think = {
	if (self.cnt > 30) {
		self.cnt = 15;
		self.movetype = MOVETYPE_NOCLIP;
		AdvanceThinkTime(self, 0.05);
		self.think = tsunami_test;
	} else {
		particle2 ( (self.origin + random('-30 -30 0', '30 30 300')), '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', random(96, 104), 15, 80.00000);
		self.cnt += 1;
		AdvanceThinkTime(self, 0.05);
		self.think = tsunami_launch_think;
	}
};

void() tsunami_launch = {

	self.magic_finished = (time + 8);


	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.owner = self.owner;
	setorigin(newmis, self.origin);
	newmis.hull = HULL_POINT;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_FLY;
	makevectors(self.angles);
	newmis.velocity = (v_forward * 200);
	newmis.velocity_z = 0;
	newmis.angles = vectoangles(newmis.velocity); 
	AdvanceThinkTime(newmis, 0.1);
	newmis.think = tsunami_launch_think;

};