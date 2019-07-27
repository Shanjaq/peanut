void(entity holdee) saytype;
vector gap [6]   = { '0.00000 0.00000 60.00000',
	'0.00000 0.00000 120.00000',    '0.00000 0.00000 180.00000',    '0.00000 0.00000 240.00000',    '0.00000 0.00000 300.00000',
	'0.00000 0.00000 360.00000'};

void() W_SetCurrentAmmo;
void() flash_update =
{
	self.menuspin = (gap->(self.owner.menuitem)); 
	/*
		// The Player is dead so turn the Flashlight off
	if (self.owner.deadflag != DEAD_NO)
		self.effects = 0;

		// The Player is alive so turn On the Flashlight
	else                                
		self.effects = EF_DIMLIGHT;  */
	self.flags + FL_MOVECHAIN_ANGLE;
	// Find out which direction player facing
	makevectors (self.owner.v_angle);

	// Check if there is any things infront of the flashlight
	traceline (self.owner.origin+(self.owner.view_ofs) , (self.owner.origin+(v_forward * 50)+(self.owner.view_ofs)) , FALSE , self);

	// Set the Flashlight's position

	setorigin (self, trace_endpos+(v_forward * -5));
	self.angles = (self.owner.angles + (self.v_angle - self.menuspin));
	// Repeat it in 0.02 seconds...
	self.nextthink = time + 0.02;
};

void() item0_update =
{
	self.menuspin = (gap->(self.owner.menuitem)); 
	/*
		// The Player is dead so turn the Flashlight off
		if (self.owner.deadflag != DEAD_NO)
				self.effects = 0;

		// The Player is alive so turn On the Flashlight
		else                                
				self.effects = EF_DIMLIGHT;  */
	self.flags + FL_MOVECHAIN_ANGLE;
	// Find out which direction player facing
	makevectors (self.owner.v_angle);

	// Check if there is any things infront of the flashlight
	traceline (self.owner.origin+(self.owner.view_ofs) , (self.owner.origin+(v_forward * 50)+(self.owner.view_ofs)) , FALSE , self);

	// Set the Flashlight's position
	if (self.owner.menutype == 0) {
		self.drawflags = (MLS_ABSLIGHT);
		self.abslight = 0.50000;
		setmodel (self, "models/mflame.mdl");
		if (self.owner.bluemana < 10)  {
			self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
			self.abslight = 0.50000;
		}
	} else {
		
		if (self.owner.menutype == 1) {
			self.drawflags = (MLS_ABSLIGHT);
			self.abslight = 0.50000;
			setmodel (self, "models/mflame.mdl");
			if (self.owner.bluemana < 1)  {
				self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
				self.abslight = 0.50000;
			}
		} else {
			
			if (self.owner.menutype == 2) {
				self.drawflags = (MLS_ABSLIGHT);
				self.abslight = 0.50000;
				setmodel (self, "models/zap.mdl");
				if (self.owner.bluemana < 8)  {
					self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
					self.abslight = 0.5;
				}

			} else {


				if (self.owner.menutype == 3) {
					setmodel (self, "models/mawind.mdl");
					self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
					self.abslight = 2.5;
					if (self.owner.bluemana < 2)  {
						self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
						self.abslight = 0.2;
					}
				} else {

					if (self.owner.menutype == 4) {
						setmodel (self, "models/mawind.mdl");
						self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
						self.abslight = 2.5;
						if (self.owner.bluemana < 1)  {
							self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
							self.abslight = 0.2;
						}
					} else {

						if (self.owner.menutype == 5) {
							setmodel (self, "models/mawind.mdl");
							self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
							self.abslight = 2.5;
							if (self.owner.bluemana < 10)  {
								self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
								self.abslight = 0.2;
							}
						} else {


							setmodel (self, "models/iceshot1.mdl");
						}
					}
				}
			}
		}
	}
	setorigin (self, trace_endpos+(v_forward * -5));
	self.angles = (self.owner.angles + (self.v_angle - self.menuspin));
	// Repeat it in 0.02 seconds...
	self.nextthink = time + 0.02;
};


void() item1_update =
{
	self.menuspin = (gap->(self.owner.menuitem)); 
	/*
		// The Player is dead so turn the Flashlight off
		if (self.owner.deadflag != DEAD_NO)
				self.effects = 0;

		// The Player is alive so turn On the Flashlight
		else                                
				self.effects = EF_DIMLIGHT;  */
	self.flags + FL_MOVECHAIN_ANGLE;
	// Find out which direction player facing
	makevectors (self.owner.v_angle);

	// Check if there is any things infront of the flashlight
	traceline (self.owner.origin+(self.owner.view_ofs) , (self.owner.origin+(v_forward * 50)+(self.owner.view_ofs)) , FALSE , self);

	// Set the Flashlight's position

	if (self.owner.menutype == 3) {
		if (self.owner.level > 1)  {
			self.drawflags = (MLS_ABSLIGHT);
			self.abslight = 0.50000;
			setmodel (self, "models/mtelep.mdl");
			if (self.owner.bluemana < 3)  {
				self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
				self.abslight = 0.50000;
			}
		}
	} else {


		if (self.owner.menutype == 2) {
			if (self.owner.level > 1) {
				self.drawflags = (MLS_ABSLIGHT);
				self.abslight = 0.50000;
				setmodel (self, "models/mspire.mdl");
				if (self.owner.bluemana < 8)  {
					self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
					self.abslight = 0.50000;
				}
			}
		} else {
			if (self.owner.menutype == 1) {
				if (self.owner.level > 1) {
					self.drawflags = (MLS_ABSLIGHT);
					self.abslight = 0.50000;
					setmodel (self, "models/mboot.mdl");
					if (self.owner.bluemana < 5)  {
						self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
						self.abslight = 0.50000;
					}
				}
			} else {
				if (self.owner.menutype == 4) {
					if (self.owner.level > 1) {
						self.drawflags = (MLS_ABSLIGHT);
						self.abslight = 1.50000;
						setmodel (self, "models/mspike.mdl");
						if (self.owner.bluemana < 5)  {
							self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
							self.abslight = 0.50000;
						}
					}
				} else {

					if (self.owner.menutype == 0) {
						if (self.owner.level > 1)  {
							self.drawflags = (MLS_ABSLIGHT);
							self.abslight = 0.50000;
							setmodel (self, "models/mtelep.mdl");
							if (self.owner.greenmana < 1)  {
								self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
								self.abslight = 0.50000;
							}
						}
					} else {
						if (self.owner.menutype == 5) {
							if (self.owner.level > 1)  {
								self.drawflags = (MLS_ABSLIGHT);
								self.abslight = 0.50000;
								setmodel (self, "models/mtelep.mdl");
								if (self.owner.greenmana < 1)  {
									self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
									self.abslight = 0.50000;
								}
							}
						} else {


							setmodel (self, "models/iceshot1.mdl");
						}
					}
				}
			}
		}
	}
	setorigin (self, trace_endpos+(v_forward * -5));
	self.angles = (self.owner.angles + (self.v_angle - self.menuspin));
	// Repeat it in 0.02 seconds...
	self.nextthink = time + 0.02;
};

void() item2_update =
{
	self.menuspin = (gap->(self.owner.menuitem)); 
	/*
		// The Player is dead so turn the Flashlight off
		if (self.owner.deadflag != DEAD_NO)
				self.effects = 0;

		// The Player is alive so turn On the Flashlight
		else                                
				self.effects = EF_DIMLIGHT;  */
	self.flags + FL_MOVECHAIN_ANGLE;
	// Find out which direction player facing
	makevectors (self.owner.v_angle);

	// Check if there is any things infront of the flashlight
	traceline (self.owner.origin+(self.owner.view_ofs) , (self.owner.origin+(v_forward * 50)+(self.owner.view_ofs)) , FALSE , self);

	// Set the Flashlight's position
	if (self.owner.menutype == 1) {
		if (self.owner.level > 3)  {
			self.drawflags = (MLS_ABSLIGHT);
			self.abslight = 0.50000;
			setmodel (self, "models/mred5.mdl");
			if (self.owner.bluemana < 15)  {
				self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
				self.abslight = 0.50000;
			}
		}

	} else {



		if (self.owner.menutype == 3) {
			if (self.owner.level > 3)  {
				self.drawflags = (MLS_ABSLIGHT);
				self.abslight = 0.50000;
				setmodel (self, "models/menuh.mdl");
				if (self.owner.bluemana < 15)  {
					self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
					self.abslight = 0.50000;
				}
			}

		} else {



			if (self.owner.menutype == 4) {
				if (self.owner.level > 3)  {
					self.drawflags = (MLS_ABSLIGHT);
					self.abslight = 0.50000;
					setmodel (self, "models/menuh.mdl");
					if (self.owner.bluemana < 15)  {
						self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
						self.abslight = 0.50000;
					}
				}

			} else {



				if (self.owner.menutype == 0) {
					// if (self.owner.rs>0)  {
					if (self.owner.level>3) {
						self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
						self.abslight = 1;
						setmodel (self, "models/mtail.mdl");
						if (self.owner.bluemana < 25)  {
							self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
							self.abslight = 0.50000;
						}

					}
				} else {

					if (self.owner.menutype == 5) {
						// if (self.owner.rs>0)  {
						if (self.owner.level>3) {
							self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
							self.abslight = 1;
							setmodel (self, "models/mtail.mdl");
							if (self.owner.bluemana < 25)  {
								self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
								self.abslight = 0.50000;
							}

						}
					} else {

						// if (self.owner.menutype == 2) {
						//	  setmodel (self, "");
						//        } else {
						setmodel (self, "models/iceshot1.mdl");
					}
				}
			}
		}
	}
	setorigin (self, trace_endpos+(v_forward * -5));
	self.angles = (self.owner.angles + (self.v_angle - self.menuspin));
	// Repeat it in 0.02 seconds...
	self.nextthink = time + 0.02;

};


void() item3_update =
{
	self.menuspin = (gap->(self.owner.menuitem)); 
	/*
		// The Player is dead so turn the Flashlight off
		if (self.owner.deadflag != DEAD_NO)
				self.effects = 0;

		// The Player is alive so turn On the Flashlight
		else                                
				self.effects = EF_DIMLIGHT;  */
	self.flags + FL_MOVECHAIN_ANGLE;
	// Find out which direction player facing
	makevectors (self.owner.v_angle);

	// Check if there is any things infront of the flashlight
	traceline (self.owner.origin+(self.owner.view_ofs) , (self.owner.origin+(v_forward * 50)+(self.owner.view_ofs)) , FALSE , self);

	// Set the Flashlight's position

	if (self.owner.menutype == 1) {
		if (self.owner.level > 2) {
			self.drawflags = (MLS_ABSLIGHT);
			self.abslight = 0.50000;
			setmodel (self, "models/mguard.mdl");
			if (self.owner.bluemana < 10)  {
				self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
				self.abslight = 0.50000;
			}
		}
	} else {

		if (self.owner.menutype == 0) {
			if (self.owner.level > 2)  {
				self.drawflags = (MLS_ABSLIGHT);
				self.abslight = 0.50000;
				setmodel (self, "models/mpk.mdl");
				if (self.owner.greenmana < 20)  {
					self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
					self.abslight = 0.50000;
				}
			}
		} else {

			if (self.owner.menutype == 3) {
				if (self.owner.level > 2)  {
					self.drawflags = (MLS_ABSLIGHT);
					self.abslight = 0.50000;
					setmodel (self, "models/mpk.mdl");
					if (self.owner.bluemana < 15)  {
						self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
						self.abslight = 0.50000;
					}
				}
			} else {


				if (self.owner.menutype == 2) {
					if (self.owner.level > 2) {
						self.drawflags = (MLS_ABSLIGHT);
						self.abslight = 0.50000;
						setmodel (self, "models/mslide.mdl");
						if (self.owner.bluemana < 10)  {
							self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
							self.abslight = 0.50000;
						}
					}
				} else {
					if (self.owner.menutype == 4) {
						if (self.owner.level > 2) {
							self.drawflags = (MLS_ABSLIGHT);
							self.abslight = 0.50000;
							setmodel (self, "models/mcage.mdl");
							if (self.owner.bluemana < 10)  {
								self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
								self.abslight = 0.20000;
							}
						}
					} else {
						if (self.owner.menutype == 5) {
							if (self.owner.level > 2) {
								self.drawflags = (MLS_ABSLIGHT);
								self.abslight = 0.50000;
								setmodel (self, "models/mmagnet.mdl");
								if (self.owner.bluemana < 10)  {
									self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
									self.abslight = 0.20000;
								}
							}

							// } else {
							// if (self.owner.menutype == 2) {
							//	  setmodel (self, "");
						} else {
							setmodel (self, "models/iceshot1.mdl");
						}
					}
				}
			}
		}
	}
	setorigin (self, trace_endpos+(v_forward * -5));
	self.angles = (self.owner.angles + (self.v_angle - self.menuspin));
	// Repeat it in 0.02 seconds...
	self.nextthink = time + 0.02;
};

void() item4_update =
{
	self.menuspin = (gap->(self.owner.menuitem)); 
	/*
		// The Player is dead so turn the Flashlight off
		if (self.owner.deadflag != DEAD_NO)
				self.effects = 0;

		// The Player is alive so turn On the Flashlight
		else                                
				self.effects = EF_DIMLIGHT;  */
	self.flags + FL_MOVECHAIN_ANGLE;
	// Find out which direction player facing
	makevectors (self.owner.v_angle);

	// Check if there is any things infront of the flashlight
	traceline (self.owner.origin+(self.owner.view_ofs) , (self.owner.origin+(v_forward * 50)+(self.owner.view_ofs)) , FALSE , self);

	// Set the Flashlight's position
	if (self.owner.menutype == 1) {
		if (self.owner.level > 4) {
			self.drawflags = (MLS_ABSLIGHT);
			self.abslight = 0.50000;
			setmodel (self, "models/cool.mdl");
			if (self.owner.bluemana < 20)  {
				self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
				self.abslight = 0.50000;
			}
		}

	} else {

		if (self.owner.menutype == 5) {
			if (self.owner.level > 4) {
				self.drawflags = (MLS_ABSLIGHT);
				self.abslight = 0.50000;
				setmodel (self, "models/mghail.mdl");
				if (self.owner.bluemana < 20)  {
					self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
					self.abslight = 0.50000;
				}
			}

		} else {

			if (self.owner.menutype == 0) {
				if (self.owner.level > 4) {
					self.drawflags = (MLS_ABSLIGHT);
					self.abslight = 0.50000;
					setmodel (self, "models/mghail.mdl");
					if (self.owner.bluemana < 1)  {
						self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
						self.abslight = 0.50000;
					}
				}

			} else {

				if (self.owner.menutype == 3) {
					if (self.owner.level > 4)  {
						self.drawflags = (MLS_ABSLIGHT);
						self.abslight = 0.50000;
						setmodel (self, "models/mghail.mdl");
						if (self.owner.bluemana < 30)  {
							self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
							self.abslight = 0.50000;
						}
					}

				} else {

					if (self.owner.menutype == 4) {
						if (self.owner.level > 4)  {
							self.drawflags = (MLS_ABSLIGHT);
							self.abslight = 0.50000;
							setmodel (self, "models/mghail.mdl");
							if (self.owner.bluemana < 25)  {
								self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
								self.abslight = 0.50000;
							}
						}

					} else {
						setmodel (self, "models/iceshot1.mdl");
					}
				}
			}
		}
	}
	setorigin (self, trace_endpos+(v_forward * -5));
	self.angles = (self.owner.angles + (self.v_angle - self.menuspin));
	// Repeat it in 0.02 seconds...
	self.nextthink = time + 0.02;
};




void() item5_update =
{
	self.menuspin = (gap->(self.owner.menuitem)); 
	/*
		// The Player is dead so turn the Flashlight off
		if (self.owner.deadflag != DEAD_NO)
				self.effects = 0;

		// The Player is alive so turn On the Flashlight
		else                                
				self.effects = EF_DIMLIGHT;  */
	self.flags + FL_MOVECHAIN_ANGLE;
	// Find out which direction player facing
	makevectors (self.owner.v_angle);

	// Check if there is any things infront of the flashlight
	traceline (self.owner.origin+(self.owner.view_ofs) , (self.owner.origin+(v_forward * 50)+(self.owner.view_ofs)) , FALSE , self);

	// Set the Flashlight's position
	if (self.owner.menutype == 1) {
		if (self.owner.level > 5) {
			self.drawflags = (MLS_ABSLIGHT);
			self.abslight = 0.50000;
			setmodel (self, "models/m6th.mdl");
			if (self.owner.bluemana < 40)  {
				self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
				self.abslight = 0.50000;
			}
		}

	} else {

		if (self.owner.menutype == 3) {
			if (self.owner.level > 5) {
				self.drawflags = (MLS_ABSLIGHT);
				self.abslight = 0.50000;
				setmodel (self, "models/m6th.mdl");
				if (self.owner.bluemana < 35)  {
					self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
					self.abslight = 0.50000;
				}
			}

		} else {


			if (self.owner.menutype == 4) {
				if (self.owner.level > 5)  {
					self.drawflags = (MLS_ABSLIGHT);
					self.abslight = 0.50000;
					setmodel (self, "models/m6th.mdl");
					if (self.owner.bluemana < 35)  {
						self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
						self.abslight = 0.50000;
					}
				}

			} else {


				if (self.owner.menutype == 0) {
					if (self.owner.level > 5)  {
						self.drawflags = (MLS_ABSLIGHT);
						self.abslight = 0.50000;
						setmodel (self, "models/m6th.mdl");
						if (self.owner.bluemana < 40)  {
							self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
							self.abslight = 0.50000;
						}
					}

				} else {

					if (self.owner.menutype == 5) {
						if (self.owner.level > 5)  {
							self.drawflags = (MLS_ABSLIGHT);
							self.abslight = 0.50000;
							setmodel (self, "models/m6th.mdl");
							if (self.owner.bluemana < 35)  {
								self.drawflags |= (DRF_TRANSLUCENT | MLS_ABSLIGHT);
								self.abslight = 0.50000;
							}
						}

					} else {

						setmodel (self, "models/iceshot1.mdl");
					}
				}
			}
		}
	}
	setorigin (self, trace_endpos+(v_forward * -5));
	self.angles = (self.owner.angles + (self.v_angle - self.menuspin));
	// Repeat it in 0.02 seconds...
	self.nextthink = time + 0.02;
};






vector dir2;

void() select_update =
{
	/*
		// The Player is dead so turn the Flashlight off
		if (self.owner.deadflag != DEAD_NO)
				self.effects = 0;

		// The Player is alive so turn On the Flashlight
		else                                
				self.effects = EF_DIMLIGHT;  */
	self.flags + FL_MOVECHAIN_ANGLE;
	// Find out which direction player facing
	makevectors (self.owner.v_angle);

	// Check if there is any things infront of the flashlight
	traceline (self.owner.origin+(self.owner.view_ofs) , (self.owner.origin+(v_forward * 50)+(self.owner.view_ofs)) , FALSE , self);

	// Set the Flashlight's position
	setorigin (self, trace_endpos+(v_forward * -5));
	if (self.owner.ftype == 1) {
		if (dir2_y == 100) {
			self.owner.menutype = (self.owner.menutype + 1);

			if (self.owner.menutype > 5) {
				self.owner.menutype = 0;
			}
			saytype(self.owner);
			self.skin = self.owner.menutype;

		}
		if (dir2_y > 180){
			if (self.owner.cskin == 0) {
				self.owner.ftype = 0;
			}
			dir2 = '0 0 0';
		} else {
			dir2_y = dir2_y + 20;
		}
		self.angles = (self.owner.angles + self.v_angle + dir2);
	} 
	if (self.owner.ftype == 2) {
		if (dir2_y == 100) {

			self.owner.menutype = (self.owner.menutype - 1);
			if (self.owner.menutype < 1) {
				self.owner.menutype = 6;
			}
			saytype(self.owner);
			self.skin = self.owner.menutype;

		}

		if (dir2_y > 180) {
			if (self.owner.cskin == 0) {
				self.owner.ftype = 0;
			}
			dir2 = '0 0 0';
		} else {
			dir2_y = dir2_y + 20;
		}
		self.angles = (self.owner.angles + self.v_angle - dir2);
	}
	if (self.owner.ftype == 0) {
		self.owner.menutype = 3;
		self.angles = (self.owner.angles + self.v_angle);
		self.skin = self.owner.menutype;
	}
	// Repeat it in 0.02 seconds...
	self.nextthink = time + 0.02;
};


void() flash_on =
{

	// Make a new entity to hold the Flashlight
	local entity myflash;

	// spawn flash
	myflash = spawn ();
	myflash.movetype = MOVETYPE_NONE;
	myflash.solid = SOLID_NOT;
	// this uses the s_bubble.spr, if you want it to be completly
	// invisible you need to create a one pixel trancparent spirit
	// and use it here...
	setmodel (myflash, "models/iceshot1.mdl"); 
	setsize (myflash, '0 0 0', '0 0 0');

	// Wire Player And Flashlight Together
	myflash.owner = self;
	self.flash = myflash;
	
	// give the flash a Name And Make It Glow
	myflash.classname = "flash";
	//myflash.effects = EF_DIMLIGHT;
	myflash.drawflags = MLS_ABSLIGHT;
	myflash.abslight = 0.5;        

	// Set Start Position
	makevectors (self.v_angle);
	traceline (self.origin , (self.origin+(v_forward * 50)) , FALSE , self);
	setorigin (myflash, trace_endpos); 
	myflash.angles = (self.owner.angles + self.owner.v_angle);
	// Start Flashlight Update
	myflash.think = flash_update;
	myflash.nextthink = time + 0.02;
};

void() ring_on =
{

	// Make a new entity to hold the Flashlight
	local entity myring;

	// spawn flash
	myring = spawn ();
	myring.movetype = MOVETYPE_NONE;
	myring.solid = SOLID_NOT;
	// this uses the s_bubble.spr, if you want it to be completly
	// invisible you need to create a one pixel trancparent spirit
	// and use it here...
	setmodel (myring, "models/mring.mdl"); 
	setsize (myring, '0 0 0', '0 0 0');

	// Wire Player And Flashlight Together
	myring.owner = self;
	self.Mmyring = myring;
	
	// give the flash a Name And Make It Glow
	myring.classname = "ring";
	//myring.effects = EF_DIMLIGHT;
	myring.drawflags = MLS_ABSLIGHT;
	myring.abslight = 0.5;        

	// Set Start Position
	makevectors (self.v_angle);
	traceline (self.origin , (self.origin+(v_forward * 50)) , FALSE , self);
	setorigin (myring, trace_endpos); 
	myring.angles = (self.owner.angles + self.owner.v_angle);
	// Start Flashlight Update
	myring.think = select_update;
	myring.nextthink = time + 0.02;
};

void() item_zero =
{

	// Make a new entity to hold the Flashlight
	local entity myitem0;

	// spawn flash
	myitem0 = spawn ();
	myitem0.movetype = MOVETYPE_NONE;
	myitem0.solid = SOLID_NOT;
	// this uses the s_bubble.spr, if you want it to be completly
	// invisible you need to create a one pixel trancparent spirit
	// and use it here...
	// setmodel (myitem0, "models/menuh.mdl"); 

	setsize (myitem0, '0 0 0', '0 0 0');

	// Wire Player And Flashlight Together
	myitem0.owner = self;
	self.I0 = myitem0;
	
	// give the flash a Name And Make It Glow
	myitem0.classname = "myitem";
	//myitem0.effects = EF_DIMLIGHT;
	myitem0.drawflags = MLS_ABSLIGHT;
	myitem0.abslight = 0.5;        

	// Set Start Position
	makevectors (self.v_angle);
	traceline (self.origin , (self.origin+(v_forward * 50)) , FALSE , self);
	setorigin (myitem0, trace_endpos); 
	myitem0.angles = (self.owner.angles + self.owner.v_angle);
	// Start Flashlight Update
	myitem0.think = item0_update;
	myitem0.nextthink = time + 0.02;
};


void() item_one =
{

	// Make a new entity to hold the Flashlight
	local entity myitem1;

	// spawn flash
	myitem1 = spawn ();
	myitem1.movetype = MOVETYPE_NONE;
	myitem1.solid = SOLID_NOT;
	// this uses the s_bubble.spr, if you want it to be completly
	// invisible you need to create a one pixel trancparent spirit
	// and use it here...
	// setmodel (myitem1, "models/menuh.mdl"); 

	setsize (myitem1, '0 0 0', '0 0 0');

	// Wire Player And Flashlight Together
	myitem1.owner = self;
	self.I1 = myitem1;
	
	// give the flash a Name And Make It Glow
	myitem1.classname = "myitem";
	//myitem1.effects = EF_DIMLIGHT;
	myitem1.drawflags = MLS_ABSLIGHT;
	myitem1.abslight = 0.5;        

	// Set Start Position
	makevectors (self.v_angle);
	traceline (self.origin , (self.origin+(v_forward * 50)) , FALSE , self);
	setorigin (myitem1, trace_endpos); 
	myitem1.angles = (self.owner.angles + self.owner.v_angle);
	// Start Flashlight Update
	myitem1.think = item1_update;
	myitem1.nextthink = time + 0.02;
};

void() item_two =
{

	// Make a new entity to hold the Flashlight
	local entity myitem2;

	// spawn flash
	myitem2 = spawn ();
	myitem2.movetype = MOVETYPE_NONE;
	myitem2.solid = SOLID_NOT;
	// this uses the s_bubble.spr, if you want it to be completly
	// invisible you need to create a one pixel trancparent spirit
	// and use it here...
	// setmodel (myitem2, "models/cool.mdl"); 

	setsize (myitem2, '0 0 0', '0 0 0');

	// Wire Player And Flashlight Together
	myitem2.owner = self;
	self.I2 = myitem2;
	
	// give the flash a Name And Make It Glow
	myitem2.classname = "myitem";
	//myitem2.effects = EF_DIMLIGHT;
	myitem2.drawflags = MLS_ABSLIGHT;
	myitem2.abslight = 0.5;        

	// Set Start Position
	makevectors (self.v_angle);
	traceline (self.origin , (self.origin+(v_forward * 50)) , FALSE , self);
	setorigin (myitem2, trace_endpos); 
	myitem2.angles = (self.owner.angles + self.owner.v_angle);
	// Start Flashlight Update
	myitem2.think = item2_update;
	myitem2.nextthink = time + 0.02;
};


void() item_three =
{

	// Make a new entity to hold the Flashlight
	local entity myitem3;

	// spawn flash
	myitem3 = spawn ();
	myitem3.movetype = MOVETYPE_NONE;
	myitem3.solid = SOLID_NOT;
	// this uses the s_bubble.spr, if you want it to be completly
	// invisible you need to create a one pixel trancparent spirit
	// and use it here...
	// setmodel (myitem3, "models/cool.mdl"); 

	setsize (myitem3, '0 0 0', '0 0 0');

	// Wire Player And Flashlight Together
	myitem3.owner = self;
	self.I3 = myitem3;
	
	// give the flash a Name And Make It Glow
	myitem3.classname = "myitem";
	//myitem3.effects = EF_DIMLIGHT;
	myitem3.drawflags = MLS_ABSLIGHT;
	myitem3.abslight = 0.5;        

	// Set Start Position
	makevectors (self.v_angle);
	traceline (self.origin , (self.origin+(v_forward * 50)) , FALSE , self);
	setorigin (myitem3, trace_endpos); 
	myitem3.angles = (self.owner.angles + self.owner.v_angle);
	// Start Flashlight Update
	myitem3.think = item3_update;
	myitem3.nextthink = time + 0.02;
};


void() item_four =
{

	// Make a new entity to hold the Flashlight
	local entity myitem4;

	// spawn flash
	myitem4 = spawn ();
	myitem4.movetype = MOVETYPE_NONE;
	myitem4.solid = SOLID_NOT;
	// this uses the s_bubble.spr, if you want it to be completly
	// invisible you need to create a one pixel trancparent spirit
	// and use it here...
	// setmodel (myitem4, "models/cool.mdl"); 

	setsize (myitem4, '0 0 0', '0 0 0');

	// Wire Player And Flashlight Together
	myitem4.owner = self;
	self.I4 = myitem4;
	
	// give the flash a Name And Make It Glow
	myitem4.classname = "myitem";
	//myitem4.effects = EF_DIMLIGHT;
	myitem4.drawflags = MLS_ABSLIGHT;
	myitem4.abslight = 0.5;
	// Set Start Position
	makevectors (self.v_angle);
	traceline (self.origin , (self.origin+(v_forward * 50)) , FALSE , self);
	setorigin (myitem4, trace_endpos); 
	myitem4.angles = (self.owner.angles + self.owner.v_angle);
	// Start Flashlight Update
	myitem4.think = item4_update;
	myitem4.nextthink = time + 0.02;
};



void() item_five =
{

	// Make a new entity to hold the Flashlight
	local entity myitem5;

	// spawn flash
	myitem5 = spawn ();
	myitem5.movetype = MOVETYPE_NONE;
	myitem5.solid = SOLID_NOT;
	// this uses the s_bubble.spr, if you want it to be completly
	// invisible you need to create a one pixel trancparent spirit
	// and use it here...
	// setmodel (myitem4, "models/cool.mdl"); 

	setsize (myitem5, '0 0 0', '0 0 0');

	// Wire Player And Flashlight Together
	myitem5.owner = self;
	self.I5 = myitem5;
	
	// give the flash a Name And Make It Glow
	myitem5.classname = "myitem";
	//myitem5.effects = EF_DIMLIGHT;
	myitem5.drawflags = MLS_ABSLIGHT;
	myitem5.abslight = 0.5;
	// Set Start Position
	makevectors (self.v_angle);
	traceline (self.origin , (self.origin+(v_forward * 50)) , FALSE , self);
	setorigin (myitem5, trace_endpos); 
	myitem5.angles = (self.owner.angles + self.owner.v_angle);
	// Start Flashlight Update
	myitem5.think = item5_update;
	myitem5.nextthink = time + 0.02;
};



void ()sayitem;

void () flash_toggle =
{
	if (self.UFO == 1) {
		return;
	} else {
		// If Off, Turn On
		if (self.flash_flag == FALSE)
		{     
			self.dunk = 1;
			self.hair = 1;  
			sayitem();
			self.flash_flag = TRUE;
			flash_on();
			item_one();
			item_two();
			item_zero();
			item_three();
			item_four();
			item_five();
			ring_on();
		}

		// If On, Turn Off
		else
		{
			self.dunk = 0;
			self.hair = 0;
			centerprint (self, "@");
			self.flash_flag = FALSE;
			//      W_SetCurrentAmmo ();
			self.flash.think = SUB_Remove;
			self.flash.nextthink = time + 0.1;
			self.I0.think = SUB_Remove;
			self.I0.nextthink = time + 0.1;
			self.I1.think = SUB_Remove;
			self.I1.nextthink = time + 0.1;
			self.I2.think = SUB_Remove;
			self.I2.nextthink = time + 0.1;
			self.I3.think = SUB_Remove;
			self.I3.nextthink = time + 0.1;
			self.I4.think = SUB_Remove;
			self.I4.nextthink = time + 0.1;
			self.I5.think = SUB_Remove;
			self.I5.nextthink = time + 0.1;

			self.Mmyring.think = SUB_Remove;
			self.Mmyring.nextthink = time + 0.1;
		}
	}
};

void () sayitem = {
	local string bat;
	bat = ftos(self.menuitem + 1);
	sprint (self, "item ");
	sprint (self, bat);
	sprint (self, "\n");
	if (self.menutype == 0) {

		if (self.menuitem == 0) {
			centerprint (self, "I@I@I@I@Time Warp@ blue@ -10");
		}
		if (self.menuitem == 1) {
			centerprint (self, "I@I@I@I@Telekinesis@ green@ -1");
		}
		if (self.menuitem == 2) {
			centerprint (self, "I@I@I@I@Teleportation@ green@ 1(-5)@ 2(-20)");
		}
		if (self.menuitem == 3) {
			centerprint (self, "I@I@I@I@Summon Meteorite@ blue@ -20");
		}
		if (self.menuitem == 4) {
			centerprint (self, "I@I@I@I@Shell of Light@ blue@ -damage");
		}
		if (self.menuitem == 5) {
			centerprint (self, "I@I@I@I@Photon Beam@ blue@ -40");
		}

	}
	if (self.menutype == 1) {




		if (self.menuitem == 0) {
			centerprint (self, "I@I@I@I@Flame Wave@ blue@ -self.level*2-->5");
		}
		if (self.menuitem == 1) {
			centerprint (self, "I@I@I@I@Boot of Ignius@ blue@ -5");
		}
		if (self.menuitem == 2) {
			centerprint (self, "I@I@I@I@Lavaball@ blue@ -10");
		}
		if (self.menuitem == 3) {
			centerprint (self, "I@I@I@I@Sweltering Sky@ blue@ -15");
		}
		if (self.menuitem == 4) {
			centerprint (self, "I@I@I@I@Pillar of Fire@ blue@ -25");
		}
		if (self.menuitem == 5) {
			centerprint (self, "I@I@I@I@Giga Flare@ blue@ -40");
		}


	}
	if (self.menutype == 2) {
		if (self.menuitem == 0) {
			centerprint (self, "I@I@I@I@Lightning Strike@ blue@ -8");
		}
		if (self.menuitem == 1) {
			centerprint (self, "I@I@I@I@Mole Spike@ blue@ -8");
		}
		if (self.menuitem == 2) {
			centerprint (self, "I@I@I@I@Arc of Death@ blue@ -10");
		}
		if (self.menuitem == 3) {
			centerprint (self, "I@I@I@I@Landslide@ blue@ -16");
		}
		if (self.menuitem == 4) {
			centerprint (self, "@");
		}
		if (self.menuitem == 5) {
			centerprint (self, "@");
		}


	}
	if (self.menutype == 3) {
		if (self.menuitem == 0) {
			centerprint (self, "I@I@I@I@Razor Wind@ blue@ -2");
		}
		if (self.menuitem == 1) {
			centerprint (self, "I@I@I@I@Aero@ blue@ -10");
		}
		if (self.menuitem == 2) {
			centerprint (self, "I@I@I@I@Bush Bash@ blue@ -15");
		}
		if (self.menuitem == 3) {
			centerprint (self, "I@I@I@I@Telluric Regeneration@ blue@ -20");
		}
		if (self.menuitem == 4) {
			centerprint (self, "I@I@I@I@Tree of Life@ -30");
		}
		if (self.menuitem == 5) {
			centerprint (self, "I@I@I@I@Tornado@ blue@ -35");
		}


	}

	if (self.menutype == 4) {
		if (self.menuitem == 0) {
			centerprint (self, "I@I@I@I@Arctic Wind@ blue@ -1/2");
		}
		if (self.menuitem == 1) {
			centerprint (self, "I@I@I@I@Cold Spike@ blue@ -5");
		}
		if (self.menuitem == 2) {
			centerprint (self, "I@I@I@I@Ice Cage@ blue@ -7");
		}
		if (self.menuitem == 3) {
			centerprint (self, "I@I@I@I@Crush Drop@ blue@ -15");
		}
		if (self.menuitem == 4) {
			centerprint (self, "I@I@I@I@Glacial Hail@ blue@ -25");
		}
		if (self.menuitem == 5) {
			centerprint (self, "I@I@I@I@Tsunami@ blue@ -35");
		}


	}

	if (self.menutype == 5) {
		if (self.menuitem == 0) {
			centerprint (self, "I@I@I@I@Shadowcaster@ blue@ -10");
		}
		if (self.menuitem == 1) {
			centerprint (self, "I@I@I@I@Black Death@ blue@ -15");
		}
		if (self.menuitem == 2) {
			centerprint (self, "I@I@I@I@Rare Earth Magnet@ blue@ -20");
		}
		if (self.menuitem == 3) {
			centerprint (self, "I@I@I@I@Dark Matter@ blue@ -25");
		}
		if (self.menuitem == 4) {
			centerprint (self, "I@I@I@I@Abyss@ blue@ -30");
		}
		if (self.menuitem == 5) {
			centerprint (self, "I@I@I@I@Black Hole@ blue@ -40");
		}


	}



};


void (entity holdee) saytype = {
	local string kid;
	kid = ftos(holdee.menutype + 1);
	sprint (holdee, "menu ");
	sprint (holdee, kid);
	sprint (holdee, "\n");
	if (holdee.menutype == 0) {
		if (holdee.menuitem == 0) {
			centerprint (holdee, "I@I@I@I@Time Warp@ blue@ -10");
		}
		if (holdee.menuitem == 1) {
			centerprint (holdee, "I@I@I@I@Telekinesis@ green@ -1");
		}
		if (holdee.menuitem == 2) {
			centerprint (holdee, "I@I@I@I@Teleportation@ green@ 1(-5)@ 2(-20)");
		}
		if (holdee.menuitem == 3) {
			centerprint (holdee, "I@I@I@I@Summon Meteorite@ blue@ -20");
		}
		if (holdee.menuitem == 4) {
			centerprint (holdee, "I@I@I@I@Shell of Light@ blue@ -damage");
		}
		if (holdee.menuitem == 5) {
			centerprint (holdee, "I@I@I@I@Photon Beam@ blue@ -40");
		}


	}
	if (holdee.menutype == 1) {

		if (holdee.menuitem == 0) {
			centerprint (holdee, "I@I@I@I@Flame Wave@ blue@ -self.level*2-->5");
		}
		if (holdee.menuitem == 1) {
			centerprint (holdee, "I@I@I@I@Boot of Ignius@ blue@ -5");
		}
		if (holdee.menuitem == 2) {
			centerprint (holdee, "I@I@I@I@Lavaball@ blue@ -10");
		}
		if (holdee.menuitem == 3) {
			centerprint (holdee, "I@I@I@I@Sweltering Sky@ blue@ -15");
		}
		if (holdee.menuitem == 4) {
			centerprint (holdee, "I@I@I@I@Pillar of Fire@ blue@ -25");
		}
		if (holdee.menuitem == 5) {
			centerprint (holdee, "I@I@I@I@Giga Flare@ blue@ -40");
		}


	}
	if (holdee.menutype == 2) {





		if (holdee.menuitem == 0) {
			centerprint (holdee, "I@I@I@I@Lightning Strike@ blue@ -8");
		}
		if (holdee.menuitem == 1) {
			centerprint (holdee, "I@I@I@I@Mole Spike@ blue@ -8");
		}
		if (holdee.menuitem == 2) {
			centerprint (holdee, "I@I@I@I@Arc of Death@ blue@ -10");
		}
		if (holdee.menuitem == 3) {
			centerprint (holdee, "I@I@I@I@Landslide@ blue@ -16");
		}
		if (holdee.menuitem == 4) {
			centerprint (holdee, "@");
		}
		if (holdee.menuitem == 5) {
			centerprint (holdee, "@");
		}

	}
	if (holdee.menutype == 3) {
		if (holdee.menuitem == 0) {
			centerprint (holdee, "I@I@I@I@Razor Wind@ blue@ -2");
		}
		if (holdee.menuitem == 1) {
			centerprint (holdee, "I@I@I@I@Aero@ blue@ -10");
		}
		if (holdee.menuitem == 2) {
			centerprint (holdee, "I@I@I@I@Bush Bash@ blue@ -15");
		}
		if (holdee.menuitem == 3) {
			centerprint (holdee, "I@I@I@I@Telluric Regeneration@ blue@ -20");
		}
		if (holdee.menuitem == 4) {
			centerprint (holdee, "I@I@I@I@Tree of Life@ blue@ -30");
		}
		if (holdee.menuitem == 5) {
			centerprint (holdee, "I@I@I@I@Tornado@ blue@ -35");
		}


	}

	if (holdee.menutype == 4) {
		if (holdee.menuitem == 0) {
			centerprint (holdee, "I@I@I@I@Arctic Wind@ blue@ -1/2");
		}
		if (holdee.menuitem == 1) {
			centerprint (holdee, "I@I@I@I@Cold Spike@ blue@ -5");
		}
		if (holdee.menuitem == 2) {
			centerprint (holdee, "I@I@I@I@Ice Cage@ blue@ -7");
		}
		if (holdee.menuitem == 3) {
			centerprint (holdee, "I@I@I@I@Crush Drop@ blue@ -15");
		}
		if (holdee.menuitem == 4) {
			centerprint (holdee, "I@I@I@I@Glacial Hail@ blue@ -25");
		}
		if (holdee.menuitem == 5) {
			centerprint (holdee, "I@I@I@I@Tsunami@ blue@ -35");
		}


	}

	if (holdee.menutype == 5) {
		if (holdee.menuitem == 0) {
			centerprint (holdee, "I@I@I@I@Shadowcaster@ blue@ -10");
		}
		if (holdee.menuitem == 1) {
			centerprint (holdee, "I@I@I@I@Black Death@ blue@ -15");
		}
		if (holdee.menuitem == 2) {
			centerprint (holdee, "I@I@I@I@Rare Earth Magnet@ blue@ -20");
		}
		if (holdee.menuitem == 3) {
			centerprint (holdee, "I@I@I@I@Dark Matter@ blue@ -25");
		}
		if (holdee.menuitem == 4) {
			centerprint (holdee, "I@I@I@I@Abyss@ blue@ -30");
		}
		if (holdee.menuitem == 5) {
			centerprint (holdee, "I@I@I@I@Black Hole@ blue@ -40");
		}


	}

};

