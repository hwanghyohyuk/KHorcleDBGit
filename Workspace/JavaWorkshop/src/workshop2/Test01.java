package workshop2;

public class Test01 {
public static void main(String[] args) {
	int[] num = new int[args.length];
	int max = Integer.MIN_VALUE;
	int min = Integer.MAX_VALUE;
	String input = "";
	for(int i=0; i<num.length;i++){
		num[i] = Integer.parseInt(args[i]);
		input +=args[i]+" ";
	}
	for(int i=0; i<num.length;i++){
		if(num[i]>=max){
			max = num[i];
		}
		if(num[i]<=min){
			min = num[i];
		}		
	}
	
	
	System.out.println("입력값 : "+input);
	System.out.println("최대값 : "+max);
	System.out.println("최소값 : "+min);
}
}
