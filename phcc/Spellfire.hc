
void  ()spellz = {

	if (self.frame>5) {
		self.think = SUB_Remove;
		self.nextthink = (time + 0);
		return;
	} else {
		self.frame = (self.frame + 1);
		self.think = spellz;
		self.nextthink = (time + 0.08);
	}
};

void  ()spelly = {
	local entity spell;

	spell = spawn();
	setorigin (spell, self.origin);
	spell.solid = SOLID_NOT;
	spell.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	setmodel (spell, "models/spell.mdl");
	spell.abslight = 0.5;
	spell.owner = self.owner;
	// splash.scale = self.cscale;

	if (self.UFO == 1) {
		if (self.click == 1) {
			if (self.ions<4) {
				spell.skin = 0;
				spell.scale = 0.3;
			}
			if ((self.ions<7) && (self.ions>3)) {
				spell.skin = 1;
				spell.scale = 0.5;
			}
			if ((self.ions<10) && (self.ions>6)) {
				spell.skin = 2;
				spell.scale = 0.7;
			}
			if ((self.ions<13) && (self.ions>9)) {
				spell.skin = 3;
				spell.scale = 0.9;
			}
			if ((self.ions<15) && (self.ions>12)) {
				spell.skin = 4;
				spell.scale = 1.1;
			} 
			if (self.ions == 15) {
				spell.scale = 1.4;
				spell.skin = 5;
			}
		}

		if (self.click == 0) {
			if (self.level == 1) {
				spell.skin = 0;
				spell.scale = 0.2;
			}
			if (self.level == 2) {
				spell.skin = 1;
				spell.scale = 0.3;
			}
			if (self.level == 3) {
				spell.skin = 2;
				spell.scale = 0.4;
			}
			if (self.level == 4) {
				spell.skin = 3;
				spell.scale = 0.5;
			}
			if (self.level > 4) {
				spell.skin = 4;
				spell.scale = 0.6;
			} 
		}
	} else {

		if (self.menutype == 0) {
			spell.skin = 5;
		} else {
			spell.skin = (self.menutype - 1);
		}
		if (self.handy == 2)
		{
			if (self.Lspell > 0)
				spell.skin = (((self.Lspell - 1) - fmod((self.Lspell - 1), 6)) / 6);
			else
				spell.skin = 0;
		}
		else if (self.handy == 3)
		{
			if (self.Rspell > 0)
				spell.skin = (((self.Rspell - 1) - fmod((self.Rspell - 1), 6)) / 6);
			else
				spell.skin = 0;
		}
		
		if (self.menuitem == 0) {
			spell.scale = 1;
		}
		if (self.menuitem == 1) {
			spell.scale = 1.3;
		}
		if (self.menuitem == 2) {
			spell.scale = 1.5;
		}
		if (self.menuitem == 3) {
			spell.scale = 1.9;
		}
		if (self.menuitem == 4) {
			spell.scale = 2.2;
		}
		if (self.menuitem == 5) {
			spell.scale = 2.5;
		}
	}

	spell.frame = 0;
	if (self.UFO == 1) {
		spell.angles = (self.v_angle + '90 180 0');
	} else {
		spell.angles = (self.angles);
	}
	spell.think = spellz;
	spell.nextthink = (time + 0.02);
};

void ()spell_mana_marker_think =
{
	local float support, scharge;
	
	makevectors (self.owner.v_angle);
	traceline ((self.owner.origin + self.owner.proj_ofs), ((self.owner.origin + self.owner.proj_ofs)+(v_forward * 55)) , FALSE , self.owner);
	self.angles = self.owner.v_angle;
	self.angles_x *= -1;
	self.velocity = self.owner.velocity;
	setorigin ( self, ((trace_endpos - (v_up * 16)) - (v_right * 46)) );


	if ((self.owner.handy == 0) || (self.owner.handy == 2))
	{
		support = self.owner.Lsupport;
		scharge = self.owner.LfingerC;
	}
	if ((self.owner.handy == 1) || (self.owner.handy == 3))
	{
		support = self.owner.Rsupport;
		scharge = self.owner.RfingerC;
	}
	
	if (self.owner.handy >= 2)
		self.splash_time = (time + 5);
	
	if (self.menubar_type == 0)
	{
		self.scale = 1.00000;
	}
	else if (self.menubar_type == 1)
	{
		self.cnt = self.owner.elemana;
		if (self.cnt > 0.00000)
		{
			self.effects ^= EF_NODRAW;
			self.scale = (self.cnt / self.owner.max_mana);
		}
		else
			self.effects |= EF_NODRAW;
	}
	else if (self.menubar_type == 2)
	{
		if (support & SUPPORT_RADIUS)
		{
			if (self.owner.handy >= 2)
				if (time < scharge)
					self.cnt = (self.owner.elemana - (self.owner.spellcost * (1.00000 - ((scharge - time) / self.owner.spelltop))));
				else
					self.cnt = (self.owner.elemana - self.owner.spellcost);
			else
			{
				if (time < (scharge * 0.6375))
					self.cnt = (self.owner.elemana - (self.owner.spellcost * (1.00000 - ((scharge - time) / self.owner.spelltop))));
				else
					self.cnt = self.owner.elemana - (self.owner.spellcost * 0.6375);
			}
		}
		else
		{
			self.cnt = (self.owner.elemana - self.owner.spellcost);
		}
		
		//self.cnt = (self.owner.elemana - self.owner.spellcost);
		if (self.cnt > 0.00000)
		{
			self.effects ^= EF_NODRAW;
			self.scale = (self.cnt / self.owner.max_mana);
		}
		else
			self.effects |= EF_NODRAW;
	}

	//if (self.owner.dest_z < time) {
	if (self.owner.handy >= 2)
	{
		if (time > self.splash_time) {
			remove(self);
		}
	}
	else
	{
		if (self.owner.dest_z < time) {
			remove(self);
		}
	}

	AdvanceThinkTime(self, 0.1);
	self.think = spell_mana_marker_think;
};

void ()spell_mana_marker =
{
	newmis = spawn();
	newmis.hull = HULL_POINT;
	newmis.owner = self;
	newmis.solid = SOLID_NOT;
	setmodel(newmis, "models/menubar.mdl");
	newmis.drawflags |= (MLS_ABSLIGHT | DRF_TRANSLUCENT);
	newmis.abslight = 0.5;
	newmis.skin = 0;
	newmis.menubar_type = 0;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.classname = "menubar";
	AdvanceThinkTime(newmis, 0.1);
	newmis.think = spell_mana_marker_think;

	newmis = spawn();
	newmis.hull = HULL_POINT;
	newmis.owner = self;
	newmis.solid = SOLID_NOT;
	setmodel(newmis, "models/menubar.mdl");
	newmis.skin = 2;
	newmis.menubar_type = 1;
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT | SCALE_TYPE_ZONLY | SCALE_ORIGIN_BOTTOM);
	newmis.abslight = 0.5;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.classname = "menubar";
	AdvanceThinkTime(newmis, 0.1);
	newmis.think = spell_mana_marker_think;

	newmis = spawn();
	newmis.hull = HULL_POINT;
	newmis.owner = self;
	newmis.solid = SOLID_NOT;
	setmodel(newmis, "models/menubar.mdl");
	newmis.skin = 2;
	newmis.menubar_type = 2;
	newmis.drawflags |= (MLS_ABSLIGHT | SCALE_TYPE_ZONLY | SCALE_ORIGIN_BOTTOM);
	newmis.abslight = 0.75;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.classname = "menubar";
	AdvanceThinkTime(newmis, 0.1);
	newmis.think = spell_mana_marker_think;
};

void ()spell_status_marker_think = {
	local vector slot_angle;
	makevectors (self.owner.v_angle);
	traceline ((self.owner.origin + self.owner.proj_ofs), ((self.owner.origin + self.owner.proj_ofs)+(v_forward * 55)) , FALSE , self.owner);
	self.angles = self.owner.v_angle;
	self.angles_x *= -1;
	self.velocity = self.owner.velocity;
	slot_angle = self.angles;
	
	slot_angle_z = slot_angle_z + ((360.00000 / 5.00000) * self.auraV);
	slot_angle_x *= -1;
	

	if (self.owner.dest_x == 0)
	{
		if ((spell_support->self.owner.Lspell) & fexp(2, self.auraV))
			self.skin = self.auraV;
		else
			self.skin = 5;
		
		self.dest = (trace_endpos - (v_right * 15));
		makevectors (slot_angle);
		setorigin (self, (self.dest + (v_up * 8)));
		if ((self.owner.Lsupport & fexp(2, self.auraV)) && (self.drawflags & DRF_TRANSLUCENT))
			self.drawflags ^= DRF_TRANSLUCENT;
		else if (!(self.owner.Lsupport & fexp(2, self.auraV)) && !(self.drawflags & DRF_TRANSLUCENT))
			self.drawflags |= DRF_TRANSLUCENT;
	}
	else if (self.owner.dest_x == 1)
	{
		if ((spell_support->self.owner.Rspell) & fexp(2, self.auraV))
			self.skin = self.auraV;
		else
			self.skin = 5;
		
		self.dest = (trace_endpos + (v_right * 15));
		makevectors (slot_angle);
		setorigin (self, (self.dest + (v_up * 8)));
		if ((self.owner.Rsupport & fexp(2, self.auraV)) && (self.drawflags & DRF_TRANSLUCENT))
			self.drawflags ^= DRF_TRANSLUCENT;
		else if (!(self.owner.Rsupport & fexp(2, self.auraV)) && !(self.drawflags & DRF_TRANSLUCENT))
			self.drawflags |= DRF_TRANSLUCENT;
	}

	if (self.owner.dest_z < time) {
		//self.owner.menuhand = 0;
		remove(self);
	}

	AdvanceThinkTime(self, 0.1);
	self.think = spell_status_marker_think;
};

void ()spell_status_marker = {
	local float i = 0;

	while (i < 5)
	{
		newmis = spawn();
		newmis.auraV = i;
		newmis.skin = 5;
		newmis.hull = HULL_POINT;
		newmis.owner = self;
		newmis.solid = SOLID_NOT;
		setmodel(newmis, "models/i_spellmod.mdl");
		newmis.drawflags |= (MLS_ABSLIGHT | DRF_TRANSLUCENT);
		newmis.abslight = 0.5;
		newmis.scale = 0.25;
		newmis.movetype = MOVETYPE_FLYMISSILE;
		newmis.classname = "menubar";
		AdvanceThinkTime(newmis, 0.1);
		newmis.think = spell_status_marker_think;
		i += 1;
	}
};

void ()charge_beacon_think = {
	local vector dir;
	local float len;
	
	if (self.owner.handy >= 2)
		self.splash_time = (time + 5);
	
	self.angles = self.owner.v_angle;
	self.angles_x *= -1;
	self.velocity = self.owner.velocity;
	
	makevectors (self.owner.v_angle);
	traceline ((self.owner.origin + self.owner.proj_ofs), ((self.owner.origin + self.owner.proj_ofs)+(v_forward * 55)) , FALSE , self.owner);
	if (self.skin == 0)
	{
		if ((self.owner.handy == 0) || (self.owner.handy == 2)) {
			if (self.step1 != self.owner.Lspell)
			{
				self.step1 = self.owner.Lspell;
				self.lip = (((self.step1 - 1) - fmod((self.step1 - 1), 6)) / 6);
			}
			setorigin (self, (trace_endpos - (v_right * 15)));
			if (self.owner.handy == 0)
			{
				if (time < (self.owner.LfingerC - ((0.36250 * self.owner.spelltop) * ((self.owner.Lsupport & SUPPORT_RADIUS) > 0))) )
				{
					self.scale = (1.00000 - ((self.owner.LfingerC - time) / self.owner.spelltop));
				}
				else
				{
					if (self.owner.Lsupport & SUPPORT_RADIUS)
						self.scale = 0.6375;
					else
						self.scale = 1;
				}
			}
			else if (self.owner.handy == 2)
			{
				if (time < self.owner.LfingerC)
				{
					self.scale = (1.00000 - ((self.owner.LfingerC - time) / self.owner.spelltop));
					
					if (self.scale > 0.6375)
					{
						dir = random('-1 -1 -1', '1 1 1');
						len = random(12, 48);
						if (self.lip == 0)
							particle2 ( self.origin + (dir * len), (dir * (len / -4)) + '-2 -2 -2', (dir * (len / -2)) + '2 2 2', (16.00000 + random(15.00000)), PARTICLETYPE_BLOB, random(8.00000, 12.00000));
						else if (self.lip == 1)
							particle2 ( self.origin + (dir * len), (dir * (len / -4)) + '-2 -2 -2', (dir * (len / -2)) + '2 2 2', (251.00000 + random(3.00000)), PARTICLETYPE_BLOB, random(8.00000, 12.00000));
						else if (self.lip == 2)
							particle2 ( self.origin + (dir * len), (dir * (len / -4)) + '-2 -2 -2', (dir * (len / -2)) + '2 2 2', (160.00000 + random(15.00000)), PARTICLETYPE_BLOB, random(8.00000, 12.00000));
						else if (self.lip == 3)
							particle2 ( self.origin + (dir * len), (dir * (len / -4)) + '-2 -2 -2', (dir * (len / -2)) + '2 2 2', (243.00000 + random(3.00000)), PARTICLETYPE_BLOB, random(8.00000, 12.00000));
						else if (self.lip == 4)
							particle2 ( self.origin + (dir * len), (dir * (len / -4)) + '-2 -2 -2', (dir * (len / -2)) + '2 2 2', (247.00000 + random(3.00000)), PARTICLETYPE_BLOB, random(8.00000, 12.00000));
						else if (self.lip == 5)
							particle2 ( self.origin + (dir * len), (dir * (len / -4)) + '-2 -2 -2', (dir * (len / -2)) + '2 2 2', (239.00000 + random(3.00000)), PARTICLETYPE_BLOB, random(8.00000, 12.00000));
					}
				}
				else
					self.scale = 1.00000;
			}
		}
		if ((self.owner.handy == 1) || (self.owner.handy == 3)) {
			if (self.step1 != self.owner.Rspell)
			{
				self.step1 = self.owner.Rspell;
				self.lip = (((self.step1 - 1) - fmod((self.step1 - 1), 6)) / 6);
			}
			setorigin (self, (trace_endpos + (v_right * 15)));
			if (self.owner.handy == 1)
			{
				if (time < (self.owner.RfingerC - ((0.36250 * self.owner.spelltop) * ((self.owner.Rsupport & SUPPORT_RADIUS) > 0))) )
				{
					self.scale = (1.00000 - ((self.owner.RfingerC - time) / self.owner.spelltop));
				}
				else
				{
					if (self.owner.Rsupport & SUPPORT_RADIUS)
						self.scale = 0.6375;
					else
						self.scale = 1;
				}
			}
			else if (self.owner.handy == 3)
			{
				if (time < self.owner.RfingerC)
				{
					self.scale = (1.00000 - ((self.owner.RfingerC - time) / self.owner.spelltop));
					
					if (self.scale > 0.6375)
					{
						dir = random('-1 -1 -1', '1 1 1');
						len = random(12, 48);
						if (self.lip == 0)
							particle2 ( self.origin + (dir * len), (dir * (len / -4)) + '-2 -2 -2', (dir * (len / -2)) + '2 2 2', (16.00000 + random(15.00000)), PARTICLETYPE_BLOB, random(8.00000, 12.00000));
						else if (self.lip == 1)
							particle2 ( self.origin + (dir * len), (dir * (len / -4)) + '-2 -2 -2', (dir * (len / -2)) + '2 2 2', (251.00000 + random(3.00000)), PARTICLETYPE_BLOB, random(8.00000, 12.00000));
						else if (self.lip == 2)
							particle2 ( self.origin + (dir * len), (dir * (len / -4)) + '-2 -2 -2', (dir * (len / -2)) + '2 2 2', (160.00000 + random(15.00000)), PARTICLETYPE_BLOB, random(8.00000, 12.00000));
						else if (self.lip == 3)
							particle2 ( self.origin + (dir * len), (dir * (len / -4)) + '-2 -2 -2', (dir * (len / -2)) + '2 2 2', (243.00000 + random(3.00000)), PARTICLETYPE_BLOB, random(8.00000, 12.00000));
						else if (self.lip == 4)
							particle2 ( self.origin + (dir * len), (dir * (len / -4)) + '-2 -2 -2', (dir * (len / -2)) + '2 2 2', (247.00000 + random(3.00000)), PARTICLETYPE_BLOB, random(8.00000, 12.00000));
						else if (self.lip == 5)
							particle2 ( self.origin + (dir * len), (dir * (len / -4)) + '-2 -2 -2', (dir * (len / -2)) + '2 2 2', (239.00000 + random(3.00000)), PARTICLETYPE_BLOB, random(8.00000, 12.00000));
					}
				}
				else
					self.scale = 1.00000;
			}
				
		}
	}
	else
	{
		if ((self.owner.handy == 0) || (self.owner.handy == 2)) {
			setorigin (self, (trace_endpos - (v_right * 15) + (v_forward * 1)));
			if ((self.effects & EF_NODRAW) && (self.owner.Lsupport & SUPPORT_RADIUS))
				self.effects ^= EF_NODRAW;
			else if (!(self.effects & EF_NODRAW) && !(self.owner.Lsupport & SUPPORT_RADIUS))
				self.effects |= EF_NODRAW;
		}
		if ((self.owner.handy == 1) || (self.owner.handy == 3)) {
			setorigin (self, (trace_endpos + (v_right * 15) + (v_forward * 1)));
			if ((self.effects & EF_NODRAW) && (self.owner.Rsupport & SUPPORT_RADIUS))
				self.effects ^= EF_NODRAW;
			else if (!(self.effects & EF_NODRAW) && !(self.owner.Rsupport & SUPPORT_RADIUS))
				self.effects |= EF_NODRAW;
				
		}
	}
	
	if (self.owner.handy >= 2)
	{
		if (time > self.splash_time) {
			remove(self);
		}
	}
	else
	{
		if (self.owner.dest_z < time) {
			remove(self);
		}
	}

	AdvanceThinkTime(self, 0.1);
	self.think = charge_beacon_think;
};

void ()charge_beacon = {
	newmis = spawn();
	newmis.hull = HULL_POINT;
	newmis.owner = self;
	newmis.solid = SOLID_NOT;
	setmodel(newmis, "models/spellcharge.mdl");
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.drawflags |= MLS_ABSLIGHT;
	newmis.abslight = 1.5;
	newmis.skin = 0;
	AdvanceThinkTime(newmis, 0.1);
	newmis.think = charge_beacon_think;

	newmis = spawn();
	newmis.hull = HULL_POINT;
	newmis.owner = self;
	newmis.solid = SOLID_NOT;
	setmodel(newmis, "models/spellcharge.mdl");
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.drawflags |= (MLS_ABSLIGHT | DRF_TRANSLUCENT);
	newmis.abslight = 1.5;
	newmis.skin = 1;
	newmis.scale = 0.6375;
	AdvanceThinkTime(newmis, 0.1);
	newmis.think = charge_beacon_think;
};


void ()spell_marker_think = {

	makevectors (self.owner.v_angle);
	traceline ((self.owner.origin + self.owner.proj_ofs), ((self.owner.origin + self.owner.proj_ofs)+(v_forward * 55)) , FALSE , self.owner);
	self.angles = self.owner.v_angle;
	self.angles_x *= -1;
	self.velocity = self.owner.velocity;
	self.skin = 6;

	if (self.owner.dest_x == 0) {
		self.angles_z = (self.angles_z + (self.auraV * 20));
		setorigin (self, (trace_endpos - (v_right * 15)));
		if ((self.owner.Lfinger1S > 0) && (self.auraV == 0))
			self.skin = (((self.owner.Lfinger1S - 1) - fmod((self.owner.Lfinger1S - 1), 6)) / 6);

		if ((self.owner.Lfinger2S > 0) && (self.auraV == 1))
			self.skin = (((self.owner.Lfinger2S - 1) - fmod((self.owner.Lfinger2S - 1), 6)) / 6);

		if ((self.owner.Lfinger3S > 0) && (self.auraV == 2))
			self.skin = (((self.owner.Lfinger3S - 1) - fmod((self.owner.Lfinger3S - 1), 6)) / 6);

		if ((self.owner.Lfinger4S > 0) && (self.auraV == 3))
			self.skin = (((self.owner.Lfinger4S - 1) - fmod((self.owner.Lfinger4S - 1), 6)) / 6);

		if ((self.owner.Lfinger5S > 0) && (self.auraV == 4))
			self.skin = (((self.owner.Lfinger5S - 1) - fmod((self.owner.Lfinger5S - 1), 6)) / 6);

	}
	if (self.owner.dest_x == 1) {
		self.angles_z = (self.angles_z - (self.auraV * 20));
		setorigin (self, (trace_endpos + (v_right * 15)));
		if ((self.owner.Rfinger1S > 0) && (self.auraV == 0))
			self.skin = (((self.owner.Rfinger1S - 1) - fmod((self.owner.Rfinger1S - 1), 6)) / 6);

		if ((self.owner.Rfinger2S > 0) && (self.auraV == 1))
			self.skin = (((self.owner.Rfinger2S - 1) - fmod((self.owner.Rfinger2S - 1), 6)) / 6);

		if ((self.owner.Rfinger3S > 0) && (self.auraV == 2))
			self.skin = (((self.owner.Rfinger3S - 1) - fmod((self.owner.Rfinger3S - 1), 6)) / 6);

		if ((self.owner.Rfinger4S > 0) && (self.auraV == 3))
			self.skin = (((self.owner.Rfinger4S - 1) - fmod((self.owner.Rfinger4S - 1), 6)) / 6);

		if ((self.owner.Rfinger5S > 0) && (self.auraV == 4))
			self.skin = (((self.owner.Rfinger5S - 1) - fmod((self.owner.Rfinger5S - 1), 6)) / 6);
	}

	if (self.owner.dest_y == self.auraV) {
		if (self.drawflags |= DRF_TRANSLUCENT)
		self.drawflags ^= DRF_TRANSLUCENT;
	} else {
		if (!(self.drawflags |= DRF_TRANSLUCENT))
		self.drawflags |= DRF_TRANSLUCENT;
	}


	if (self.owner.dest_z < time) {
		self.owner.menuhand = 0;
		remove(self);
	}

	AdvanceThinkTime(self, 0.1);
	self.think = spell_marker_think;

};



void (float thehand, float thefinger)spell_marker = {
	local float i = 0;

	self.dest_x = thehand;
	self.dest_y = thefinger;
	self.dest_z = time + 5;

	if (self.menuhand == 0) {
		self.menuhand = (thehand + 1);
		while (i < 5) {
			newmis = spawn();
			newmis.auraV = i;
			newmis.hull = HULL_POINT;
			newmis.owner = self;
			newmis.solid = SOLID_NOT;
			setmodel(newmis, "models/finger.mdl");
			newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
			newmis.abslight = 0.5;
			newmis.movetype = MOVETYPE_FLYMISSILE;
			newmis.classname = "finger";
			AdvanceThinkTime(newmis, 0.1);
			newmis.think = spell_marker_think;
			i += 1;
		}
		spell_status_marker();
		spell_mana_marker();
		charge_beacon();
	}

};


void (entity targ)spells_compute = {
	local float thespell;
	local float thecolor;
	local float support;

	if ((targ.handy == 0) || (targ.handy == 1)) {
		if (targ.handy == 0) {
			if (targ.Lfinger == 0) {
				targ.Lspell = targ.Lfinger1S;
				targ.Lsupport = targ.Lfinger1Support;
			}
			if (targ.Lfinger == 1) {
				targ.Lspell = targ.Lfinger2S;
				targ.Lsupport = targ.Lfinger2Support;
			}
			if (targ.Lfinger == 2) {
				targ.Lspell = targ.Lfinger3S;
				targ.Lsupport = targ.Lfinger3Support;
			}
			if (targ.Lfinger == 3) {
				targ.Lspell = targ.Lfinger4S;
				targ.Lsupport = targ.Lfinger4Support;
			}
			if (targ.Lfinger == 4) {
				targ.Lspell = targ.Lfinger5S;
				targ.Lsupport = targ.Lfinger5Support;
			}
			
			spell_marker(targ.handy, targ.Lfinger);
		}
		if (targ.handy == 1) {
			if (targ.Rfinger == 0) {
				targ.Rspell = targ.Rfinger1S;
				targ.Rsupport = targ.Rfinger1Support;
			}
			if (targ.Rfinger == 1) {
				targ.Rspell = targ.Rfinger2S;
				targ.Rsupport = targ.Rfinger2Support;
			}
			if (targ.Rfinger == 2) {
				targ.Rspell = targ.Rfinger3S;
				targ.Rsupport = targ.Rfinger3Support;
			}
			if (targ.Rfinger == 3) {
				targ.Rspell = targ.Rfinger4S;
				targ.Rsupport = targ.Rfinger4Support;
			}
			if (targ.Rfinger == 4) {
				targ.Rspell = targ.Rfinger5S;
				targ.Rsupport = targ.Rfinger5Support;
			}

			spell_marker(targ.handy, targ.Rfinger);
		}
		//shan?

		if (targ.handy == 0) {
			thespell = targ.Lspell;
			support = targ.Lsupport;
		}
		if (targ.handy == 1) {
			thespell = targ.Rspell;
			support = targ.Rsupport;
		}

		if (thespell == 0)
			return;
		
		thecolor = (((thespell - 1) - fmod((thespell - 1), 6)) / 6);
		targ.spellcost = ((spell_cost->thespell) / (magic_affinity->(thecolor + ((targ.playerclass - 1) * 6)))); //affinity
		targ.spelldamage = ((spell_damage->thespell) * (magic_affinity->(thecolor + ((targ.playerclass - 1) * 6)))); //affinity
		targ.spelltop = cast_time->thespell;
		targ.spellradiusmod = 1.00000;

		if (support & SUPPORT_CASTSPEED)
		{
			targ.spelltop *= 0.5;
		}

		if (support & SUPPORT_MULTI)
		{
			targ.spellcost *= 1.35;
			targ.spelltop *=  1.35;
			targ.spellradiusmod = 0.87500;
			targ.spelldamage *= 0.87500;
		}

		if (support & SUPPORT_DAMAGE)
		{
			targ.spellcost *= 1.35;
			targ.spelldamage *= 1.35;
		}
		
		if (support & SUPPORT_RADIUS)
		{
			targ.spelldamage *= 0.87500;
			targ.spellradiusmod *= 1.50000;
			targ.spelltop *= 1.25;
		}
		
		sprint(targ, "\n");
		sprint(targ, "spellcost: ");
		sprint(targ, ftos(targ.spellcost));
		sprint(targ, "\noriginal: ");
		sprint(targ, ftos(spell_cost->thespell));
		sprint(targ, "\n");
		
		if (thespell == 0) {
			centerprint(targ, "no spell!");
		}
		if (thespell == 1) {
			centerprint (targ, "Telekinesis@ yellow@ -7");
		}
		if (thespell == 2) {
			centerprint (targ, "Shell of Light@ yellow@ -damage");
		}
		if (thespell == 3) {
			centerprint (targ, "Teleportation@ yellow@ -10");
		}
		if (thespell == 4) {
			centerprint (targ, "Summon Meteorite@ yellow@ -20");
		}
		if (thespell == 5) {
			centerprint (targ, "Photon Beam@ yellow@ -30");
		}
		if (thespell == 6) {
			centerprint (targ, "Radiant Matter@ yellow@ -40");
		}
		if (thespell == 7) {
			centerprint (targ, "Flame Wave@ yellow@ -self.level*2-->5");
		}
		if (thespell == 8) {
			centerprint (targ, "Boot of Ignius@ yellow@ -5");
		}
		if (thespell == 9) {
			centerprint (targ, "Lavaball@ yellow@ -10");
		}
		if (thespell == 10) {
			centerprint (targ, "Sweltering Sky@ yellow@ -15");
		}
		if (thespell == 11) {
			centerprint (targ, "Pillar of Fire@ yellow@ -25");
		}
		if (thespell == 12) {
			centerprint (targ, "Giga Flare@ yellow@ -40");
		}
		if (thespell == 13) {
			centerprint (targ, "Lightning Strike@ yellow@ -8");
		}
		if (thespell == 14) {
			centerprint (targ, "Mole Spike@ yellow@ -8");
		}
		if (thespell == 15) {
			centerprint (targ, "Arc of Death@ yellow@ -10");
		}
		if (thespell == 16) {
			centerprint (targ, "Chain Lightning@ yellow@ -12");
		}
		if (thespell == 17) {
			centerprint (targ, "Landslide@ yellow@ -16");
		}
		if (thespell == 18) {
			centerprint (targ, "Electrical Storm@ yellow@ -35");
		}
		if (thespell == 19) {
			centerprint (targ, "Razor Wind@ yellow@ -2");
		}
		if (thespell == 20) {
			centerprint (targ, "Aero@ yellow@ -10");
		}
		if (thespell == 21) {
			centerprint (targ, "Bush Bash@ yellow@ -15");
		}
		if (thespell == 22) {
			centerprint (targ, "Telluric Regeneration@ yellow@ -20");
		}
		if (thespell == 23) {
			centerprint (targ, "Tree of Life@ -30");
		}
		if (thespell == 24) {
			centerprint (targ, "Tornado@ yellow@ -35");
		}
		if (thespell == 25) {
			centerprint (targ, "Arctic Wind@ yellow@ -1/2");
		}
		if (thespell == 26) {
			centerprint (targ, "Cold Spike@ yellow@ -5");
		}
		if (thespell == 27) {
			centerprint (targ, "Ice Cage@ yellow@ -7");
		}
		if (thespell == 28) {
			centerprint (targ, "Crush Drop@ yellow@ -15");
		}
		if (thespell == 29) {
			centerprint (targ, "Glacial Hail@ yellow@ -25");
		}
		if (thespell == 30) {
			centerprint (targ, "Tsunami@ yellow@ -35");
		}
		if (thespell == 31) {
			centerprint (targ, "Swarm of Rats@ yellow@ -10");
		}
		if (thespell == 32) {
			centerprint (targ, "Black Death@ yellow@ -15");
		}
		if (thespell == 33) {
			centerprint (targ, "Toxic Cloud@ yellow@ -20");
		}
		if (thespell == 34) {
			centerprint (targ, "Dark Matter@ yellow@ -25");
		}
		if (thespell == 35) {
			centerprint (targ, "Abyss@ yellow@ -30");
		}
		if (thespell == 36) {
			centerprint (targ, "Black Hole@ yellow@ -40");
		}

	}

};


void() spellfire_cast = {
	if ((self.solid == SOLID_PHASE) && (other != world))
		return;
	
	if ((other != world) && ((other.classname == "spellfire") || (other == self.owner)))
		return;
	
	self.velocity = '0 0 0';

	if (self.Lspell == 1) {
		launch_pk( );
	}
	
	//if (self.Lspell == 2) {
		//shell of light
	//}

	if (self.Lspell == 3) {
		teleport_spell();
	}

	if (self.Lspell == 4) {
		CometFall();
	}

	if (self.Lspell == 5) {
		photon_ball();	
	}

	if (self.Lspell == 6) {
		supernova_init();
	}

	if (self.Lspell == 7) {
		AxeSpikes();
	}

	if (self.Lspell == 8) {
		W_FireLeapFrog();							
	}

	if (self.Lspell == 9) {
		balloffire_launch();							
	}

	if (self.Lspell == 10) {
		obj_redM4();							
	}

	if (self.Lspell == 11) {
		volcano_start();							
	}

	if (self.Lspell == 12) {
		flare_drop();							
	}

	if (self.Lspell == 13) {
		obj_yellowM1();
	}

	if (self.Lspell == 14) {
		spire_drop ( );
	}

	if (self.Lspell == 15) {
		deatharc_launch();
	}

	if (self.Lspell == 16) {
		lchain_launch ( );
	}

	if (self.Lspell == 17) {
		SlideDrop ( );
	}
	if (self.Lspell == 18) {
		storm_launch();

	}

	//	if (self.Lspell == 19) {
	//		windball_spawn();
	//	}

	if (self.Lspell == 20) {
		//launch_aero();
		aero_init();
	}
	if (self.Lspell == 21) {
		bushbash_touch();
	}

	if (self.Lspell == 22) {
		TelluricRegen();
	}

	if (self.Lspell == 23) {
		launch_tol();	
	}

	if (self.Lspell == 24) {
		twister_launch();
	}

	//	if (self.Lspell == 25) {
	//		frost_launch();
	//	}

	if (self.Lspell == 26) {
		coldsp_launch();
	}

	if (self.Lspell == 27) {
		cage_launch();
	}

	if (self.Lspell == 28) {
		launch_crushdrop();	
	}

	if (self.Lspell == 29) {
		LaunchGlacierspawner();
	}

	if (self.Lspell == 30) {
		//tsunami_launch();
		tsunami_test();
	}

	if (self.Lspell == 31) {
		launch_swarm();
	}

	if (self.Lspell == 32) {
		blackdeath_swoop ( );
		//blackdeath_launch();
	}

	if (self.Lspell == 33) {
		toxic_cloud();
	}

	if (self.Lspell == 34) {
		dark_matter_init();
	}

	if (self.Lspell == 35) {
		darkbeam();
	}

	if (self.Lspell == 36) {
		bh_ball_drop();	
	}
	
	remove ( self);
};

void() spellfire_travel =
{
	local entity nearest;
	
	if (time < self.splash_time)
	{
		if (self.lip == 0)
			particle2 ( self.origin, '-30.00000 -30.00000 -30.00000', '30.00000 30.00000 30.00000', (16.00000 + random(15.00000)), PARTICLETYPE_BLOB2, random(5, 15));
		else if (self.lip == 1)
			particle2 ( self.origin, '-30.00000 -30.00000 -30.00000', '30.00000 30.00000 30.00000', (251.00000 + random(3.00000)), PARTICLETYPE_BLOB2, random(5, 15));
		else if (self.lip == 2)
			particle2 ( self.origin, '-30.00000 -30.00000 -30.00000', '30.00000 30.00000 30.00000', (160.00000 + random(15.00000)), PARTICLETYPE_BLOB2, random(5, 15));
		else if (self.lip == 3)
			particle2 ( self.origin, '-30.00000 -30.00000 -30.00000', '30.00000 30.00000 30.00000', (243.00000 + random(3.00000)), PARTICLETYPE_BLOB2, random(5, 15));
		else if (self.lip == 4)
			particle2 ( self.origin, '-30.00000 -30.00000 -30.00000', '30.00000 30.00000 30.00000', (247.00000 + random(3.00000)), PARTICLETYPE_BLOB2, random(5, 15));
		else if (self.lip == 5)
			particle2 ( self.origin, '-30.00000 -30.00000 -30.00000', '30.00000 30.00000 30.00000', (239.00000 + random(3.00000)), PARTICLETYPE_BLOB2, random(5, 15));

		if (self.attack_finished < time)
		{
			nearest = findNearestHurtable(self.origin, (96.00000), 0, FL_ALIVE, FALSE);
			if ((nearest != world) && ((deathmatch) || (nearest.team != self.owner.team)))
				spellfire_cast();
			else
				self.attack_finished = (time + 1.00000);
		}
		
		self.think = spellfire_travel;
		AdvanceThinkTime(self, (HX_FRAME_TIME));
	}
	else
	{
		self.think = spellfire_cast;
		AdvanceThinkTime(self, HX_FRAME_TIME);
	}
	
};



void() spellfire_init = {
	local float spcount;
	local float arc;
	
	spcount = 1.00000;
	if (self.Lsupport & SUPPORT_MULTI)
	{
		spcount = 3.00000;
	}
	self.cnt = spcount;
	
	if (spcount > 1)
	{
		if ((spell_type->self.Lspell) == SPELL_TYPE_PROJ_SLOW)
			if (self.classname == "spelltrap")
				arc = 240.00000;
			else
				arc = 64.00000;
		else
			arc = 36.00000;
		
		self.angles_y -= (arc / 2.00000);
		self.pos1 = self.origin;
	}
	
	while (self.cnt > 0) {
		newmis = spawn();
		newmis.spelldamage = self.spelldamage;
		newmis.spellradiusmod = self.spellradiusmod;
		/*
		if ((self.LfingerC > time) && (self.classname != "spelltrap"))
			newmis.spellradiusmod = (1.00000 - (newmis.spellradiusmod * ((self.LfingerC - time) / self.spelltop)));
		*/
		
		newmis.Lspell = self.Lspell;
		newmis.Lsupport = self.Lsupport;
		newmis.LfingerC = self.LfingerC;
		newmis.handy = 2;
		newmis.owner = self.owner;
		
		newmis.angles = self.angles;
		makevectors (newmis.angles);
		newmis.classname = "spellfire";
		newmis.hull = HULL_POINT;
		//setsize ( newmis, '-1.00000 -1.00000 -1.00000', '1.00000 1.00000 1.00000');
		setsize ( newmis, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
		newmis.solid = SOLID_NOT;
		setorigin (newmis, self.origin + (v_forward * 12));
		setmodel(newmis, "models/dwarf.mdl");
		newmis.movetype = MOVETYPE_FLYMISSILE;
		newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
		newmis.abslight = 1.5;
		newmis.lip = rint(((self.Lspell - 1) - fmod((self.Lspell - 1), 6)) / 6);
		
		if ((spell_type->self.Lspell) == SPELL_TYPE_NULL)
		{
			AdvanceThinkTime(newmis, HX_FRAME_TIME);
			newmis.think = spellfire_cast;
		}
		else if ((spell_type->self.Lspell) == SPELL_TYPE_PROJ)
		{
			newmis.solid = SOLID_TRIGGER;
			newmis.velocity = (v_forward * 1000);
			newmis.lifetime = 3.00000;
			newmis.splash_time = (time + newmis.lifetime);
			newmis.think = spellfire_travel;
			newmis.touch = spellfire_cast;
			AdvanceThinkTime(newmis, HX_FRAME_TIME);
		}
		else if ((spell_type->self.Lspell) == SPELL_TYPE_PROJ_SLOW)
		{
			if (self.classname == "spelltrap")
			{
				if (spcount > 1)
					setorigin (newmis, self.pos1 + (v_forward * (128.00000*newmis.spellradiusmod)));
				
				AdvanceThinkTime(newmis, HX_FRAME_TIME);
				newmis.think = spellfire_cast;
			}
			else
			{
				setsize ( newmis, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
				newmis.solid = SOLID_PHASE;
				newmis.velocity = (v_forward * 350);
				newmis.lifetime = 1.50000;
				newmis.splash_time = (time + newmis.lifetime);
				newmis.touch = spellfire_cast;
				newmis.think = spellfire_travel;
				AdvanceThinkTime(newmis, HX_FRAME_TIME);
			}
		}
		else if ((spell_type->self.Lspell) == SPELL_TYPE_PROJ_CUSTOM)
		{
			AdvanceThinkTime(newmis, HX_FRAME_TIME);
			newmis.think = spellfire_cast;
		}
		else if ((spell_type->self.Lspell) == SPELL_TYPE_TRACE)
		{
			traceline ( newmis.origin, (newmis.origin + (v_forward * 600.00000)), FALSE, self);
			setorigin (newmis, trace_endpos);
			newmis.enemy = trace_ent;
			AdvanceThinkTime(newmis, HX_FRAME_TIME);
			newmis.think = spellfire_cast;
		}
		
		self.angles_y += (arc / (spcount - 1));
		self.cnt -= 1;
	}	
	remove ( self);
};

void ()spelltrap_think = {
	local entity nearest;
	
	if (other == self.owner)
		return;
	
	if (self.solid == SOLID_PHASE)
	{
		self.solid = SOLID_NOT;
		self.touch = SUB_Null;
		self.velocity = '0 0 0';
		if (!(((other.takedamage && other.health) && ((other.classname == "player") || other.movetype)) && (other != self.owner)))
		{
			sound ( self, CHAN_BODY, "weapons/met2stn.wav", 1.00000, ATTN_NORM);
			SpawnPuff ( self.origin, '0.00000 0.00000 0.00000', random(16.00000, 24.00000), self);
			makevectors (self.angles);
			self.angles = vectoangles(self.origin - (self.origin + v_forward));
			self.angles_x *= -1;
		}
	}

	if ((spell_type->self.Lspell == SPELL_TYPE_PROJ) || (spell_type->self.Lspell == SPELL_TYPE_PROJ_CUSTOM) || (spell_type->self.Lspell == SPELL_TYPE_TRACE))
	{
		if (((other.takedamage && other.health) && ((other.classname == "player") || other.movetype)) && (other != self.owner))
		{
			spellfire_init();
			return;
		}
		
		makevectors (self.angles);
		traceline ( self.origin, (self.origin + (v_forward * 600.00000)), FALSE, self);

		if (trace_fraction == 1.00000)
		{
			spellfire_init();
		}
		else
		{
			WriteByte ( MSG_BROADCAST, SVC_TEMPENTITY);
			WriteByte ( MSG_BROADCAST, TE_STREAM_CHAIN);
			WriteEntity ( MSG_BROADCAST, self);
			WriteByte ( MSG_BROADCAST, (6 + STREAM_ATTACHED));
			WriteByte ( MSG_BROADCAST, 2.00000);
			WriteCoord ( MSG_BROADCAST, self.origin_x);
			WriteCoord ( MSG_BROADCAST, self.origin_y);
			WriteCoord ( MSG_BROADCAST, self.origin_z);
			WriteCoord ( MSG_BROADCAST, trace_endpos_x);
			WriteCoord ( MSG_BROADCAST, trace_endpos_y);
			WriteCoord ( MSG_BROADCAST, trace_endpos_z);
			nearest = trace_ent;
			if ((nearest == self.owner) || !(nearest.flags2 & FL_ALIVE))
				nearest = world;
		}
	}
	else
	{
		nearest = findNearestHurtable(self.origin, (250.00000*self.spellradiusmod), 0, FL_ALIVE, FALSE);
	}
	
	if (((nearest != world) && ((deathmatch) || (nearest.team != self.owner.team))) || (self.owner.trap_count == self.trap_count))
	{
		if (nearest != world)
		{
			self.enemy = nearest;
			self.angles = vectoangles(((nearest.absmin + nearest.absmax) * 0.50000) - self.origin);
			self.angles_x *= -1;
		}
		
		spellfire_init();
	} else {
		AdvanceThinkTime(self, 0.1);
		self.think = spelltrap_think;
	}
};

void() spellfire = {
	local float spell;
	local float support;
	local float scharge;
	
	if (self.handy == 2)
	{
		spell = self.Lspell;
		support = self.Lsupport;
		scharge = self.LfingerC;
	}
	else if (self.handy == 3)
	{
		spell = self.Rspell;
		support = self.Rsupport;
		scharge = self.RfingerC;
	}
	
	if (spell == 0)
		return;

	newmis = spawn();
	newmis.spelldamage = self.spelldamage;
	newmis.spellradiusmod = self.spellradiusmod;
	if (scharge > time)
		newmis.spellradiusmod = (1.00000 - (newmis.spellradiusmod * ((scharge - time) / self.spelltop)));
	
	if (self.classname == "player")
	{
		self.dest_z = time;
		//if (self.elemana < self.spellcost) {
		//dprintf("charge: %s\n", (self.spellcost - ((self.spellcost * ((scharge - time) / self.spelltop))) * ((support & SUPPORT_RADIUS) > 0) * (time < scharge)));
		if (self.elemana < (self.spellcost - ((self.spellcost * ((scharge - time) / self.spelltop))) * ((support & SUPPORT_RADIUS) > 0) * (time < scharge)) )
		{
			sprint(self, "you don't have enough mana!\n");
			return;
		}
		//self.elemana -= self.spellcost;
		self.elemana -= (self.spellcost - ((self.spellcost * ((scharge - time) / self.spelltop))) * ((support & SUPPORT_RADIUS) > 0) * (time < scharge));
		spelly();
		newmis.angles = self.v_angle;
	}
	else
	{
		if (self.enemy)
		{
			newmis.angles = vectoangles(((self.enemy.absmin + self.enemy.absmax) * 0.50000) - self.origin);
			newmis.angles_x *= -1;
		}
		else
			newmis.angles = self.angles;
	}
	
	makevectors (newmis.angles);
	newmis.classname = "spellfire";
	newmis.hull = HULL_POINT;
	newmis.Lspell = spell;
	newmis.Lsupport = support;
	newmis.LfingerC = scharge;
	newmis.spelltop = self.spelltop;
	newmis.handy = 2;
	newmis.owner = self;
	newmis.solid = SOLID_NOT;
	
	

	if (self.handy == 2)
		traceline ((self.origin + self.proj_ofs), ((self.origin + self.proj_ofs)+(v_forward * 55)+(v_right * -15)) , FALSE , self.owner);
	else
		traceline ((self.origin + self.proj_ofs), ((self.origin + self.proj_ofs)+(v_forward * 55)+(v_right * 15)) , FALSE , self.owner);

	setorigin (newmis, trace_endpos);
	
	setmodel(newmis, "models/dwarf.mdl");
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.abslight = 1.5;
	
	if (support & SUPPORT_TRAP)
	{
		newmis.Lsupport ^= SUPPORT_TRAP;
		setmodel(newmis, "models/dwarf.mdl");
		newmis.classname = "spelltrap";
		
		if ((spell_type->spell == SPELL_TYPE_PROJ) || (spell_type->spell == SPELL_TYPE_PROJ_CUSTOM) || (spell_type->spell == SPELL_TYPE_TRACE))
		{
			setsize ( newmis, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
			newmis.solid = SOLID_PHASE;
			newmis.velocity = (v_forward * 200);
			newmis.touch = spelltrap_think;
		}
		else
		{
			newmis.solid = SOLID_NOT;
			newmis.think = spelltrap_think;
			AdvanceThinkTime(newmis, HX_FRAME_TIME);
		}
		
		newmis.trap_count = newmis.owner.trap_count;
		newmis.owner.trap_count = fmod((newmis.owner.trap_count+1), 4);
	}
	else
	{
		AdvanceThinkTime(newmis, HX_FRAME_TIME);
		newmis.think = spellfire_init;
	}
};