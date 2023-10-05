package batis;

import java.io.File;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class datavo {
	
	String ridx, rname, rpass, rtext, rindate;
	String ctn;
	
	//file
	String filename;
	long filesize;
	File filesave;
}
