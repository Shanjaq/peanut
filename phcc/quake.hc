void ()ShockShake =
{
	local entity head;
	local float dist, inertia;
	

	if (time < self.splash_time)
	{
		head = findradius ( self.origin, self.mass);
		while (head)
		{
			if (head.classname == "player")
			{
				dist = (vlen ( (self.origin - head.origin)) / self.mass);
				inertia = (head.mass / 10);
				//head.punchangle_x = (((random() * 10) - 5) * (dist / self.mass));
				//head.punchangle_y = (((random() * 8) - 4) * (dist / self.mass));
				//head.punchangle_z = (((random() * 8) - 4) * (dist / self.mass));
				head.punchangle_x = (((random() * 10) - 5));
				head.punchangle_y = (((random() * 8) - 4));
				head.punchangle_z = (((random() * 8) - 4));
			}
			
			head = head.chain;
		}
		self.think = ShockShake;
		AdvanceThinkTime(self, 0.1);
	}
	else
	{
		self.think = SUB_Remove;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
};

void (float radius, float duration, entity source)ShockWave =
{
	newmis = spawn();
	newmis.owner = self;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NONE;
	newmis.classname = "quake";
	newmis.mass = fabs ( radius);
	newmis.lifetime = duration;
	newmis.splash_time = (time + newmis.lifetime);
	setorigin ( newmis, source.origin);
	
	newmis.think = ShockShake;
	AdvanceThinkTime(newmis, HX_FRAME_TIME);
};


void  ()ShakeRattleAndRoll =  
{
	local entity head;
	local float inertia;
	local float richter;
	local float dist;
	local float rand;
	local float boost;
	local vector dir;

	head = findradius ( self.origin, self.mass);
	if (!self.count)
	richter = (((self.mass / 100) * (self.lifetime - time)) / 3);
	else // Baer added the option of making extremity count.
	richter = (self.count * (self.lifetime - time)) / 3;
	while ( head ) 
	{
		if (head.classname == "player") // BAER removed all others. 
		{
			dist = (vlen ( (self.origin - head.origin)) / self.mass);
			if ( !head.mass ) 
			{
				inertia = 1;
			}
			else 
			{
				inertia = (head.mass / 10);
			}
			/* Baer commented out, damage should not be inflicted from the quake.
				if ( ((((!(head.flags2 & FL_ALIVE) && head.takedamage) && head.health) && (random() < 0.20000)) && (head != self.owner)) ) 
			{
					T_Damage ( head, self, self.owner, (richter * dist));
				} */
			if ( (head.flags & FL_ONGROUND) ) 
			{
				if ( (head != self.owner) ) 
				{
					if (head.classname == "player")
					{
						head.punchangle_x = ((random() * 10) - 5);
						head.punchangle_y = ((random() * 8) - 4);
						head.punchangle_z = ((random() * 8) - 4);
					} 
					else 
					{
						if (head.flags2 & FL_ALIVE) 
						{
							head.angles_y += ((random() * 20) - 10);
							rand = ((random() * 6) - 3);
							if ( (((head.angles_x + rand) > 30) || ((head.angles_x + rand) < -30)) ) 
							{
								head.angles_x -= rand;
							} 
							else 
							{
								head.angles_x += rand;
							}
							rand = ((random() * 6) - 3);
							if ( (((head.angles_z + rand) > 30) || ((head.angles_z + rand) < -30)) ) 
							{
								head.angles_z -= rand;
							} 
							else 
							{
								head.angles_z += rand;

							}
						} 
						else 
						{
							if (head.movetype != MOVETYPE_BOUNCE) 
							{
								head.oldmovetype = head.movetype;
								head.movetype = MOVETYPE_BOUNCE;
							} 
							else 
							{
								if ( !head.oldmovetype ) 
								{
									head.oldmovetype = MOVETYPE_BOUNCE;
								}

							}
							head.avelocity_z = random(1,10);
							head.avelocity_y = ((random() * 720) - 360);
							head.avelocity_x = ((random() * 720) - 360);
						}
					}
					boost = ((((random(100) + 25) / inertia) * richter) * dist);
					if ( (boost > 100) ) 
					{
						boost = 100;
					}
					head.velocity_z += boost;
				}
				if ( (self.owner.classname == "monster_golem_bronze") ) 
				{
					dir = normalize ( (self.owner.origin - head.origin));
					dir_z = 0;
					head.velocity = (head.velocity + (dir * (((((random() * 50) - 25) / inertia) * richter) * dist)));
				} 
				else 
				{
					head.velocity_y += (((((random() * 50) - 25) / inertia) * richter) * dist);
					head.velocity_x += (((((random() * 50) - 25) / inertia) * richter) * dist);
					head.flags ^= FL_ONGROUND;
				}
			}
			if ( (self.lifetime < (time + 0.20000)) ) 
			{
				if ( ((head.movetype != head.oldmovetype) && (head.movetype == MOVETYPE_BOUNCE)) ) 
				{
					head.movetype = head.oldmovetype;
				}
				if ( ((head.classname != "player") && ((head.angles_x != 0) || (head.angles_y != 0))) ) 
				{
					head.angles_x = 0;
					head.angles_z = 0;
				}
			}
		}
		head = head.chain;
	}
	if ( (self.lifetime > time) ) 
	{
		self.think = ShakeRattleAndRoll;
	} 
	else 
	{
		self.think = SUB_Remove;
	}
	self.nextthink = (time + 0.10000);
};


void  (float richter, entity source)MonsterQuake =  
{
	newmis = spawn ( );
	newmis.owner = self;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_NONE;
	newmis.classname = "quake";
	newmis.think = ShakeRattleAndRoll;
	newmis.nextthink = time;
	newmis.mass = fabs ( richter);
	newmis.lifetime = (time + 3);
	setorigin ( newmis, source.origin);
	//   sound ( newmis, CHAN_AUTO, "weapons/explode.wav", 1, ATTN_NORM);
	sound ( newmis, CHAN_AUTO, "fx/quake.wav", 1, ATTN_NORM);
};

void (float rich_radius, float duration, float extremity)SilentQuake =
{
	local entity newmis;

	newmis = spawn();
	newmis.count = extremity;
	newmis.mass = rich_radius;
	newmis.think = ShakeRattleAndRoll;
	newmis.nextthink = time + 0.1;
	newmis.lifetime = time + duration;
};
// BAER end of code
