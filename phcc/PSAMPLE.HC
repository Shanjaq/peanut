float boot;

void() sampler_think = {
local string cheesie;

cheesie = ftos(boot);

sprint (self.owner, cheesie);
sprint (self.owner, "color\n");


if (boot>255) {
boot = 1;
}
if (boot<1) {
boot = 255;
}

	centerprint (self.owner, getstring(boot));
   particle2 ( self.origin, '-30.00000 -30.00000 50.00000', '30.00000 30.00000 100.00000', boot, 0, 80);
//self.colormap = boot;
self.think = sampler_think;
self.nextthink = (time + 2.0);
};

void() particle_sampler = {
local entity sampler;
sampler = spawn();

sampler.solid = SOLID_BBOX;
sampler.health = 50;
sampler.takedamage = DAMAGE_YES;
sampler.th_die = SUB_Remove;
sampler.owner = self;
setsize (sampler, '-5 -5 -5', '5 5 5'); 
setorigin (sampler, self.origin);
setmodel (sampler, "models/dwarf.mdl");
sampler.think = sampler_think;
sampler.nextthink = (time + 0.02);
};
