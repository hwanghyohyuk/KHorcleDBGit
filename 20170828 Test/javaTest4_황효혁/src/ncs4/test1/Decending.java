package ncs4.test1;

import java.util.Comparator;

public class Decending implements Comparator<Object>{

	@Override
	public int compare(Object o1, Object o2) {
		int i1;
		int i2;
		if(o1 instanceof Integer && o2 instanceof Integer){
			i1 = (int)o1;
			i2 = (int)o2;
			if(i1<i2){
				return 1;
			}else if (i1==i2){
				return 0;
			}else{
				return -1;
			}
		}
		else{
			return 0;
		}
	}

}
