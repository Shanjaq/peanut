
void() lchain_think = {
	local entity nearest;
	
	local float dist1;
	local float dist2;

	if (self.count == self.lip)
		nearest = self.enemy;
	else
		nearest = findNearestHurtable(self.origin, 350.00000, 1, 0, FALSE);

	if (nearest != world)
	{
		self.goalentity = self.oldenemy;
		self.oldenemy = nearest;
		if (random() < 0.75000)
			self.dmg = ((self.spelldamage*0.75000) + random(self.spelldamage*(-0.50000), self.spelldamage*0.50000));
		else
			self.dmg = (self.spelldamage + random(self.spelldamage*(-0.75000), self.spelldamage*1.50000));
		
		if (self.oldenemy.status_effects & STATUS_WET)
			self.dmg *= 3.62500;
		
		do_lightning ( self.owner, 1, STREAM_ATTACHED, 3.00000, self.origin, ((self.oldenemy.absmax + self.oldenemy.absmin) * 0.50000), self.dmg);
		setorigin (self, ((self.oldenemy.absmax + self.oldenemy.absmin) * 0.50000));
	}
	else
	{
		self.count = 0;
	}
	
	
	if (self.count > 0)
	{
		self.think = lchain_think;
		self.count -= 1;
	}
	else
	{
		self.think = SUB_Remove;
	}
	AdvanceThinkTime(self, 0.16250);
};

void() lchain_launch = {
	local entity nearest;
	nearest = findNearestHurtable(self.origin, (400.00000 * self.spellradiusmod), 1, 0, TRUE);
	if (nearest != world)
	{
		newmis = spawn();
		newmis.spelldamage = self.spelldamage;
		newmis.spellradiusmod = self.spellradiusmod;
		newmis.owner = self.owner;
		newmis.count = rint(4.00000 * newmis.spellradiusmod);
		/*
		if (newmis.owner.handy == 2) {
			if (newmis.owner.Lsupport & SUPPORT_RADIUS)
				newmis.count += 4;
		} else if (newmis.owner.handy == 3) {
			if (newmis.owner.Rsupport & SUPPORT_RADIUS)
				newmis.count += 4;
		}
		*/
		
		newmis.lip = newmis.count;
		newmis.enemy = nearest;
		setorigin (newmis, self.origin);
		setmodel ( newmis, "models/null.spr");
		sound ( newmis, CHAN_VOICE, "rw11thu2.wav", 1.00000, ATTN_NORM);
		newmis.solid = SOLID_NOT;
		newmis.movetype = MOVETYPE_NOCLIP;
		AdvanceThinkTime(newmis, HX_FRAME_TIME);
		newmis.think = lchain_think;
	}
};