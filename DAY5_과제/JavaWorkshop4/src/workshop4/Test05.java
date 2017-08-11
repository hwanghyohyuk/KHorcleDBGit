package workshop4;

public class Test05 {

	public static void main(String[] args) {
		
		int data = Integer.parseInt(args[0]);
		if(data>=1 && data <=5){
			int sum = 0;
			boolean isFirst=true;
			for(int i=data;i<=10;i++){
				if(i%3!=0 && i%5!=0){
					if(isFirst){
						isFirst = false;
					}else{
						System.out.print("+");
					}
					System.out.print(i);
					sum+=i;
				}				
			}
			System.out.println();
			System.out.println("결과 : "+ sum);
		}else{
			System.out.println("다시 입력하세요");
		}
	}

}
