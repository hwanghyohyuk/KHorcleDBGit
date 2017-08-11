package workshop4;

public class Test06 {

	public static void main(String[] args) {
		/*
		 * 1)Eclipse Argument 에서 1~5 까지의 두 개의 정수형 데이터를 입력 받아 2차원 배열을 배열을 만든다 .
		 * 2) 입력 받은 데이터가 2개 미만 또는 2개 초과로 입력 하면 “다시 입력 하세요 ” 출력 
		 * 3) 1~5 이외의 숫자가 입력 될 경우 “숫자를 확인 하세요 ” 출력 
		 * 4) 입력 받은 두개의 정수를 이용하여 2차원 배열을 생성한다 생성한다 .
		 *  5) 2차원 배열에 1~5 까지의 랜덤한 숫자 (중복허용 )를 넣는다 . 
		 *  6) 배열의 내용을 출력 한다 . 
		 *  7) 배열의 총합과 평균을 출력 한다 .
		 */
		if(args.length==2){
			int row =Integer.parseInt(args[0]);
			int column=Integer.parseInt(args[1]);
			double sum=0;
			double avg =0;
			if((row>=1 && row <=5)&&(column>=1 && column <=5)){
				int[][] array = new int[row][column];
				for(int i=0;i<array.length;i++){
					for(int j=0;j<array[i].length;j++){
						array[i][j] = (int)(Math.random()*5)+1;
						sum+=array[i][j];
						System.out.print(array[i][j]+" ");
					}					
					System.out.println();
				}
				System.out.println();
				avg= sum/(row*column);
				System.out.printf("sum = %.1f\n",sum);
				System.out.printf("avg = %.1f\n",avg);
			}else{
				System.out.println("숫자를 확인하세요");
			}
		}else{
			System.out.println("다시 입력하세요");
		}		
	}

}
