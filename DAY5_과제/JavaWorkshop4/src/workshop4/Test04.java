package workshop4;

public class Test04 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int data = Integer.parseInt(args[0]);
		if(data>=5 && data <=10){
			System.out.println("결과 : " + new Calc().calculate(data));
		}else{
			System.out.println("다시 입력하세요");
		}
	}

}
