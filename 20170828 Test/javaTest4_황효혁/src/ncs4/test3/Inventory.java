package ncs4.test3;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Inventory {
	private String productName=null; // 상품명
	private Date putDate=null; // 입고일
	private Date getDate=null; // 출고일
	private int putAmount=0; // 입고수량
	private int getAmount=0; // 출고수량
	private int inventoryAmount=0; // 재고수량

	public Inventory() {
		super();
	}

	public Inventory(String productName, Date putDate, int putAmount) {
		super();
		this.productName = productName;
		this.putDate = putDate;
		this.putAmount = putAmount;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public Date getPutDate() {
		return putDate;
	}

	public void setPutDate(Date putDate) {
		this.putDate = putDate;
	}

	public Date getGetDate() {
		return getDate;
	}

	public void setGetDate(Date setDate) {
		this.getDate = setDate;
	}

	public int getPutAmount() {
		return putAmount;
	}

	public void setPutAmount(int putAmount) {
		this.putAmount = putAmount;
	}

	public int getGetAmount() {
		return getAmount;
	}

	public void setGetAmount(int getAmount) throws AmountNotEnough {
		if (this.inventoryAmount < getAmount) {
			throw new AmountNotEnough("현재 재고가 부족합니다. 재고 수량을 확인하시기 바랍니다.");
		} else {
			this.inventoryAmount = this.putAmount - getAmount;
		}
	}

	public int getInventoryAmount() {
		return inventoryAmount;
	}

	public void setInventoryAmount(int inventoryAmount) {
		this.inventoryAmount = inventoryAmount;
	}

	@Override
	public String toString() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
		return productName + ", " + sdf.format(putDate) + " 입고, " + putAmount + "개, " 
				+(getDate==null?"null":sdf.format(getDate)) + " 출고, "
				+ getAmount + "개, 재고 " + inventoryAmount+"개";
	}
}
