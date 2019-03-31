entity  ()firefizz_smoke_generator;
void() LeapFrogThink;
entity() LeapFindTarget;
void() LeapfrogTouch = 
{ 
	if ((other == self.enemy) && (other != world))
	{
		T_RadiusDamageFlat (self, self.owner, self.spelldamage + random(self.spelldamage*(-0.12500), self.spelldamage*0.12500), 75.00000 * self.spellradiusmod, self.owner, FALSE);
		//sprint(self.owner, ftos(self.spelldamage));
		if (self.enemy.flags & FL_ONGROUND) {
			self.enemy.flags ^= FL_ONGROUND;
		}
		self.enemy.velocity += random('-120 -120 200', '120 120 450');

		//does 120 but we want a BIG explosion. 
		//So we'll ues 1000 !! ;-) 
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY); //Sets up a temporary entity 
		WriteByte (MSG_BROADCAST, TE_EXPLOSION); //Temporary entity is an explosion 
		WriteCoord (MSG_BROADCAST, self.origin_x); //Create at Backpack Origins(x) 
		WriteCoord (MSG_BROADCAST, self.origin_y); //Create at Backpack Origins(y) 
		WriteCoord (MSG_BROADCAST, self.origin_z); //Create at Backpack Origins(z) 
		BecomeExplosion (); //BANG 
	}
	// return;

	else
	{
		if ((other == self.owner) && (self.enemy == world)) 
		{ 
			return;
		} 
	}
	if (self.velocity == '0 0 0') 
	self.flags = self.flags + FL_ONGROUND; 
};

entity() LeapFindTarget =
{
	local entity head, selected;
	local float dist; 

	dist = 3000;

	selected = world; // nobody is selected

	head = findradius(self.origin, dist); // search for entities in a circle around the grenade's position
	while(head) // loop though those entities until there's none left
	{
		// if ( (((((((head.health && head.takedamage) && (head.flags2 & FL_ALIVE)) && visible ( head)) && (head != self)) && (head != world)) && (head.owner != self.owner)) && !(other.effects & EF_NODRAW) && head.solid != SOLID_BSP) )  
		//              if( (head.takedamage) && (head != self) && (head.flags2 & FL_ALIVE) && (head.owner != self.owner) && (head != self.owner) && head.solid != SOLID_BSP)
		if( ((head.takedamage) && (head != self) && (head.flags2 & FL_ALIVE) && (head.owner != self.owner) && (head != self.owner) && (head.classname != "woolysheep") && (head.solid != SOLID_BSP) && (head.classname != "player")) || ((deathmatch != 0) && (head.classname == "player")) )
		{
			traceline(self.origin,head.origin,TRUE,self); // check if I can see

			if ( (trace_fraction >= 1) && (vlen(head.origin - self.origin) < dist) ) 
			// make sure it's close enough, and it's closer than the last entity it checked
			{
				selected = head; // then its ok, make it what were after
				dist = vlen(head.origin - self.origin); 
				// set dist to how far it is, in case somethin is closer
			}
		}
		head = head.chain; // continue to check entities until there's nothing left
	}
	//if(selected != world) // if it found something, tell owner who or what it is
	//{
		//sprint(self.owner, "Targeting: ");
		//sprint(self.owner, selected.classname);
		//sprint(self.owner, "\n");
	//}
	return selected; // return this selected entity to the previous funtion
};


void() LeapFrogThink = 
{ 
	local vector dir, vtemp, tm; 
	local float r,dist; 

	if (time < self.splash_time)
	{
		dist=100; 
		if (self.enemy != world) // if we have an enemy 
		{ 
			if ( (!visible(self.enemy)) && (self.flags & FL_ONGROUND) ) // cant see it? 
			{ 
				traceline(self.origin + '0 0 40',self.enemy.origin,TRUE,self); 
				if(trace_fraction != 1) // if it's not visible from 40 units above 
				{ 
					// check if it's visible from 20 above 
					traceline(self.origin + '0 0 20',self.enemy.origin,TRUE,self); 
					if(trace_fraction < 1 && random() < 0.2) // too hard? 
					{ 
						self.enemy = world; // find sumthin 
						self.enemy = LeapFindTarget(); // else ta kill 
					} 
				} 
			} 
		} 
		// set its angles according to what direction it's going 
		self.angles = vectoangles(self.velocity); 
		if ((self.enemy == world) || (self.enemy.health < 1) || (self.enemy == self.owner)) 
		{ 
			// if there aint an enemy, if its dead or if its the owner 
			self.enemy = LeapFindTarget(); // find sumthin else 
		} 
		if (self.enemy != world) // if it has an enemy 
		{ 
			if(self.flags & FL_ONGROUND) // if its onground 
			{ 
				vtemp = self.enemy.origin + '0 0 10'; // vtemp is the position 10 units above its enemy 
				dir = normalize(vtemp - self.origin); // dir is the direction from it to its enemy 
				self.flags = self.flags - FL_ONGROUND; // take off its onground flag so it can jump 
				self.velocity = '0 0 200' + dir * 300; // jump 200 units up and 300 units towards enemy 
				self.angles = vectoangles(self.velocity); // turn in the direction its jumping 
			} 
			else // its not on the ground 
			{ 
				vtemp = self.enemy.origin + '0 0 10'; 
				dir = normalize(vtemp - self.origin); 
				self.velocity = self.velocity + dir * 30; // move forward 30 units/sec in case its jumping up stairs 
				self.angles = vectoangles(self.velocity); 
			} 
		} 
		else //if it has no enemy 
		{ 
			if (self.flags & FL_ONGROUND) // if its on the ground 
			{ 
				self.flags ^= FL_ONGROUND; // get off the ground 
				if (vlen(self.origin - self.owner.origin) > 128) {
					vtemp = self.owner.origin + '0 0 10'; // vtemp is the position 10 units above its enemy 
					dir = normalize(vtemp - self.origin); // dir is the direction from it to its enemy 
					self.velocity = '0 0 200' + dir * 300; // jump 200 units up and 300 units towards enemy 
					self.angles = vectoangles(self.velocity); // turn in the direction its jumping 
				} else {
					self.velocity_z = 200 + random()*50; // jump around in a random direction until it sees something 
					self.velocity_x = crandom()*200; // crandom function is randomly positive or negative 
					self.velocity_y = crandom()*200; 
				}
			} 
		} 
		
		AdvanceThinkTime(self, 0.2); // set the next time It will think 
	}
	else
	{
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
	if (pointcontents(self.origin) == CONTENT_WATER || pointcontents(self.origin) == CONTENT_SLIME)
	{
		sound (self, CHAN_WEAPON, "player/slimbrn1.wav", 1, ATTN_NORM); 
		firefizz_smoke_generator();
		remove(self);
	} 

};

void() W_FireLeapFrog =
{


	local   entity missile;

	self.magic_finished = (time + 1);
	//	sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);
	self.punchangle_x = -2;
	missile = spawn ();
	missile.spelldamage = self.spelldamage;
	missile.spellradiusmod = self.spellradiusmod;
	missile.owner = self.owner;
	missile.movetype = MOVETYPE_TOSS; // it will fall to the ground
	missile.solid = SOLID_BBOX;
	missile.classname = "leapfrog";

	// set missile speed

	makevectors (self.angles); // so it fires where u r lookin

	if (self.v_angle_x) // looking up or down instead of level (v_angle_x is not 0)
	missile.velocity = v_forward*600 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;

	else // just make it fly up and forward
	{
		missile.velocity = aim2(self, 10000);
		missile.velocity = missile.velocity * 600;
		missile.velocity_z = 200;
	}

	missile.avelocity = '0 0 0'; // this grenade won't spin around as it falls

	missile.angles = vectoangles(missile.velocity); // turn in the direction it's falling

	missile.lifetime = 16;
	missile.splash_time = (time + missile.lifetime);
	
	// this is for the targeting system.
	missile.enemy = world;
	missile.touch = LeapfrogTouch;
	missile.think = LeapFrogThink;
	AdvanceThinkTime(missile, 0.3);

	setmodel (missile, "models/flame1.mdl"); // look like a grenade
	missile.drawflags = MLS_ABSLIGHT;
	missile.abslight = 1.00000;
	missile.effects = newmis.effects | EF_DIMLIGHT; 


	setsize (missile, '-5 -5 -5', '5 5 5'); // set the size of it
	setorigin (missile, self.origin);	// set it's position to where the player is

};



