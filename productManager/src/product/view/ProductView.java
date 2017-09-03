package product.view;

import java.awt.*;
import java.awt.event.*;
import java.util.ArrayList;
import java.util.Iterator;

import javax.swing.*;
import javax.swing.table.*;

import product.controller.ProductController;
import product.model.vo.Product;

public class ProductView extends JFrame {

	private ProductController pController = new ProductController();

	private JTable table;
	private ButtonGroup rdbtn_group;
	private JRadioButton rdbtn_pId;
	private JRadioButton rdbtn_pName;
	private JButton btn_viewList;
	private JTextField tf_search;
	private JButton btn_search;
	private JTextField tf_pName;
	private JSpinner sp_price;
	private JTextArea ta_description;
	private JButton btn_add;
	private JButton btn_modify;
	private JButton btn_delete;
	private JLabel lbl_pIdInfo;

	// private FileController fc = new FileController();
	private ProductController pc = new ProductController();
	private DefaultTableModel dtm = new DefaultTableModel(new Object[][] {},
			new String[] { "product_id", "p_name", "price", "description" }) { // 셀
																				// 수정
																				// 못하게
																				// 하는
																				// 부분
		public boolean isCellEditable(int row, int column) {
			return false;
		}
	};

	public ProductView() {
		super("상품 관리 프로그램");
		// 크기 설정
		int frameWidth = 800;
		int frameHeight = 600;
		double moniterWidth = Toolkit.getDefaultToolkit().getScreenSize().getWidth();
		double moniterHeight = Toolkit.getDefaultToolkit().getScreenSize().getHeight();

		// 좌표설정
		int frameStartX = (int) (moniterWidth - frameWidth) / 2;
		int frameStartY = (int) (moniterHeight - frameHeight) / 2;

		// 틀 설정
		this.setBounds(frameStartX, frameStartY, frameWidth, frameHeight);

		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setResizable(false);

		// 윈도우 이벤트
		this.addWindowListener(new WindowAdapter() {
			@Override
			public void windowOpened(WindowEvent e) {
				printList(pController.selectAll());
				lbl_pIdInfo.setText(pController.getLastId());

			}

			@Override
			public void windowClosing(WindowEvent e) {
				// fc.fileSave(pc.demodeling(dtm));
			}
		});
		// 좌측

		getContentPane().setLayout(null);

		JPanel panel_Center = new JPanel();
		panel_Center.setBounds(0, 0, 399, 561);
		getContentPane().add(panel_Center);
		panel_Center.setLayout(new BorderLayout(0, 0));

		JScrollPane scrollPane = new JScrollPane();
		panel_Center.add(scrollPane);

		table = new JTable();
		table.setAutoCreateRowSorter(true);
		table.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		table.setModel(dtm);
		scrollPane.setViewportView(table);
		table.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseReleased(MouseEvent e) {
				int row = table.getSelectedRow();
				lbl_pIdInfo.setText((String) dtm.getValueAt(row, 0));
				tf_pName.setText((String) dtm.getValueAt(row, 1));
				sp_price.setValue(dtm.getValueAt(row, 2));
				ta_description.setText((String) dtm.getValueAt(row, 3));
			}
		});
		table.getTableHeader().setReorderingAllowed(false);
		table.getTableHeader().setResizingAllowed(false);
		// 우측

		JPanel panel_East = new JPanel();
		panel_East.setBounds(399, 0, 385, 561);
		getContentPane().add(panel_East);
		panel_East.setLayout(null);

		JPanel panel_Inner = new JPanel();
		panel_Inner.setBounds(0, 0, 385, 561);
		panel_East.add(panel_Inner);
		panel_Inner.setLayout(null);

		rdbtn_pId = new JRadioButton("Product ID");
		rdbtn_pId.setBounds(12, 11, 107, 23);
		rdbtn_pId.setSelected(true);
		panel_Inner.add(rdbtn_pId);

		rdbtn_pName = new JRadioButton("Product Name");

		rdbtn_pName.setBounds(123, 11, 142, 23);
		panel_Inner.add(rdbtn_pName);

		rdbtn_group = new ButtonGroup();
		rdbtn_group.add(rdbtn_pId);
		rdbtn_group.add(rdbtn_pName);

		btn_viewList = new JButton("목록 보기");
		btn_viewList.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				printList(pController.selectAll());
			}
		});
		btn_viewList.setBounds(273, 10, 100, 25);
		panel_Inner.add(btn_viewList);

		tf_search = new JTextField();
		tf_search.setBounds(12, 45, 269, 25);
		panel_Inner.add(tf_search);
		tf_search.setColumns(10);

		btn_search = new JButton("검색");
		btn_search.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				if (rdbtn_pId.isSelected()) {
					System.out.println("상품 번호 : "+tf_search.getText()+" 검색");
					printList(pController.selectId(tf_search.getText()));
					
				}
				if (rdbtn_pName.isSelected()) {

					System.out.println("상품 명 : "+tf_search.getText()+" 검색");
					printList(pController.selectName(tf_search.getText()));
				}
			}
		});
		btn_search.setBounds(293, 45, 80, 25);
		panel_Inner.add(btn_search);

		JPanel panel_Inner2 = new JPanel();
		panel_Inner2.setBounds(12, 148, 361, 403);
		panel_Inner.add(panel_Inner2);
		panel_Inner2.setLayout(null);

		JPanel panel_Inner3 = new JPanel();
		panel_Inner3.setBounds(12, 10, 337, 30);
		panel_Inner2.add(panel_Inner3);
		panel_Inner3.setLayout(new FlowLayout(FlowLayout.CENTER, 5, 5));

		JLabel label = new JLabel("--- 상세보기 ---");
		label.setFont(new Font("굴림", Font.PLAIN, 12));
		panel_Inner3.add(label);

		JLabel lbl_pId = new JLabel("상품 ID : ");
		lbl_pId.setHorizontalAlignment(SwingConstants.CENTER);
		lbl_pId.setBounds(12, 79, 85, 15);
		panel_Inner2.add(lbl_pId);

		JLabel lbl_pName = new JLabel("상 품 명 : ");
		lbl_pName.setHorizontalAlignment(SwingConstants.CENTER);
		lbl_pName.setBounds(12, 129, 85, 15);
		panel_Inner2.add(lbl_pName);

		JLabel lbl_price = new JLabel("가   격 : ");
		lbl_price.setHorizontalAlignment(SwingConstants.CENTER);
		lbl_price.setBounds(12, 179, 85, 15);
		panel_Inner2.add(lbl_price);

		JLabel lbl_description = new JLabel("상품설명 : ");
		lbl_description.setHorizontalAlignment(SwingConstants.CENTER);
		lbl_description.setBounds(12, 229, 85, 15);
		panel_Inner2.add(lbl_description);

		lbl_pIdInfo = new JLabel("");
		lbl_pIdInfo.setBounds(109, 79, 240, 15);
		panel_Inner2.add(lbl_pIdInfo);

		tf_pName = new JTextField();
		tf_pName.setBounds(109, 126, 240, 21);
		panel_Inner2.add(tf_pName);
		tf_pName.setColumns(10);

		sp_price = new JSpinner();
		sp_price.setModel(new SpinnerNumberModel(1000, 0, 100000000, 100));
		sp_price.setBounds(109, 176, 240, 22);
		panel_Inner2.add(sp_price);

		JPanel panel_Inner4 = new JPanel();
		panel_Inner4.setBounds(0, 373, 361, 30);
		panel_Inner2.add(panel_Inner4);
		panel_Inner4.setLayout(new FlowLayout(FlowLayout.CENTER, 5, 5));

		JButton btn_new = new JButton("새로 쓰기");
		btn_new.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				lbl_pIdInfo.setText(pController.getLastId());
				tf_pName.setText("");
				sp_price.setValue(1000);
				ta_description.setText("");
			}
		});
		panel_Inner4.add(btn_new);

		btn_add = new JButton("추가");
		panel_Inner4.add(btn_add);
		btn_modify = new JButton("수정");
		panel_Inner4.add(btn_modify);
		btn_delete = new JButton("삭제");
		panel_Inner4.add(btn_delete);

		JScrollPane scrollPane_1 = new JScrollPane();
		scrollPane_1.setBounds(109, 229, 240, 124);
		panel_Inner2.add(scrollPane_1);

		ta_description = new JTextArea();
		scrollPane_1.setViewportView(ta_description);

		JButton btn_descendingName = new JButton("Descending Name");
		btn_descendingName.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				printList(pController.descendingName());
			}
		});
		btn_descendingName.setBounds(12, 80, 175, 23);
		panel_Inner.add(btn_descendingName);

		JButton btn_ascendingName = new JButton("Ascending Name");
		btn_ascendingName.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				printList(pController.ascendingName());
			}
		});
		btn_ascendingName.setBounds(12, 113, 175, 23);
		panel_Inner.add(btn_ascendingName);

		JButton btn_descendingPrice = new JButton("Descending Price");
		btn_descendingPrice.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				printList(pController.descendingPrice());
			}
		});
		btn_descendingPrice.setBounds(199, 80, 174, 23);
		panel_Inner.add(btn_descendingPrice);

		JButton btn_ascendingPrice = new JButton("Ascending Price");
		btn_ascendingPrice.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				printList(pController.ascendingPrice());
			}
		});
		btn_ascendingPrice.setBounds(199, 115, 174, 23);
		panel_Inner.add(btn_ascendingPrice);

		btn_add.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {

				// pController.insertProduct 실행
				pController.insertProduct(lbl_pIdInfo.getText(),tf_pName.getText(),(int)sp_price.getValue(),ta_description.getText());
				printList(pController.selectAll());

				lbl_pIdInfo.setText(pController.getLastId());
				tf_pName.setText("");
				sp_price.setValue(1000);
				ta_description.setText("");
			}
		});
		btn_modify.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				// pController.updateProduct 실행.
				pController.updateProduct(lbl_pIdInfo.getText(),tf_pName.getText(),(int)sp_price.getValue(),ta_description.getText());
				printList(pController.selectAll());
				
				lbl_pIdInfo.setText(pController.getLastId());
				tf_pName.setText("");
				sp_price.setValue(1000);
				ta_description.setText("");
			}
		});
		btn_delete.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				int row = table.getSelectedRow();

				// pController.deleteProduct 실행
				pController.deleteProduct((String)(table.getValueAt(row, 0)));
				printList(pController.selectAll());
				
				lbl_pIdInfo.setText(pController.getLastId());
				tf_pName.setText("");
				sp_price.setValue(1000);
				ta_description.setText("");
			}
		});

		setVisible(true);
	}

	public void printList(ArrayList<Product> list) {
		if (list != null) {
			for (int k = dtm.getRowCount() - 1; k >= 0; k--) {
				dtm.removeRow(k);
			}
			Iterator<Product> iter = list.iterator();
			Object[][] oTemp = new Object[list.size()][4];
			int i = 0;
			while (iter.hasNext()) {
				Product product = iter.next();
				oTemp[i][0] = product.getpId();
				oTemp[i][1] = product.getpName();
				oTemp[i][2] = product.getPrice();
				oTemp[i][3] = product.getDescription();
				i++;
			}
			for (int j = 0; j < oTemp.length; j++) {
				dtm.addRow(oTemp[j]);
			}
		} else {
			System.out.println("결과가 존재하지 않습니다.");
		}
	}
}
