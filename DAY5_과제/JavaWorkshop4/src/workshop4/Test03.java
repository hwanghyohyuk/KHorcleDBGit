package workshop4;

public class Test03 {

	public static void main(String[] args) {
		/*
		 * 다음 배열의 내용을 실행 결과와 같이 출력 되도록 프로그램을 작성 하시오.
		 */
		int[] arr = { 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 };
		int temp=0;
		/*선택정렬*/
		/*
		for(int i=0; i<arr.length-1;i++){
			int maxIndex = i;
			for(int j=i+1; j<arr.length;j++){
				if(arr[maxIndex]<=arr[j]){
					maxIndex = j;
				}
			}
			temp = arr[i];
			arr[i]=arr[maxIndex];
			arr[maxIndex]=temp;
			
		}
		
		/*삽입정렬*/
		/*
		for(int i=1; i<arr.length;i++){
			int key = arr[i], j=i-1;
			while(j>=0&&key>=arr[j]){
				temp = arr[j];
				arr[j]=arr[j+1];
				arr[j+1]=temp;
				j--;
			}
			arr[j+1]=key;
		}
		
		/*버블정렬*/
		for(int i=0;i<arr.length;i++){
			for(int j=1;j<arr.length-i;j++){
				if(arr[j-1]<arr[j]){
					temp=arr[j-1];
					arr[j-1] = arr[j];
					arr[j] = temp;
				}
			}
		}
		
		for(int i=0;i<arr.length;i++){
			System.out.print(arr[i]+" ");
		}
	}

}
