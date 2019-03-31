void() cage_break =
{
	//if (self.controller.solid == SOLID_NOT)
	//{
	//	self.controller.solid = SOLID_BBOX;
	//}
	self.think = chunk_death;
	AdvanceThinkTime(self,HX_FRAME_TIME);
};



void() cage_think = 
{
	// BAER added new lines below
	local vector randomvec;

	randomvec_z = random(-64,64);
	randomvec_x = random(-64,64);
	randomvec_y = random(-64,64);
	// BAER end of new code
	if (self.cnt < 1) 
	{
		//AdvanceThinkTime(self,0.01);
		//self.think = SUB_Remove;  BAER commented out old code
		//return;
		
		AdvanceThinkTime(self,HX_FRAME_TIME);
		self.think = cage_think;
		if (self.scale <= 0.15)
		{
			//if (self.controller.solid == SOLID_NOT)
			//{
			//	self.controller.solid = SOLID_BBOX;
			//}
			remove(self);
		}
		self.scale -= 0.15;
		return;
	} 
	else 
	{
		if (self.controller.flags2 & FL_ALIVE) {
			self.controller.origin = (self.origin - (self.controller.size_z * '0 0 0.5'));
		}
		// BAER not sure if i added new code here. oh well :P
		self.cnt -= 0.25; // BAER changed from 0.5 for both lines
		AdvanceThinkTime(self,0.25);
		if (self.controller != world)
		{
			AdvanceThinkTime(self.controller,0.5); // BAER changed from 1
			if (!self.controller.think)
			self.controller.think = SUB_Null;
		}
		self.think = cage_think;
		CreateLittleBlueFlash ( self.origin + randomvec);

	}
};

// BAER all new code
void() cage_swell =
{
	if (self.scale >= 1)
	{
		self.scale = 1;
		self.think = cage_think;
		AdvanceThinkTime(self,1);
	}
	else
	{
		self.scale += 0.25;
		self.think = cage_swell;
		AdvanceThinkTime(self,HX_FRAME_TIME);
	}


};


void() cage_launch = 
{
	newmis = spawn();
	newmis.cnt = (15 + random(15)); 
	// BAER end of new code
	if (other.flags2 & FL_ALIVE) 
	{
		newmis.origin = (other.origin	+ '0 0 30');
	} 
	else 
	{
		newmis.origin = (self.origin);
	}
	sound (newmis, CHAN_WEAPON, "catfire.wav", 1, ATTN_NORM);
	//	newmis.movetype = MOVETYPE_FLY;
	newmis.movetype = MOVETYPE_BOUNCE;
	newmis.solid = SOLID_BBOX;
	newmis.scale = 0.25; //BAER changed from 0.7 to 0.25
	newmis.thingtype = THINGTYPE_ICE;
	newmis.health = 90;
	newmis.th_die = cage_break;
	newmis.hull = HULL_NORMAL;
	newmis.mass = 200;
	newmis.takedamage = DAMAGE_YES;
	newmis.flags |= FL_PUSH;
	newmis.touch = obj_push;
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.abslight = 1; // BAER changed from 2
	setmodel ( newmis, "models/ghail.mdl");
	//BAER added this line of code
	newmis.skin = GLOBAL_SKIN_ICE;
	//BAER added this line of code
	newmis.controller = other;
	newmis.frame = (0 + random(4));
	newmis.angles = random('-700.00000 -700.00000 -700.00000','700.00000 700.00000 700.00000');
	setsize (newmis, '-45 -45 -30', '45 45 70');
	if (other.flags2 & FL_ALIVE) 
	{
		AdvanceThinkTime(other, newmis.cnt); 
		//other.solid = SOLID_NOT;
	}
	AdvanceThinkTime(newmis,0.01);
	newmis.think = cage_swell; // BAER changed from cage_think
	
};