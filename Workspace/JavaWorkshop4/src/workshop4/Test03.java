package workshop4;

public class Test03 {

	public static void main(String[] args) {
		/*
		 * 다음 배열의 내용을 실행 결과와 같이 출력 되도록 프로그램을 작성 하시오.
		 */

		int[] arr = { 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 };
		int maxValue =0;
		int maxIndex = 0;
		int temp=0;
		for(int i=0; i<arr.length;i++){
			for(int j=i; j<arr.length;j++){
				if(maxValue<arr[j]){
					maxValue = arr[j];//가장큰값을 저장
					maxIndex = j;
				}
			}
			temp = arr[i];
			arr[i]=arr[maxIndex];
			arr[maxIndex]=temp;
			maxValue=0;
		}
		
		for(int i=0;i<arr.length;i++){
			System.out.print(arr[i]+" ");
		}
	}

}
