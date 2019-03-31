void() magnet_fragment_think = 
{
};

void() magnet_fragment = 
{
};

void () magnet_projectile_touch =
{
};

void () magnet_projectile_think =
{
	local entity found;
	local float inertia = 0.00000;
	local float force = 45.00000;
	local vector dir;

	found = findradius (self.origin, 500.00000);
	while (found)
	{
		if ((found.takedamage == DAMAGE_YES) && (found != self.owner) && (found.movetype != MOVETYPE_NONE))
		{
			dir = normalize(self.origin - found.origin);
			if (found.mass <= 10.00000)
			{
				inertia = 1.00000;
			}
			else 
			{
				inertia = (found.mass / 10.00000);
			}

			found.velocity_x = (found.velocity_x + (self.velocity_x / inertia));
			found.velocity_y = (found.velocity_y + (self.velocity_y / inertia));
			found.friction = 0.20000;
			found.solid = SOLID_SLIDEBOX;
			found.flags ^= FL_ONGROUND;
			found.velocity = ((dir * (1.00000 / inertia)) * force);
		}
		found = found.chain;
	}
	self.think = magnet_projectile_think;
	AdvanceThinkTime(self, 0.05000);
};


void() magnet_projectile_launch = 
{
	makevectors (self.angles);
	traceline (self.origin , (self.origin+(v_forward * 55)) , FALSE , self);
	
	sound (self, CHAN_WEAPON, "catfire.wav", 1, ATTN_NORM);

	newmis = spawn();
	newmis.owner = self.owner;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_TRIGGER;
	newmis.touch = SUB_Remove;
	newmis.movedir = v_forward;
	newmis.velocity = (newmis.movedir * 100);
	setmodel ( newmis, "models/dwarf.mdl");
	setsize ( newmis, '-5.00000 -5.00000 -5.00000', '5.00000 5.00000 5.00000');
	setorigin (newmis, trace_endpos);
	newmis.think = magnet_projectile_think;
	AdvanceThinkTime(newmis, 0.1);
};