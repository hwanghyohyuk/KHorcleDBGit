package ncs4.test5;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.EOFException;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

public class BookListTest {

	public static void main(String[] args) {
		BookListTest test5 = new BookListTest();
		ArrayList<Book> list = new ArrayList<Book>();
		test5.storeList(list);// Book 객체를 3개 생성하여 리스트에 넣는다.
		test5.saveFile(list); //books.dat 파일에 리스트에
								// 저장된 Book 객체들을 저장한다. 
		List<Book> booksList = test5.loadFile(); //books.dat 파일로부터 객체들을 읽어서 리스트에 담는다. 
		test5.printList(booksList); //리스트에 저장된 객체 정보를 출력한다.
		// 할인된 가격은 booksList 에 기록된 객체 정보를 사용하여 getter 로 계산 출력한다. – for each 문을 이용 할 것
	}

	public void storeList(List<Book> list) {
		Book b1 = new Book("자바의정석", "남궁성", 30000, "도우출판", 0.15);
		Book b2 = new Book("열혈강의 자바", "구정은", 29000, "프리렉", 0.2);
		Book b3 = new Book("객체지향 JAVA8", "금영욱", 30000, "북스홈", 0.1);
		
		list.add(b1);
		list.add(b2);
		list.add(b3);
	}

	public void saveFile(List<Book> list) {
		ObjectOutputStream oos = null;
		try {
			oos = new ObjectOutputStream(new FileOutputStream("books.dat"));
			oos.flush();
			Iterator<Book> iter = list.iterator();
			while(iter.hasNext()){
				oos.writeObject(iter.next());
				oos.flush();
			}					
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				oos.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public List<Book> loadFile() {
		ObjectInputStream ois = null;
		ArrayList<Book> loadList = new ArrayList<Book>();
		try {
			ois = new ObjectInputStream(new FileInputStream("books.dat"));
			Object o = null;
			while((o = ois.readObject())!=null){
				if(o instanceof Book){
					loadList.add((Book)o);
				}else{
					System.out.println("error");
				}
			}					
		}catch(EOFException e){
					
		}catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				ois.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return loadList;
	}

	public void printList(List<Book> list) {
		for( Book b : list ){
			System.out.println(b.toString());
			System.out.println("할인된 가격 : "+ (int)(b.getPrice()*(1-b.getDiscountRate()))+"원");
		}
	}
}
