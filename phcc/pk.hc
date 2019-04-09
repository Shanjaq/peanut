
void  ()launch_pk =  {
local vector push = '0.00000 0.00000 0.00000';
	local entity head;
	head = findradius ( self.origin, 128);

	makevectors ( self.angles);
	
	while (head)
	{
		//if (head.takedamage == DAMAGE_YES) {
		if ((head.solid != SOLID_BSP) && (head.movetype != MOVETYPE_NOCLIP) && (head.mass < 9999) && (head != self.owner) && (head.classname != "bloodspot") && (head.touch != puzzle_touch) && (head.touch != weapon_touch))
		{
			if (head.flags & FL_ONGROUND) {
				head.flags ^= FL_ONGROUND;
			}
			
			push = (head.velocity + (v_forward * 640.00000));
			if ((head.movetype == MOVETYPE_FLYMISSILE) || (head.movetype == MOVETYPE_BOUNCEMISSILE) || (head.movetype == MOVETYPE_BOUNCE))
				push_z = 128.00000;
			else
				push_z = 500.00000;
				
			
			head.velocity = push;
			sound ( head, CHAN_WEAPON, "skullwiz/push.wav", TRUE, ATTN_NORM);
			particle2 ( self.origin, '-90.00000 -90.00000 150.00000', '90.00000 90.00000 300.00000', 255.00000, MLS_TORCH, 80.00000);
			
			//sound ( self, CHAN_AUTO, "aerostart.wav", 1.00000, ATTN_NORM);
		}
		head = head.chain;
	}
};

