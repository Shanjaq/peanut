void() DropTeleport; //<---------Add this 
void() Teleport_to_drop; //<---------Add this 
void (vector org) spawn_tfog; //<---------Add this 
void (vector org, entity death_owner) spawn_tdeath; //<---------Add this 


/*
========== 
Self Teleporter 
========== 
*/ 

void() DropTeleport = //Will drop location for The destination 
{ 
	if(!self.owner.tele_dropped) 
	{ 
		self.owner.teledrop_dest = spawn(); //Will create a temp entity for the location of the Teleporter 
	} 
	self.owner.teledrop_dest.origin = self.owner.origin; //records the location 
	self.owner.teledrop_dest.mangle = self.owner.angles; 
	self.owner.tele_dropped = 1; 
	self.owner.magic_finished = (time + 0.7);
	setmodel(self.owner.teledrop_dest, "models/dwarf.mdl");
	self.owner.teledrop_dest.drawflags = MLS_ABSLIGHT;
	self.owner.teledrop_dest.abslight = 1.00000;
	self.owner.teledrop_dest.effects = self.teledrop_dest.effects | EF_DIMLIGHT; 

	sprint(self.owner, "Teleport destination dropped.");
}; 
void() Teleport_to_drop = //This will Teleport you to the Teleport Location temp entity that was recorded above 
{ 
	local vector org; 

	if(!self.owner.tele_dropped) 
	{ 
		sprint(self.owner, "No destination dropped."); 
		return; 
	} 
	if(self.owner.health <= 0) 
	{ 
		return; 
	}
	spawn_tfog (self.owner.teledrop_dest.origin); 
	makevectors (self.owner.teledrop_dest.mangle); 
	org = self.owner.teledrop_dest.origin;
	spawn_tfog (org); 
	spawn_tdeath (org,self); 
	setorigin (self.owner,self.owner.teledrop_dest.origin); 
	self.owner.angles = self.owner.teledrop_dest.mangle; 
	self.owner.fixangle = 1; 
	self.owner.velocity = v_forward * 100; 
	self.owner.teleport_time = time + 0.5; // Shorter teleport recovery time 
	self.owner.flags = self.owner.flags - self.owner.flags & FL_ONGROUND; 
	self.owner.tele_dropped = 0; 
	AdvanceThinkTime(self.owner.teledrop_dest,0.01);
	self.owner.teledrop_dest.think = SUB_Remove;
}; 


void() teleport_spell =
{
	if (self.owner.tele_dropped)
		Teleport_to_drop();
	else
		DropTeleport();
};