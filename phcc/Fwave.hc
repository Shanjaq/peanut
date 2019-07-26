// BAER all new code!
entity ()firefizz_smoke_generator =  {
	local entity gen;

	gen = spawn();
	setmodel ( gen, "models/null.spr");
	setorigin(gen, self.origin);
	gen.classname = "fizz_generator";
	gen.solid = SOLID_NOT;
	gen.movetype = MOVETYPE_NONE;
	setsize ( gen, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	gen.th_die = SUB_Remove;
	gen.nextthink = (time + HX_FRAME_TIME);
	gen.think = smoke_generator_run;
	gen.dest = self.origin;
	gen.lifespan = 1;
	gen.wait = HX_FRAME_TIME * 4;
	gen.lifetime = time + random(1,5);
	return gen;
};


void() FireWaveThink =
{
	if (self.cnt > 100) {
		remove(self);
	} else {
		self.cnt += 1;
	}
	if (random() > 0.8)
	particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', 140.00000, 16, 10.00000);

	//	CreateWhiteSmoke ( self.origin, '0.00000 0.00000 2.00000', (HX_FRAME_TIME * 2.00000));
	if (pointcontents(self.origin) == CONTENT_WATER || pointcontents(self.origin) == CONTENT_SLIME)
	{
		sound (self, CHAN_WEAPON, "misc/fout.wav", 1, ATTN_NORM); 
		firefizz_smoke_generator();
		remove(self);
	} 
	self.nextthink = time + HX_FRAME_TIME;
	self.think = FireWaveThink;
};
// BAER end of new code

void() firewave_touch =
{
	if ((other != world) && (other.takedamage == DAMAGE_YES))
		apply_status(other, STATUS_BURNING, self.spelldamage, 8);
	
	remove(self);
};

void() AxeSpikes = 
{ 


	local string cow;
	local float num_shots; 

	//random amount of shots 
	//mutiplying by 50 and dividing by five will result in more 
	//mid-range shots. Like the dice in D&D 
	num_shots = random(3, 5); 
	self.magic_finished = (time + 1);
	makevectors (self.angles);

	//local vector org, vec; 
	//org = self.origin + v_forward * 20; 
	//start just in front // set missile speed 
	//vec = normalize (v_forward); 
	//vec = v_forward; 
	//vec_z = 0 - vec_z + (random() - 0.5)*0.1;
	sound (self, CHAN_WEAPON, "raven/littorch.wav", 1, ATTN_NORM); 
	
	do { 
		launch_spike (self.origin, v_forward); //really is just a spike with a different model 
		
		newmis.spelldamage = self.spelldamage;
		newmis.spellradiusmod = self.spellradiusmod;
		newmis.classname = "knightspike"; 
		newmis.owner = self.owner;
		setmodel (newmis, "models/flame1.mdl"); 
		newmis.drawflags = MLS_ABSLIGHT;
		newmis.abslight = 1.00000;
		newmis.effects = newmis.effects | EF_DIMLIGHT; 
		setsize (newmis, VEC_ORIGIN, VEC_ORIGIN); 
		//newmis.touch = blaze_touch;
		newmis.touch = firewave_touch;

		newmis.velocity = v_forward * 300; //speed up 
		newmis.velocity_x = newmis.velocity_x + ((random() - 0.5) * 128); //random spread 
		newmis.velocity_y = newmis.velocity_y + ((random() - 0.5) * 128); //random spread 

		// BAER adding this
		newmis.think = FireWaveThink;
		newmis.nextthink = time + 0.2;
		newmis.angles = vectoangles(newmis.velocity);
		newmis.angles_x = 90;
		// BAER end of new code

		num_shots = num_shots - 1; 
		//hmm...
	}
	while (num_shots > 0);

};
