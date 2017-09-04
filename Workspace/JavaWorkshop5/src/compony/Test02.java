package compony;

public class Test02 {

	public static void main(String[] args) {
		double income = Double.parseDouble(args[0]);
		
		Compony c = new Compony(income);
		
		System.out.println("연 기본급의 합 : "+c.getIncome()+" 세후 : "+c.getAfterTaxIncome());
		System.out.println("연 보너스의 합 : "+c.getBonus()+" 세후 : "+c.getAfterTaxBonus());
		System.out.println("연 지급액 합 : "+c.getAfterTaxIncome()+c.getAfterTaxBonus());
	
	}

}
