package ncs4.test1;

import java.util.*;

public class ListTest {

	public void display(List list){
		int i = 0;
		while (i < list.size()) {
			System.out.print(list.get(i).toString() + " ");
			i++;
		}
		System.out.println();
	}
	
	public static void main(String[] args) {
		List<Integer> list = new ArrayList<Integer>();
		for(int i=0; i<10;i++){
			int r =(int)(Math.random()*100)+1;
			list.add(r);
		}
		System.out.println("정렬 전");
		new ListTest().display(list);	
		list.sort(new Decending());

		System.out.println("정렬 후");
		new ListTest().display(list);	
	}
}
