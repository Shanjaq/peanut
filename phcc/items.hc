void  ()W_SetCurrentAmmo;
void  ()puzzle_touch;

void  ()SUB_regen =  {
	self.model = self.mdl;
	self.solid = SOLID_TRIGGER;
	sound ( self, CHAN_VOICE, "items/itmspawn.wav", 1.00000, ATTN_NORM);
	setorigin ( self, self.origin);
};


void  ()ItemHitFloorWait =  {
	if ( ((self.flags & FL_ONGROUND) || ((pointcontents ( (self.origin - '0.00000 0.00000 38.00000')) == CONTENT_SOLID) && (self.velocity_z <= 0.00000))) ) {

		traceline ( self.origin, (self.origin - '0.00000 0.00000 38.00000'), TRUE, self);
		self.flags |= FL_ITEM;
		self.velocity = '0.00000 0.00000 0.00000';
		self.solid = SOLID_TRIGGER;
		if ( (self.touch == puzzle_touch) ) {

			setorigin ( self, (trace_endpos + '0.00000 0.00000 28.00000'));
			setsize ( self, '-8.00000 -8.00000 -28.00000', '8.00000 8.00000 8.00000');
		} else {

			setorigin ( self, (trace_endpos + '0.00000 0.00000 38.00000'));
			setsize ( self, '-8.00000 -8.00000 -38.00000', '8.00000 8.00000 24.00000');

		}
		self.nextthink = -1.00000;
		return ;
	} else {

		AdvanceThinkTime(self,0.05000);

	}
};


void  ()PlaceItem =  {
	local float oldz = 0.00000;
	local float oldHull = 0.00000;
	self.mdl = self.model;
	self.flags |= FL_ITEM;
	self.solid = SOLID_TRIGGER;
	self.movetype = MOVETYPE_TOSS;
	setsize ( self, self.mins, self.maxs);
	self.velocity = '0.00000 0.00000 0.00000';
	self.origin_z = (self.origin_z + 6.00000);
	oldz = self.origin_z;
	if ( !(self.spawnflags & FLOATING) ) {

		oldHull = self.hull;
		self.hull = HULL_POINT;
		if ( !droptofloor ( ) ) {

			dprint ( "Item :");
			dprint ( self.classname);
			dprint ( " fell out of level at ");
			dprint ( vtos ( self.origin));
			dprint ( "\n");
			remove ( self);
			return ;

		}
		self.hull = oldHull;
		if ( (self.touch == puzzle_touch) ) {

			setorigin ( self, (self.origin + '0.00000 0.00000 28.00000'));
			setsize ( self, '-8.00000 -8.00000 -28.00000', '8.00000 8.00000 8.00000');
		} else {

			setorigin ( self, (self.origin + '0.00000 0.00000 38.00000'));
			setsize ( self, '-8.00000 -8.00000 -38.00000', '8.00000 8.00000 24.00000');

		}
		
	} else {

		self.movetype = MOVETYPE_NONE;

	}
};


void  ()StartItem =  {
	if ( self.owner ) {

		self.movetype = MOVETYPE_PUSHPULL;
		if ( (self.touch == puzzle_touch) ) {

			setsize ( self, '-8.00000 -8.00000 -28.00000', '8.00000 8.00000 8.00000');
		} else {

			setsize ( self, '-16.00000 -16.00000 -38.00000', '16.00000 16.00000 24.00000');

		}
		if ( (((self.think != SUB_Remove) && (self.owner.classname == "player")) && (self.model != "models/bag.mdl")) ) {

			self.think = SUB_Remove;
			AdvanceThinkTime(self,30.00000);

		}
	} else {

		self.nextthink = (time + 0.20000);
		self.think = PlaceItem;

	}
};

float MAX_INV   =  25.00000;

void  (entity AddTo,entity AddFrom)max_ammo2 =  {
	if ( ((AddTo.cnt_torch + AddFrom.cnt_torch) > MAX_INV) ) {

		AddFrom.cnt_torch = (MAX_INV - AddTo.cnt_torch);

	}
	if ( ((AddTo.cnt_h_boost + AddFrom.cnt_h_boost) > MAX_INV) ) {

		AddFrom.cnt_h_boost = (MAX_INV - AddTo.cnt_h_boost);

	}
	if ( ((AddTo.cnt_sh_boost + AddFrom.cnt_sh_boost) > MAX_INV) ) {

		AddFrom.cnt_sh_boost = (MAX_INV - AddTo.cnt_sh_boost);

	}
	if ( ((AddTo.cnt_mana_boost + AddFrom.cnt_mana_boost) > MAX_INV) ) {

		AddFrom.cnt_mana_boost = (MAX_INV - AddTo.cnt_mana_boost);

	}
	if ( ((AddTo.cnt_teleport + AddFrom.cnt_teleport) > MAX_INV) ) {

		AddFrom.cnt_teleport = (MAX_INV - AddTo.cnt_teleport);

	}
	if ( ((AddTo.cnt_tome + AddFrom.cnt_tome) > MAX_INV) ) {

		AddFrom.cnt_tome = (MAX_INV - AddTo.cnt_tome);

	}
	if ( ((AddTo.cnt_summon + AddFrom.cnt_summon) > MAX_INV) ) {

		AddFrom.cnt_summon = (MAX_INV - AddTo.cnt_summon);

	}
	if ( ((AddTo.cnt_invisibility + AddFrom.cnt_invisibility) > MAX_INV) ) {

		AddFrom.cnt_invisibility = (MAX_INV - AddTo.cnt_invisibility);

	}
	if ( ((AddTo.cnt_glyph + AddFrom.cnt_glyph) > MAX_INV) ) {

		AddFrom.cnt_glyph = (MAX_INV - AddTo.cnt_glyph);

	}
	if ( ((AddTo.cnt_haste + AddFrom.cnt_haste) > MAX_INV) ) {

		AddFrom.cnt_haste = (MAX_INV - AddTo.cnt_haste);

	}
	if ( ((AddTo.cnt_blast + AddFrom.cnt_blast) > MAX_INV) ) {

		AddFrom.cnt_blast = (MAX_INV - AddTo.cnt_blast);

	}
	if ( ((AddTo.cnt_polymorph + AddFrom.cnt_polymorph) > MAX_INV) ) {

		AddFrom.cnt_polymorph = (MAX_INV - AddTo.cnt_polymorph);

	}
	if ( ((AddTo.cnt_flight + AddFrom.cnt_flight) > MAX_INV) ) {

		AddFrom.cnt_flight = (MAX_INV - AddTo.cnt_flight);

	}
	if ( ((AddTo.cnt_cubeofforce + AddFrom.cnt_cubeofforce) > MAX_INV) ) {

		AddFrom.cnt_cubeofforce = (MAX_INV - AddTo.cnt_cubeofforce);

	}
	if ( ((AddTo.cnt_invincibility + AddFrom.cnt_invincibility) > MAX_INV) ) {

		AddFrom.cnt_invincibility = (MAX_INV - AddTo.cnt_invincibility);

	}
	if ( ((AddTo.bluemana + AddFrom.bluemana) > AddTo.max_mana) ) {

		AddFrom.bluemana = (AddTo.max_mana - AddTo.bluemana);

	}
	if ( ((AddTo.greenmana + AddFrom.greenmana) > AddTo.max_mana) ) {

		AddFrom.greenmana = (AddTo.max_mana - AddTo.greenmana);

	}
};


void  ()max_playermana =  {
	if ( (other.bluemana > other.max_mana) ) {

		other.bluemana = other.max_mana;

	}
	if ( (other.greenmana > other.max_mana) ) {

		other.greenmana = other.max_mana;

	}
	if ( (other.elemana > other.max_mana) ) {

		other.elemana = other.max_mana;

	}
};


float  (float w)RankForWeapon =  {
	if ( (w & IT_WEAPON4) ) {

		return ( 1.00000 );

	}
	if ( (w == IT_WEAPON3) ) {

		return ( 2.00000 );

	}
	if ( (w == IT_WEAPON2) ) {

		return ( 3.00000 );

	}
	if ( (w == IT_WEAPON1) ) {

		return ( 4.00000 );

	}
	return ( 4.00000 );
};


void  (float old,float new)NewBestWeapon =  {
	local float or = 0.00000;
	local float nr = 0.00000;
	or = RankForWeapon ( self.weapon);
	nr = RankForWeapon ( new);
	if ( (nr < or) ) {

		if ( (new & IT_WEAPON4) ) {

			self.weapon = IT_WEAPON4;
		} else {

			self.weapon = new;

		}

	}
};

void  ()W_BestWeapon;

void  ()weapon_touch =  {
	local float new = 0.00000;
	local float old = 0.00000;
	local entity stemp;
	local float leave = 0.00000;
	local float hadweap = 0.00000;
	if ( (!(other.flags & FL_CLIENT) || (other.model == "models/sheep.mdl")) ) {

		return ;

	}
	if ( ((deathmatch == 2.00000) || coop) ) {

		if ( (other.items & self.items) ) {

			return ;
		} else {

			leave = 1.00000;

		}
	} else {

		leave = 0.00000;

	}
	other.oldweapon = other.weapon;
	new = self.items;
	if ( (self.classname == "wp_weapon2") ) {

		if ( (other.playerclass == CLASS_PALADIN) ) {

			self.netname = STR_VORPAL;
		} else {

			if ( (other.playerclass == CLASS_CRUSADER) ) {

				self.netname = STR_ICESTAFF;
			} else {

				if ( (other.playerclass == CLASS_NECROMANCER) ) {

					self.netname = STR_MAGICMISSILE;
				} else {

					if ( (other.playerclass == CLASS_ASSASSIN) ) {

						self.netname = STR_CROSSBOW;
						other.arrows += 30.00000;
					}

				}

			}

		}
		other.bluemana += 25.00000;
	} else {

		if ( (self.classname == "wp_weapon3") ) {

			if ( (other.playerclass == CLASS_PALADIN) ) {

				self.netname = STR_AXE;
			} else {

				if ( (other.playerclass == CLASS_CRUSADER) ) {

					self.netname = STR_METEORSTAFF;
				} else {

					if ( (other.playerclass == CLASS_NECROMANCER) ) {

						self.netname = STR_BONESHARD;
					} else {

						if ( (other.playerclass == CLASS_ASSASSIN) ) {

							self.netname = STR_GRENADES;

						}

					}

				}

			}
			other.greenmana += 25.00000;
		} else {

			if ( (self.classname == "wp_weapon4_head") ) {

				if ( (other.playerclass == CLASS_PALADIN) ) {

					self.netname = STR_PURIFIER1;
				} else {

					if ( (other.playerclass == CLASS_CRUSADER) ) {

						self.netname = STR_SUN1;
					} else {

						if ( (other.playerclass == CLASS_NECROMANCER) ) {

							self.netname = STR_RAVENSTAFF1;
						} else {

							if ( (other.playerclass == CLASS_ASSASSIN) ) {

								self.netname = STR_SET1;

							}

						}

					}

				}
				other.bluemana += 25.00000;
				other.greenmana += 25.00000;
				if ( (other.items & IT_WEAPON4_2) ) {

					new += IT_WEAPON4;

				}
			} else {

				if ( (self.classname == "wp_weapon4_staff") ) {

					if ( (other.playerclass == CLASS_PALADIN) ) {

						self.netname = STR_PURIFIER2;
					} else {

						if ( (other.playerclass == CLASS_CRUSADER) ) {

							self.netname = STR_SUN2;
						} else {

							if ( (other.playerclass == CLASS_NECROMANCER) ) {

								self.netname = STR_RAVENSTAFF2;
							} else {

								if ( (other.playerclass == CLASS_ASSASSIN) ) {

									self.netname = STR_SET2;

								}

							}

						}

					}
					other.bluemana += 25.00000;
					other.greenmana += 25.00000;
					if ( (other.items & IT_WEAPON4_1) ) {

						new += IT_WEAPON4;

					}
				} else {

					objerror ( "weapon_touch: unknown classname");

				}

			}

		}

	}
	sprint ( other, STR_YOUGOTTHE);
	sprint ( other, self.netname);
	sprint ( other, "\n");
	sound ( other, CHAN_ITEM, "weapons/weappkup.wav", 1.00000, ATTN_NORM);
	stuffcmd ( other, "bf\n");
	max_playermana ( );
	if ( (other.items & new) ) {

		hadweap = TRUE;

	}
	old = other.items;
	other.items = (other.items | new);
	stemp = self;
	self = other;
	max_playermana ( );
	if ( (self.attack_finished < time) ) {

		if ( (!deathmatch || !hadweap) ) {

			NewBestWeapon ( old, new);

		}
		W_SetCurrentWeapon ( );

	}
	self = stemp;
	if ( leave ) {

		return ;

	}
	self.model = string_null;
	self.solid = SOLID_NOT;
	if ( (deathmatch == 1.00000) ) {

		self.nextthink = (time + 30.00000);

	}
	self.think = SUB_regen;
	activator = other;
	SUB_UseTargets ( );
};


void  ()ihealth_touch =  {
	if ( (((other.classname != "player") || (other.health < 1.00000)) || (other.model == "models/sheep.mdl")) ) {

		return ;

	}
	if (other.predebt == 1) {
		other.debt = (other.debt + 10);
	}
	if ( (other.health < (other.max_health * 2)) ) {

		sound ( other, CHAN_VOICE, "items/itempkup.wav", 1.00000, ATTN_NORM);
		other.healthcount += 10.00000;
		other.poisoncount = 0;

		//      if ( (other.health > (other.max_health * 2)) ) {

		//         other.health = (other.max_health * 2);

		//      }
		self.model = string_null;
		self.solid = SOLID_NOT;
		if ( (deathmatch == 1.00000) ) {

			self.nextthink = (time + RESPAWN_TIME);

		}
		self.think = SUB_regen;
		sprint ( other, STR_YOUHAVETHE);
		sprint ( other, self.netname);
		sprint ( other, "\n");
		activator = other;
		SUB_UseTargets ( );

	}
};


void  ()spawn_instant_health =  {
	self.touch = ihealth_touch;
	setmodel ( self, "models/i_hboost.mdl");
	setsize ( self, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	self.hull = HULL_POINT;
	self.classname = "item_health";
	self.netname = STR_INSTANTHEALTH;
	StartItem ( );
};


void  ()item_health =  {
	spawn_instant_health ( );
};


void  ()mana_touch =  {
	if ( (((other.classname != "player") || (other.health < 1.00000)) || (other.model == "models/sheep.mdl")) ) {

		return ;

	}
	if ( ((self.owner == other) && (self.artifact_ignore_owner_time > time)) ) {

		return ;

	}
	if ( (self.artifact_ignore_time > time) ) {

		return ;

	}
	if ( ((self.classname == "item_mana_green") && (other.greenmana >= other.max_mana)) ) {

		return ;

	}
	if ( ((self.classname == "item_mana_blue") && (other.bluemana >= other.max_mana)) ) {

		return ;

	}
	if ( ((self.classname == "item_mana_yellow") && (other.elemana >= other.max_mana)) ) {

		return ;

	}
	if ( ((self.classname == "item_mana_both") && ((other.bluemana >= other.max_mana) && (other.greenmana >= other.max_mana) && (other.elemana >= other.max_mana))) ) {

		return ;

	}
	sprint ( other, STR_YOUHAVETHE);
	sprint ( other, self.netname);
	sprint ( other, "\n");
	sound ( other, CHAN_VOICE, "items/itempkup.wav", 1.00000, ATTN_NORM);
	stuffcmd ( other, "bf\n");
	if ( (self.classname == "item_mana_green") ) {

		other.greenmana += self.count;
	} else {

		if ( (self.classname == "item_mana_blue") ) {

			other.bluemana += self.count;
		} else {
			if ( (self.classname == "item_mana_yellow") ) {
				
				other.elemana += self.count;
			} else {

				other.greenmana += self.count;
				other.bluemana += self.count;
				other.elemana += self.count;

			}
		}
	}
	max_playermana ( );
	self.model = string_null;
	self.solid = SOLID_NOT;
	if ( (deathmatch == 1.00000) ) {

		self.nextthink = (time + RESPAWN_TIME);

	}
	self.think = SUB_regen;
	activator = other;
	SUB_UseTargets ( );
};


void  (float amount)spawn_item_mana_yellow =  {
	setmodel ( self, "models/i_ymana.mdl");
	self.touch = mana_touch;
	setsize ( self, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	self.hull = HULL_POINT;
	self.classname = "item_mana_yellow";
	self.netname = STR_YELLOWMANA;
	self.count = amount;
	
	StartItem ( );
};


void  ()item_mana_yellow =  {
	if ( (self.spawnflags & 2.00000) ) {

		self.drawflags |= (SCALE_ORIGIN_CENTER | MLS_POWERMODE);
		self.scale = 2.00000;
		spawn_item_mana_yellow ( 30.00000);
	} else {

		spawn_item_mana_yellow ( 15.00000);

	}
};

void  (float amount)spawn_item_mana_green =  {
	if (random() < 0.45000)
	{
		setmodel ( self, "models/i_gmana.mdl");
		self.classname = "item_mana_green";
		self.netname = STR_GREENMANA;
	}
	else
	{
		setmodel ( self, "models/i_ymana.mdl");
		self.classname = "item_mana_yellow";
		self.netname = STR_YELLOWMANA;
	}
	
	self.touch = mana_touch;
	setsize ( self, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	self.hull = HULL_POINT;
	self.count = amount;
	StartItem ( );
};


void  ()item_mana_green =  {
	if ( (self.spawnflags & 2.00000) ) {

		self.drawflags |= (SCALE_ORIGIN_CENTER | MLS_POWERMODE);
		self.scale = 2.00000;
		spawn_item_mana_green ( 30.00000);
	} else {

		spawn_item_mana_green ( 15.00000);

	}
};


void  (float amount)spawn_item_mana_blue =  {
	if (random() < 0.45000)
	{
		setmodel ( self, "models/i_bmana.mdl");
		self.classname = "item_mana_blue";
		self.netname = STR_BLUEMANA;
	}
	else
	{
		setmodel ( self, "models/i_ymana.mdl");
		self.classname = "item_mana_yellow";
		self.netname = STR_YELLOWMANA;
	}
	self.touch = mana_touch;
	setsize ( self, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	self.hull = HULL_POINT;
	self.count = amount;
	StartItem ( );
};


void  ()item_mana_blue =  {
	if ( (self.spawnflags & 2.00000) ) {

		self.drawflags |= (SCALE_ORIGIN_CENTER | MLS_POWERMODE);
		self.scale = 2.00000;
		spawn_item_mana_blue ( 30.00000);
	} else {

		spawn_item_mana_blue ( 15.00000);

	}
};


void  (float amount)spawn_item_mana_both =  {
	self.touch = mana_touch;
	setmodel ( self, "models/i_btmana.mdl");
	setsize ( self, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	self.hull = HULL_POINT;
	self.classname = "item_mana_both";
	self.count = amount;
	self.netname = STR_COMBINEDMANA;
	StartItem ( );
};


void  ()item_mana_both =  {
	if ( (self.spawnflags & 2.00000) ) {

		self.drawflags |= (SCALE_ORIGIN_CENTER | MLS_POWERMODE);
		self.scale = 2.00000;
		spawn_item_mana_both ( 30.00000);
	} else {

		spawn_item_mana_both ( 15.00000);

	}
};


void  ()armor_touch =  {
	if ( (((other.classname != "player") || (other.health <= 0.00000)) || (other.model == "models/sheep.mdl")) ) {

		return ;

	}
	if ( (self.classname == "item_armor_amulet") ) {
		if (other.predebt == 1) {
			other.debt = (other.debt + 20);
		}

		other.armor_amulet = 20.00000;
	} else {

		if ( (self.classname == "item_armor_bracer") ) {
			if (other.predebt == 1) {
				other.debt = (other.debt + 25);
			}


			other.armor_bracer = 20.00000;
		} else {

			if ( (self.classname == "item_armor_breastplate") ) {
				if (other.predebt == 1) {
					other.debt = (other.debt + 40);
				}

				other.armor_breastplate = 20.00000;
			} else {

				if ( (self.classname == "item_armor_helmet") ) {
					if (other.predebt == 1) {
						other.debt = (other.debt + 30);
					}

					other.armor_helmet = 20.00000;

				}

			}

		}

	}
	self.solid = SOLID_NOT;
	self.model = string_null;
	if ( (deathmatch == 1.00000) ) {

		self.nextthink = (time + RESPAWN_TIME);

	}
	self.think = SUB_regen;
	sprint ( other, STR_YOUHAVETHE);
	sprint ( other, self.netname);
	sprint ( other, "\n");
	sound ( other, CHAN_ITEM, "items/armrpkup.wav", 1.00000, ATTN_NORM);
	stuffcmd ( other, "bf\n");
	activator = other;
	SUB_UseTargets ( );
};


void  ()spawn_item_armor_helmet =  {
	setmodel ( self, "models/i_helmet.mdl");
	setsize ( self, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	self.hull = HULL_POINT;
	self.touch = armor_touch;
	self.netname = STR_ARMORHELMET;
	StartItem ( );
};


void  ()item_armor_helmet =  {
	spawn_item_armor_helmet ( );
};


void  ()spawn_item_armor_breastplate =  {
	setmodel ( self, "models/i_bplate.mdl");
	setsize ( self, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	self.hull = HULL_POINT;
	self.touch = armor_touch;
	self.netname = STR_ARMORBREASTPLATE;
	StartItem ( );
};


void  ()item_armor_breastplate =  {
	spawn_item_armor_breastplate ( );
};


void  ()spawn_item_armor_bracer =  {
	setmodel ( self, "models/i_bracer.mdl");
	setsize ( self, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	self.hull = HULL_POINT;
	self.touch = armor_touch;
	self.netname = STR_ARMORBRACER;
	StartItem ( );
};


void  ()item_armor_bracer =  {
	spawn_item_armor_bracer ( );
};


void  ()spawn_item_armor_amulet =  {
	setmodel ( self, "models/i_amulet.mdl");
	setsize ( self, '0.00000 0.00000 0.00000', '0.00000 0.00000 0.00000');
	self.hull = HULL_POINT;
	self.touch = armor_touch;
	self.netname = STR_ARMORAMULET;
	StartItem ( );
};


void  ()item_armor_amulet =  {
	spawn_item_armor_amulet ( );
};

//void  (entity item,entity person,string which)GetPuzzle2;

void  ()BackpackTouch =  {
	local string s;
	local float old = 0.00000;
	local float new = 0.00000;
	local float ItemCount = 0.00000;
	if ( ((other.classname != "player") || (other.model == "models/sheep.mdl")) ) {

		return ;

	}
	if ( (other.health <= 0.00000) ) {

		return ;

	}
	if ( ((self.owner == other) && (self.artifact_ignore_owner_time > time)) ) {

		return ;

	}
	if ( (self.artifact_ignore_time > time) ) {

		return ;

	}
	ItemCount = 0.00000;
	sprint ( other, "You get ");
	max_ammo2 ( other, self);
	if ( (self.cnt_torch > 0.00000) ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.cnt_torch += self.cnt_torch;
		s = ftos ( self.cnt_torch);
		sprint ( other, s);
		sprint ( other, " ");
		sprint ( other, STR_TORCH);
		if ( (self.cnt_torch > 1.00000) ) {

			sprint ( other, "es");

		}

	}
	if ( (self.cnt_h_boost > 0.00000) ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.cnt_h_boost += self.cnt_h_boost;
		s = ftos ( self.cnt_h_boost);
		sprint ( other, s);
		sprint ( other, " ");
		sprint ( other, STR_HEALTHBOOST);
		if ( (self.cnt_h_boost > 1.00000) ) {

			sprint ( other, "s");

		}

	}
	if ( (self.cnt_sh_boost > 0.00000) ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.cnt_sh_boost += self.cnt_sh_boost;
		s = ftos ( self.cnt_sh_boost);
		sprint ( other, s);
		sprint ( other, " ");
		sprint ( other, STR_SUPERHEALTHBOOST);
		if ( (self.cnt_sh_boost > 1.00000) ) {

			sprint ( other, "s");

		}

	}
	if ( (self.cnt_mana_boost > 0.00000) ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.cnt_mana_boost += self.cnt_mana_boost;
		s = ftos ( self.cnt_mana_boost);
		sprint ( other, s);
		sprint ( other, " ");
		if ( (self.cnt_mana_boost == 1.00000) ) {

			sprint ( other, STR_MANABOOST);
		} else {

			sprint ( other, "Kraters of Might");

		}

	}
	if ( (self.cnt_teleport > 0.00000) ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.cnt_teleport += self.cnt_teleport;
		s = ftos ( self.cnt_teleport);
		sprint ( other, s);
		sprint ( other, " ");
		sprint ( other, STR_TELEPORT);
		if ( (self.cnt_teleport > 1.00000) ) {

			sprint ( other, "s");

		}

	}
	if ( (self.cnt_tome > 0.00000) ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.cnt_tome += self.cnt_tome;
		s = ftos ( self.cnt_tome);
		sprint ( other, s);
		sprint ( other, " ");
		if ( (self.cnt_tome == 1.00000) ) {

			sprint ( other, STR_TOME);
		} else {

			sprint ( other, "Tomes of Power");

		}

	}
	if ( (self.cnt_summon > 0.00000) ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.cnt_summon += self.cnt_summon;
		s = ftos ( self.cnt_summon);
		sprint ( other, s);
		sprint ( other, " ");
		if ( (self.cnt_summon == 1.00000) ) {

			sprint ( other, STR_SUMMON);
		} else {

			sprint ( other, "Stones of Summoning");

		}

	}
	if ( (self.cnt_flight > 0.00000) ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.cnt_flight += self.cnt_flight;
		s = ftos ( self.cnt_flight);
		sprint ( other, s);
		sprint ( other, " ");
		if ( (self.cnt_flight == 1.00000) ) {

			sprint ( other, STR_RINGFLIGHT);
		} else {

			sprint ( other, "Rings of Flight");

		}

	}
	if ( (self.cnt_glyph > 0.00000) ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.cnt_glyph += self.cnt_glyph;
		s = ftos ( self.cnt_glyph);
		sprint ( other, s);
		sprint ( other, " ");
		if ( (self.cnt_glyph == 1.00000) ) {

			sprint ( other, STR_GLYPH);
		} else {

			sprint ( other, "Glyphs Of The Ancients");

		}

	}
	if ( (self.cnt_haste > 0.00000) ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.cnt_haste += self.cnt_haste;
		s = ftos ( self.cnt_haste);
		sprint ( other, s);
		sprint ( other, " ");
		sprint ( other, STR_HASTE);

	}
	if ( (self.cnt_blast > 0.00000) ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.cnt_blast += self.cnt_blast;
		s = ftos ( self.cnt_blast);
		sprint ( other, s);
		sprint ( other, " ");
		if ( (self.cnt_blast == 1.00000) ) {

			sprint ( other, STR_BLAST);
		} else {

			sprint ( other, "Discs of Repulsion");

		}

	}
	if ( (self.cnt_polymorph > 0.00000) ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.cnt_polymorph += self.cnt_polymorph;
		s = ftos ( self.cnt_polymorph);
		sprint ( other, s);
		sprint ( other, " ");
		if ( (self.cnt_polymorph == 1.00000) ) {

			sprint ( other, STR_POLYMORPH);
		} else {

			sprint ( other, "Seals of the Ovinomancer");

		}

	}
	if ( (self.cnt_invisibility > 0.00000) ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.cnt_invisibility += self.cnt_invisibility;
		s = ftos ( self.cnt_invisibility);
		sprint ( other, s);
		sprint ( other, " ");
		sprint ( other, STR_INVISIBILITY);
		if ( (self.cnt_polymorph > 1.00000) ) {

			sprint ( other, "s");

		}

	}
	if ( (self.cnt_cubeofforce > 0.00000) ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.cnt_cubeofforce += self.cnt_cubeofforce;
		s = ftos ( self.cnt_cubeofforce);
		sprint ( other, s);
		sprint ( other, " ");
		sprint ( other, STR_CUBEOFFORCE);
		if ( (self.cnt_cubeofforce > 1.00000) ) {

			sprint ( other, "s");

		}

	}
	if ( (self.cnt_invincibility > 0.00000) ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.cnt_invincibility += self.cnt_invincibility;
		s = ftos ( self.cnt_invincibility);
		sprint ( other, s);
		sprint ( other, " ");
		if ( (self.cnt_invincibility == 1.00000) ) {

			sprint ( other, STR_INVINCIBILITY);
		} else {

			sprint ( other, "Icons of the Defender");

		}

	}
	if ( (self.bluemana > 0.00000) ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.bluemana += self.bluemana;
		s = ftos ( self.bluemana);
		sprint ( other, s);
		sprint ( other, " ");
		sprint ( other, STR_BLUEMANA);

	}
	if ( (self.greenmana > 0.00000) ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.greenmana += self.greenmana;
		s = ftos ( self.greenmana);
		sprint ( other, s);
		sprint ( other, " ");
		sprint ( other, STR_GREENMANA);

	}
	if ( self.armor_amulet ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.armor_amulet = self.armor_amulet;
		sprint ( other, s);
		sprint ( other, " ");
		sprint ( other, STR_ARMORAMULET);

	}
	if ( self.armor_bracer ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.armor_bracer = self.armor_bracer;
		sprint ( other, s);
		sprint ( other, " ");
		sprint ( other, STR_ARMORBRACER);

	}
	if ( self.armor_breastplate ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.armor_breastplate = self.armor_breastplate;
		sprint ( other, s);
		sprint ( other, " ");
		sprint ( other, STR_ARMORBREASTPLATE);

	}
	if ( self.armor_helmet ) {

		if ( ItemCount ) {

			sprint ( other, ", ");

		}
		ItemCount += 1.00000;
		other.armor_helmet = self.armor_helmet;
		sprint ( other, s);
		sprint ( other, " ");
		sprint ( other, STR_ARMORHELMET);

	}
	if ( !ItemCount ) {

		sprint ( other, "...Nothing!");

	}
	new = self.items;
	if ( !new ) {

		new = other.weapon;

	}
	old = other.items;
	other.items |= new;
	sprint ( other, "\n");
	sound ( other, CHAN_ITEM, "weapons/ammopkup.wav", 1.00000, ATTN_NORM);
	stuffcmd ( other, "bf\n");
	remove ( self);
	self = other;
	if ( !deathmatch ) {

		self.weapon = new;
	} else {

		NewBestWeapon ( old, new);

	}
	W_SetCurrentWeapon ( );
};


void() MonsterDropStuff =
{
	local float chance;
	local entity spellmod, old_self;

	if(!self.flags&FL_MONSTER)
		return;

	if (self.monsterclass < CLASS_GRUNT)
		return;

	// Grunts drop only instant items
	if (self.monsterclass == CLASS_GRUNT)
	{
		if (random() < 0.15) // %15 chance he'll drop something	
		{
			chance = random();
			if (chance < 0.25)
				self.greenmana = 10;
			else if (chance < 0.50)
				self.bluemana = 10;
			else if (chance < 0.75)
			{
				self.greenmana = 10;
				self.bluemana = 10;
			}
			else
			{
				self.spawn_health = 1;
			}
		}
	}
	// Henchmen drop instant items or lesser artifacts
	else if (self.monsterclass == CLASS_HENCHMAN)
	{
		if (random() < 0.15)
		{
			spellmod = spawn();
			setorigin(spellmod,self.origin);
			spellmod.origin = self.origin + '0 0 40';
			spellmod.flags |= FL_ITEM;
			spellmod.solid = SOLID_TRIGGER;
			spellmod.movetype = MOVETYPE_TOSS;
			spellmod.owner = self;
			spellmod.skin = floor(random() * 5.00000);
			spellmod.artifact_ignore_owner_time = time + 2;
			spellmod.artifact_ignore_time = time + 0.1;
			spellmod.velocity_z = 200;
			old_self = self;
			self = spellmod;

			spawn_artifact ((ARTIFACT_SPELL_ACCELERATOR + spellmod.skin), NO_RESPAWN);
			self = old_self;
		}
		
		if (random() < 0.15) // %15 chance he'll drop something	
		{
			chance = random();

			if (chance < 0.08)
				self.greenmana = 10;
			else if (chance < 0.16)
				self.bluemana = 10;
			else if (chance < 0.24)
			{
				self.greenmana = 10;
				self.bluemana = 10;
			}
			else if (chance < 0.32)
			{
				self.spawn_health = 1;
			}
			else if (chance < 0.40)
				self.cnt_torch = 1;
			else if (chance < 0.48)
				self.cnt_h_boost = 1;
			else if (chance < 0.56)
				self.cnt_mana_boost = 1;
			else if (chance < 0.64)
				self.cnt_teleport = 1;
			else if (chance < 0.72)
				self.cnt_tome = 1;
			else if (chance < 0.80)
				self.cnt_haste = 1;
			else
				self.cnt_blast = 1;
		}		
	}
	// Leaders drop armor or artifacts
	else if (self.monsterclass == CLASS_LEADER)
	{		
		if (random() < 0.35)
		{
			spellmod = spawn();
			setorigin(spellmod,self.origin);
			spellmod.origin = self.origin + '0 0 40';
			spellmod.flags |= FL_ITEM;
			spellmod.solid = SOLID_TRIGGER;
			spellmod.movetype = MOVETYPE_TOSS;
			spellmod.owner = self;
			spellmod.skin = floor(random() * 5.00000);
			spellmod.artifact_ignore_owner_time = time + 2;
			spellmod.artifact_ignore_time = time + 0.1;
			spellmod.velocity_z = 200;
			old_self = self;
			self = spellmod;

			spawn_artifact ((ARTIFACT_SPELL_ACCELERATOR + spellmod.skin), NO_RESPAWN);
			self = old_self;
		}
		
		if (random() < 0.15) // %15 chance he'll drop something	
		{
			chance = random();
		
			if (chance < 0.05)
				self.cnt_torch = 1;
			else if (chance < 0.10)
				self.cnt_h_boost = 1;
			else if (chance < 0.15)
				self.cnt_sh_boost = 1;
			else if (chance < 0.20)
				self.cnt_mana_boost = 1;
			else if (chance < 0.25)
				self.cnt_teleport = 1;
			else if (chance < 0.30)
				self.cnt_tome = 1;
			else if (chance < 0.35)
				self.cnt_summon = 1;
			else if (chance < 0.40)
				self.cnt_invisibility = 1;
			else if (chance < 0.45)
				self.cnt_glyph = 1;
			else if (chance < 0.50)
				self.cnt_haste = 1;
			else if (chance < 0.55)
				self.cnt_blast = 1;
			else if (chance < 0.60)
				self.cnt_polymorph = 1;
			else if (chance < 0.65)
				self.cnt_cubeofforce = 1;
			else if (chance < 0.70)
				self.cnt_invincibility = 1;
			else if (chance < 0.75)
				self.armor_amulet = 20;
			else if (chance < 0.80)
				self.armor_bracer = 20;
			else if (chance < 0.85)
				self.armor_breastplate = 20;
			else
				self.armor_helmet = 20;
		}
	}

	DropBackpack();
};


/*
===============
DropBackpack
===============
*/
void() DropBackpack =
{
	local entity item,old_self;
	local float total;

	item = spawn();

	if(self.playerclass==CLASS_NECROMANCER)
		self.cnt_glyph=rint(self.cnt_glyph/5);
	total = 0;

	if (self.cnt_torch > 3)
		total += item.cnt_torch = 3;
	else
		total += item.cnt_torch = self.cnt_torch;

	if (self.cnt_h_boost > 3)
		total += item.cnt_h_boost = 3;
	else
		total += item.cnt_h_boost = self.cnt_h_boost;

	if (self.cnt_sh_boost > 3)
		total += item.cnt_sh_boost = 3;
	else
		total += item.cnt_sh_boost = self.cnt_sh_boost;

	if (self.cnt_mana_boost > 3)
		total += item.cnt_mana_boost = 3;
	else
		total += item.cnt_mana_boost = self.cnt_mana_boost;

	if (self.cnt_teleport > 3)
		total += item.cnt_teleport = 3;
	else
		total += item.cnt_teleport = self.cnt_teleport;

	if (self.cnt_tome > 3)
		total += item.cnt_tome = 3;
	else
		total += item.cnt_tome = self.cnt_tome;

	if (self.cnt_summon > 3)
		total += item.cnt_summon = 3;
	else
		total += item.cnt_summon = self.cnt_summon;

	if (self.cnt_invisibility > 3)
		total += item.cnt_invisibility = 3;
	else
		total += item.cnt_invisibility = self.cnt_invisibility;

	if (self.cnt_glyph > 3)
		total += item.cnt_glyph = 3;
	else
		total += item.cnt_glyph = self.cnt_glyph;

	if (self.cnt_haste > 3)
		total += item.cnt_haste = 3;
	else
		total += item.cnt_haste = self.cnt_haste;

	if (self.cnt_blast > 3)
		total += item.cnt_blast = 3;
	else
		total += item.cnt_blast = self.cnt_blast;

	if (self.cnt_polymorph > 3)
		total += item.cnt_polymorph = 3;
	else
		total += item.cnt_polymorph = self.cnt_polymorph;

	if (self.cnt_flight > 3)
		total += item.cnt_flight = 3;
	else
		total += item.cnt_flight = self.cnt_flight;

	if (self.cnt_cubeofforce > 3)
		total += item.cnt_cubeofforce = 3;
	else
		total += item.cnt_cubeofforce = self.cnt_cubeofforce;

	if (self.cnt_invincibility > 3)
		total += item.cnt_invincibility = 3;
	else
		total += item.cnt_invincibility = self.cnt_invincibility;

	// Full armor on this body?
	if (self.armor_amulet==20)
	{
		total += 1;
		item.armor_amulet = self.armor_amulet;
	}

	if (self.armor_bracer==20)
	{
		total += 1;
		item.armor_bracer = self.armor_bracer;
	}

	if (self.armor_breastplate==20)
	{
		total += 1;
		item.armor_breastplate = self.armor_breastplate;
	}

	if (self.armor_helmet==20)
	{
		total += 1;
		item.armor_helmet = self.armor_helmet;
	}

/*	if (self.puzzle_inv1)
	{
		item.puzzle_inv1 = self.puzzle_inv1;
		total = 999;
	}
	if (self.puzzle_inv2)
	{
		item.puzzle_inv2 = self.puzzle_inv2;
		total = 999;
	}
	if (self.puzzle_inv3)
	{
		item.puzzle_inv3 = self.puzzle_inv3;
		total = 999;
	}
	if (self.puzzle_inv4)
	{
		item.puzzle_inv4 = self.puzzle_inv4;
		total = 999;
	}
	if (self.puzzle_inv5)
	{
		item.puzzle_inv5 = self.puzzle_inv5;
		total = 999;
	}
	if (self.puzzle_inv6)
	{
		item.puzzle_inv6 = self.puzzle_inv6;
		total = 999;
	}
	if (self.puzzle_inv7)
	{
		item.puzzle_inv7 = self.puzzle_inv7;
		total = 999;
	}
	if (self.puzzle_inv8)
	{
		item.puzzle_inv8 = self.puzzle_inv8;
		total = 999;
	}
*/

	// Any mana or instant health 	
	item.bluemana = self.bluemana;
	item.greenmana = self.greenmana;
	item.spawn_health = self.spawn_health;

//	total = 1;
//	item.cnt_tome = 1;

	if (!total && !item.bluemana && !item.greenmana && !item.spawn_health) 
	{	// Nothing to put in the backpack
		remove(item);
		return;
	}

	setorigin(item,self.origin);
	item.origin = self.origin + '0 0 40';
	item.flags |= FL_ITEM;
	item.solid = SOLID_TRIGGER;
	item.movetype = MOVETYPE_TOSS;
	item.owner = self;
	item.artifact_ignore_owner_time = time + 2;
	item.artifact_ignore_time = time + 0.1;

	if ((total == 1 && !item.bluemana && !item.greenmana && !item.spawn_health) ||
	    (total == 0 &&  item.bluemana && !item.greenmana && !item.spawn_health)  ||
		(total == 0 && !item.bluemana &&  item.greenmana && !item.spawn_health)  ||
	    (total == 0 && !item.bluemana && !item.greenmana &&  item.spawn_health))
	{	// throw out the individual item
		item.velocity_z = 200;
//		item.velocity_x = random(-20,20);
//		item.velocity_y = random(-20,20);

		old_self = self;
		self = item;

		if (item.cnt_torch)
		{
			spawn_artifact(ARTIFACT_TORCH,NO_RESPAWN);
		}
		else if (item.cnt_h_boost)
		{
			spawn_artifact(ARTIFACT_HP_BOOST,NO_RESPAWN);
		}
		else if (item.cnt_sh_boost)
		{
			spawn_artifact(ARTIFACT_SUPER_HP_BOOST,NO_RESPAWN);
		}
		else if (item.cnt_mana_boost)
		{
			spawn_artifact(ARTIFACT_MANA_BOOST,NO_RESPAWN);
		}
		else if (item.cnt_teleport)
		{
			spawn_artifact(ARTIFACT_TELEPORT,NO_RESPAWN);
		}
		else if (item.cnt_tome)
		{
			spawn_artifact(ARTIFACT_TOME,NO_RESPAWN);
		}
		else if (item.cnt_summon)
		{
			spawn_artifact (ARTIFACT_SUMMON,NO_RESPAWN);
		}
		else if (item.cnt_invisibility)
		{
			spawn_artifact (ARTIFACT_INVISIBILITY,NO_RESPAWN);
		}
		else if (item.cnt_glyph)
		{
			spawn_artifact (ARTIFACT_GLYPH,NO_RESPAWN);
		}
		else if (item.cnt_haste)
		{
			spawn_artifact (ARTIFACT_HASTE,NO_RESPAWN);
		}
		else if (item.cnt_blast)
		{
			spawn_artifact(ARTIFACT_BLAST,NO_RESPAWN);
		}
		else if (item.cnt_polymorph)
		{
			spawn_artifact (ARTIFACT_POLYMORPH,NO_RESPAWN);
		}
		else if (item.cnt_flight)
		{
			spawn_artifact (ARTIFACT_FLIGHT,NO_RESPAWN);
		}
		else if (item.cnt_cubeofforce)
		{
			spawn_artifact (ARTIFACT_CUBEOFFORCE,NO_RESPAWN);
		}
		else if (item.cnt_invincibility)
		{
			spawn_artifact (ARTIFACT_INVINCIBILITY,NO_RESPAWN);
		}
		else if ((item.bluemana) && (item.greenmana))
		{
			spawn_item_mana_both(self.bluemana);
		}
		else if (item.bluemana)
		{
			spawn_item_mana_blue(self.bluemana);
		}
		else if (item.greenmana)
		{
			spawn_item_mana_green(self.greenmana);
		}
		else if (item.spawn_health)
		{
			spawn_instant_health();
		}
		else if (item.armor_amulet)
		{
			spawn_item_armor_amulet();
		}
		else if (item.armor_bracer)
		{
			spawn_item_armor_bracer();
		}
		else if (item.armor_breastplate)
		{
			spawn_item_armor_breastplate();
		}
		else if (item.armor_helmet)
		{
			spawn_item_armor_helmet();
		}
		else
		{
			dprint("Bad backpack!");
			remove(item);
			self = old_self;
			return;
		}

		self = old_self;
	}
	else
	{
		item.velocity_z = 300;
//		item.velocity_x = random(-20,20);
//		item.velocity_y = random(-20,20);

		setmodel (item, "models/bag.mdl");
		setsize (item, '-16 -16 -45', '16 16 10');
		item.hull=HULL_POINT;
		item.touch = BackpackTouch;
	
		item.nextthink = time + 120;	// remove after 2 minutes
		item.think = SUB_Remove;

		if (!total)
		{
			remove(item);
			return;
		}
	}

	self.cnt_torch=0;
    self.cnt_h_boost=0;
    self.cnt_sh_boost=0;
    self.cnt_mana_boost=0;
    self.cnt_teleport=0;
    self.cnt_tome=0;
    self.cnt_summon=0;
    self.cnt_invisibility=0;
    self.cnt_glyph=0;
    self.cnt_haste=0;
    self.cnt_blast=0;
    self.cnt_polymorph=0;
    self.cnt_flight=0;
    self.cnt_cubeofforce=0;
    self.cnt_invincibility=0;

	self.armor_amulet=0;
	self.armor_bracer=0;
	self.armor_breastplate = 0;
	self.armor_helmet = 0;
	self.bluemana=0;
	self.greenmana=0;
	self.spawn_health=0;
};

