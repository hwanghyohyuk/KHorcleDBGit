package workshop1;

public class Test02 {
	
	public static void main(String[] args) {
		
		if (Double.parseDouble(args[0]) >= 5 && Double.parseDouble(args[0]) <= 10) {
			
			double num = Double.parseDouble(args[0]);
			int count = 0;
			double sum = 0, multi = 1;
			for(int i = 1; i <= num; i++) {
					sum += i;
					count++;
			}
			System.out.println("�� : " + sum);
			
			for(int i = 1; i <= num; i++) {
				multi *= i;
			}
			System.out.println("�� : " + multi);
			
			
			System.out.println("��� : " + sum/count);
			
			
		}else{
			System.out.println("�ٽ� �Է��ϼ���.");
		}
	}
}
