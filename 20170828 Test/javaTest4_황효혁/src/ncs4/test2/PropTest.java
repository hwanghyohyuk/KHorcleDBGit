package ncs4.test2;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

public class PropTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Properties p = new Properties();
		p.put("1", "apple,1200,3");
		p.put("2", "banana,2500,2");
		p.put("3", "grape,4500,5");
		p.put("4", "orange,800,10");
		p.put("5", "melon,5000,2");
		
		new PropTest().fileSave(p);
		new PropTest().fileOpen(p);
	}

	public void fileSave(Properties p){
		
			try {
				p.storeToXML(new FileOutputStream("data.xml"),"");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
	
	public void fileOpen(Properties p){
		try {
			p.loadFromXML(new FileInputStream("data.xml"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Fruit[] fruits = new Fruit[p.size()];
		for(int i=0;i<fruits.length;i++){
			String data = p.getProperty(String.valueOf(i+1));
			String[] datas = data.split(",");
			fruits[i] = new Fruit(datas[0], Integer.parseInt(datas[1]), Integer.parseInt(datas[2]));
			System.out.println((i+1)+" = "+fruits[i].toString());
		}	
	}
	
}
