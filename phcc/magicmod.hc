
float(entity forwhom, float themod) spellmod_give =
{
	local entity tracker, found;
	if (forwhom.predebt == 1)
	{
		tracker = world;
		found = find ( world, classname, "item_tracker");
		while (found)
		{
			if (found.owner == forwhom)
				tracker = found;
				
			found = find ( found, classname, "item_tracker");
		}
		
		if (tracker == world)
		{
			tracker = spawn();
			tracker.owner = forwhom;
			tracker.classname = "item_tracker";
			tracker.inv_spellmods = forwhom.inv_spellmods;
		}
		
		if ((tracker.inv_spellmods & (fexp(themod, 2) * 3)) < (fexp(themod, 2) * 3))
		{
			tracker.inv_spellmods += fexp(themod, 2);
			tracker.debt += 1500;
			tracker.owner.debt += 1500;
			return 0;
		}
		else
			return 1;
		
	}
	else
	{
		if ((forwhom.inv_spellmods & (fexp(themod, 2) * 3)) < (fexp(themod, 2) * 3))
		{
			forwhom.inv_spellmods += fexp(themod, 2);
			return 0;
		}
		else
			return 1;
	}
};

void ()spellmod_install = {
	local float thespell;
	local float support;
	local float themod;
	
	makevectors (self.v_angle);
	traceline ((self.origin + self.proj_ofs), ((self.origin + self.proj_ofs)+(v_forward * 55)) , FALSE, self);
		//sprint(self, vtos(trace_endpos));
		//dprint(trace_ent.classname);
	if (trace_ent.classname == "magic_workbench")
	{
		themod = fexp(2, trace_ent.menuitem);
		
		if ((self.handy == 0) || (self.handy == 2)) {
			thespell = self.Lspell;
			support = self.Lsupport;
		}
		
		if ((self.handy == 1) || (self.handy == 3)) {
			thespell = self.Rspell;
			support = self.Rsupport;
		}
		
		if ( ((thespell) && (spell_support->thespell) & themod) && (!(support & themod)) && ((self.inv_spellmods & (fexp(themod, 2) * 3)) > 0) )
		{
			if ((self.handy == 0) || (self.handy == 2)) {
				if (self.Lfinger == 0) {
					self.Lfinger1Support |= themod;
				}
				if (self.Lfinger == 1) {
					self.Lfinger2Support |= themod;
				}
				if (self.Lfinger == 2) {
					self.Lfinger3Support |= themod;
				}
				if (self.Lfinger == 3) {
					self.Lfinger4Support |= themod;
				}
				if (self.Lfinger == 4) {
					self.Lfinger5Support |= themod;
				}
				self.handy = 0;
			}
			
			if ((self.handy == 1) || (self.handy == 3)) {
				if (self.Rfinger == 0) {
					self.Rfinger1Support |= themod;
				}
				if (self.Rfinger == 1) {
					self.Rfinger2Support |= themod;
				}
				if (self.Rfinger == 2) {
					self.Rfinger3Support |= themod;
				}
				if (self.Rfinger == 3) {
					self.Rfinger4Support |= themod;
				}
				if (self.Rfinger == 4) {
					self.Rfinger5Support |= themod;
				}
				self.handy = 1;
			}
			
			//self.inv_spellmods ^= themod;
			self.inv_spellmods -= fexp(themod, 2);
			spells_compute(self);
			activator = trace_ent;
			trace_ent.lip = 1;
		}
	}
};

void() spellmod_marker_think =
{
	if (time < self.owner.splash_time)
	{
		if (self.skin != self.owner.menuitem)
			self.skin = self.owner.menuitem;
		
		if (self.owner.auraV && (self.drawflags & DRF_TRANSLUCENT))
		{
			self.drawflags ^= DRF_TRANSLUCENT;
		}
		else if (!self.owner.auraV && !(self.drawflags & DRF_TRANSLUCENT))
		{
			self.drawflags |= DRF_TRANSLUCENT;
		}
		
		AdvanceThinkTime(self, 0.1);
		self.think = spellmod_marker_think;
	}
	else
	{
		self.owner.goalentity = world;
		AdvanceThinkTime(self, HX_FRAME_TIME);
		self.think = SUB_Remove;
	}

};


void() spellmod_marker =
{
	newmis = spawn();
	self.goalentity = newmis;
	setorigin(newmis, self.origin);
	newmis.owner = self;
	newmis.hull = HULL_POINT;
	newmis.solid = SOLID_NOT;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.drawflags |= MLS_ABSLIGHT;
	newmis.abslight = 0.5;
	newmis.classname = "the_spellmod";
	setmodel(newmis, "models/i_spellmod.mdl");
	newmis.avelocity_y = 96;
	newmis.menuitem = 0;
	
	AdvanceThinkTime(newmis, HX_FRAME_TIME);
	newmis.think = spellmod_marker_think;
};

void() magic_workbench_think = {
	local entity found, nearest;
	local float dist1;
	local float dist2;
	local float radius;
	local float tmp;

	radius = 172.00000;
	
	if (self.lip == 1)
	{
		SUB_UseTargets ( );
		sound ( self, CHAN_AUTO, "empower.wav", 1.00000, ATTN_NORM);
		self.lip = 0;
	}

	found = nextent (world);
	nearest = found;
	while (found)
	{
		if (found.classname == "player")
		{
			dist1 = vlen(found.origin - self.origin);
			dist2 = vlen(nearest.origin - self.origin);
			
			if (dist1 < dist2)
			{
				nearest = found;
			}
			
			if ( (vlen(found.origin - self.origin) < radius) )
			{
				found.modding = 1;
				self.splash_time = (time + self.lifetime);
				if (self.goalentity == world)
					spellmod_marker();
				
				if ( (vlen(found.origin - self.origin) < (radius / 2)) && (self.auraV) )
				{
					centerprint(found, "Cast a spell on the sphere to install this modifier.");
				}
				
			}
			else
			{
				found.modding = 0;
			}
/*
			else if ((vlen(found.origin - self.origin) < radius) )
			{
				self.splash_time = (time + self.lifetime);
				if (self.goalentity == world)
					spellmod_marker();
				
				if (time >= self.search_time)
				{
					if (self.menuitem < 4)
						self.menuitem += 1;
					else
						self.menuitem = 0;
					
					self.search_time = (time + 0.75000);
				}
			}
			else
			{
				found.modding = 0;
			}
*/
		}
		found = find ( found, classname, "player");
	}

	if (nearest.classname == "player")
	{
		//tmp = fexp(2, self.menuitem);
		//tmp = fexp(tmp, 2);
		//self.auraV = ((nearest.inv_spellmods & (tmp * 3)) > 0.00000);
		self.auraV = ((nearest.inv_spellmods & (fexp(fexp(2, self.menuitem), 2) * 3)) > 0.00000);
	}
	
	AdvanceThinkTime(self, 0.12500);
	self.think = magic_workbench_think;
};

void() magic_workbench_use =
{
	if (self.menuitem < 4)
		self.menuitem += 1;
	else
		self.menuitem = 0;
	
	particle2 ( self.origin - '0 0 24', '-30.00000 -30.00000 24.00000', '30.00000 30.00000 64.00000', 255.00000, PARTICLETYPE_C_EXPLODE, 80.00000);
};


void() magic_workbench = {
	newmis = spawn();
	setorigin (newmis, self.origin);

	newmis.classname = "magic_workbench";
	setsize ( newmis, '-2.00000 -2.00000 -2.00000', '2.00000 2.00000 2.00000');
	newmis.hull = HULL_POINT;
	newmis.solid = SOLID_BBOX;
	newmis.movetype = MOVETYPE_NOCLIP;
	setmodel(newmis, "models/dwarf.mdl");
	newmis.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
	newmis.abslight = 1.5;
	newmis.targetname = self.targetname;
	newmis.target = self.target;
	newmis.lifetime = 3.00000;
	newmis.use = magic_workbench_use;
	newmis.think = magic_workbench_think;
	AdvanceThinkTime(newmis, 0.02);
};

void() spellmod = {
	if ((self.handy == 2) || (self.handy == 3)) {
		if (self.handy == 2) {
			if (self.Lfinger == 0) {
				self.Lfinger1Support = SUPPORT_CASTSPEED;
			}
			if (self.Lfinger == 1) {
				self.Lfinger2Support = SUPPORT_CASTSPEED;
			}
			if (self.Lfinger == 2) {
				self.Lfinger3Support = SUPPORT_CASTSPEED;
			}
			if (self.Lfinger == 3) {
				self.Lfinger4Support = SUPPORT_CASTSPEED;
			}
			if (self.Lfinger == 4) {
				self.Lfinger5Support = SUPPORT_CASTSPEED;
			}
		}
		if (self.handy == 3) {
			if (self.Rfinger == 0) {
				self.Rfinger1Support = SUPPORT_MULTI;
			}
			if (self.Rfinger == 1) {
				self.Rfinger2Support = SUPPORT_MULTI;
			}
			if (self.Rfinger == 2) {
				self.Rfinger3Support = SUPPORT_MULTI;
			}
			if (self.Rfinger == 3) {
				self.Rfinger4Support = SUPPORT_MULTI;
			}
			if (self.Rfinger == 4) {
				self.Rfinger5Support = SUPPORT_MULTI;
			}
		}
	}
};