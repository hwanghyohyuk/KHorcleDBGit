package ncs4.test3;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Map.Entry;


public class MapTest {

	public static void main(String[] args) {
		// Generics 적용된 맵 객체를 선언 할당한다.
		Map<String, Inventory> map = new HashMap<String, Inventory>();
		 //상품명을 키로 사용하여 저장 처리 한다.
		
		Calendar t1 = Calendar.getInstance();
	    t1.set(2016, 2, 15); 
	    Date s7 = new Date(t1.getTimeInMillis());

		map.put("삼성 갤럭시S7", new Inventory("삼성 갤럭시S7", s7 ,30));

		Calendar t2 = Calendar.getInstance();
	    t1.set(2016, 1, 25); 
	    Date g5 = new Date(t2.getTimeInMillis());

		map.put("LG G5", new Inventory("LG G5", g5 ,20));
		
		Calendar t3 = Calendar.getInstance();
	    t1.set(2016, 1, 23); 
	    Date ip = new Date(t3.getTimeInMillis());

		map.put("애플 아이패드 Pro", new Inventory("애플 아이패드 Pro", ip ,15));
		 // 맵에 기록된 정보를 연속 출력한다. EntrySet() 사용한다.
	
		Inventory[] iv = new Inventory[map.size()];
		int i = 0;
		Iterator<Entry<String, Inventory>> iter = map.entrySet().iterator();
		while(iter.hasNext()){
			Entry<String, Inventory> entry =  iter.next();
			String key = entry.getKey();
			Inventory value = entry.getValue();
			System.out.println(value.toString());		
			iv[i] = value;
			i++;
		}
		System.out.println();
		for(int j=0; j<iv.length;j++){
			iv[j].setGetDate(new Date());
			try {
				iv[j].setGetAmount(20);
			} catch (AmountNotEnough e) {
				// TODO Auto-generated catch block
				System.out.println(e.getMessage());
			}
		}
		
		for(int k =0; k<iv.length;k++){
			System.out.println(iv[k].toString());
		}
	}

}
