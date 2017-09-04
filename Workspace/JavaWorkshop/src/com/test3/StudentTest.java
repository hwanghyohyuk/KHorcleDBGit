package com.test3;

public class StudentTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Student[] studentArray = new Student[3];
		int ageMin=100;
		int ageMax=1;
		int heiMin = 300;
		int heiMax = 100;
		int weiMin = 200;
		int weiMax = 10;	
		String ageMinS = null;
		String ageMaxS = null;
		String heiMinS = null;
		String heiMaxS = null;
		String weiMinS = null;
		String weiMaxS = null;
		
		
		studentArray[0] = new Student("홍길동", 15, 170, 80);
		studentArray[1] = new Student("한사람", 13, 180, 70);
		studentArray[2] = new Student("임걱정", 16, 175, 65);
		System.out.println("이름\t나이\t신장\t몸무게");
		for(int i =0; i<studentArray.length;i++){
			System.out.println(studentArray[i].studentInfo());
			if(studentArray[i].getAge()>ageMax){ageMax = studentArray[i].getAge(); ageMaxS = studentArray[i].getName();}
			if(studentArray[i].getAge()<ageMin){ageMin = studentArray[i].getAge(); ageMinS = studentArray[i].getName();}
			if(studentArray[i].getHeight()>heiMax){heiMax = studentArray[i].getAge(); heiMaxS = studentArray[i].getName();}
			if(studentArray[i].getHeight()<heiMin){heiMin = studentArray[i].getAge(); heiMinS = studentArray[i].getName();}
			if(studentArray[i].getWeight()>weiMax){weiMax = studentArray[i].getAge(); weiMaxS = studentArray[i].getName();}
			if(studentArray[i].getWeight()<weiMin){weiMin = studentArray[i].getAge(); weiMinS = studentArray[i].getName();}
		}
		System.out.println();
		double ageAve = (studentArray[0].getAge()+studentArray[1].getAge()+studentArray[2].getAge())/3;
		System.out.printf("나이 평균 : %.3f\n",ageAve);
		double heiAve = (studentArray[0].getHeight()+studentArray[1].getHeight()+studentArray[2].getHeight())/3;
		System.out.printf("신장 평균 : %.3f\n",heiAve);
		double weiAve = (studentArray[0].getWeight()+studentArray[1].getWeight()+studentArray[2].getWeight())/3;
		System.out.printf("몸무게 평균 : %.3f\n",weiAve);

		System.out.println("나이가 가장 많은 학생 : "+ageMaxS);
		System.out.println("나이가 가장 적은 학생 : "+ageMinS);
		System.out.println("신장이 가장 큰 학생 : "+heiMaxS);
		System.out.println("신장이 가장 작은 학생 : "+heiMinS);
		System.out.println("몸무게가 가장 많이 나가는 학생 : "+weiMaxS);
		System.out.println("몸무게가 가장 적게 나가는 학생 : "+weiMinS);
	}

}
