void ()time_restore = {
	AdvanceThinkTime(self, 0.02);
	remove(self);
	localcmd( "host_framerate 0\n");
};


void ()time_warp = {
	//self.owner.magic_finished = (time + 10.0);
	self.magic_finished = (time + 10.0);
	newmis = spawn();
	localcmd( "host_framerate 0.004\n");
	AdvanceThinkTime(newmis, 4.0);
	newmis.think = time_restore;
};