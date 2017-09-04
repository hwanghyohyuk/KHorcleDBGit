package workshop5;

public class Test01 {

	public static void main(String[] args) {
		char[] reverse = args[0].toCharArray();
		for(int i = reverse.length-1; i>=0;i--){
			System.out.print(reverse[i]);
		}	
	}

}
