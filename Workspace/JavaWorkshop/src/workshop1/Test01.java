package workshop1;

public class Test01 {

	public static void main(String[] args) {
		
		if (Double.parseDouble(args[0]) >= 1 && Double.parseDouble(args[0]) <= 10
				&& Double.parseDouble(args[1]) >= 1 && Double.parseDouble(args[1]) <= 10) {
			
			double num1 = Double.parseDouble(args[0]);
			double num2 = Double.parseDouble(args[1]);
			
			if((num1 % num2) > 1){
				System.out.println("�������� 1���� ũ��!");
			}else{
				System.out.println("�������� 1���� �۰ų� ����");
			}
			
		}

	}

}
