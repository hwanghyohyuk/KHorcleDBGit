package compony;

public class Compony {

	private double salary;
	private double annualIncome;
	private double afterTaxIncome;
	private double bonus;
	private double afterTaxBonus;
	public Compony() {
		super();
	}
	public Compony(double salary) {
		super();
		this.salary = salary;
	}
	public double getIncome(){
		annualIncome = salary * 12;
		return annualIncome;
	}
	public double getAfterTaxIncome(){
		afterTaxIncome = salary * 12 * 0.9;
		return afterTaxIncome;
	}
	public double getBonus() {
		bonus = salary*0.2*4;
		return bonus;
	}
	public double getAfterTaxBonus(){
		afterTaxBonus = salary*0.2*4*0.945;
		return afterTaxBonus;
	}
	public double getSalary() {
		return salary;
	}
	public void setSalary(double salary) {
		this.salary = salary;
	}
	public void setAnnualIncome(double annualIncome) {
		this.annualIncome = annualIncome;
	}
	public void setBonus(double bonus) {
		this.bonus = bonus;
	}
	public void setAfterTaxBonus(double afterTaxBonus) {
		this.afterTaxBonus = afterTaxBonus;
	}
}
