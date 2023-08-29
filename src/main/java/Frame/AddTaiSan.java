package Frame;

import DAO.CustomerDao;
import DAO.HistoryDao;
import DAO.PhantramlaiDao;
import DAO.PhieuCamDao;
import Entity.Customer;
import Entity.Phantramlai;
import Entity.Phieucam;
import static Frame.MainFrame.phieuCamDao;
import static Frame.MainFrame.tblDanhsach;
import Utils.MsgBox;
import Utils.SessionManager;
import Utils.XDate;
import Utils.XMoney;
import Utils.validateInput;
import com.raven.datechooser.SelectedAction;
import com.raven.datechooser.SelectedDate;
import java.awt.Toolkit;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.swing.table.DefaultTableModel;

/**
 * @author NHUTLQ
 */
public final class AddTaiSan extends javax.swing.JDialog {
    
    private final PhieuCamDao phieuCamDao = new PhieuCamDao();
    private final PhantramlaiDao laisuatDao = new PhantramlaiDao();
    private final HistoryDao historyDao = new HistoryDao();
    private final CustomerDao customerDao = new CustomerDao();
    
    public AddTaiSan(java.awt.Frame parent, boolean modal) {
        super(parent, modal);
        initComponents();
        init();
    }
    
    public void init() {
        maxMaPhieu();
        setDate();
        setPhantramLS();
        showDataChooser();
        
        txtPhantram.setEnabled(false);
        txtTongtienthang.setEnabled(false);
        
        validateInput.allowOnlyText(txtFullname);
        validateInput.formatPhoneNumber(txtPhonenumber);
        validateInput.autoUpperCaseWithMaxLength(txtBienso, 10);
        
        XMoney.caculatorLaixuat(txtSotien, txtTongtienthang, (laisuatDao.getPhantramLS() * 0.01));
        setIconImage(Toolkit.getDefaultToolkit().getImage(MainFrame.class.getResource("/Icon/windowbar.png")));
    }
    
    private void showDataChooser() {
        chooserData1.addEventDateChooser((SelectedAction action, SelectedDate date) -> {
            if (action.getAction() == SelectedAction.DAY_SELECTED) {
                chooserData1.hidePopup();
            }
        });
        
        chooserData2.addEventDateChooser((SelectedAction action, SelectedDate date) -> {
            if (action.getAction() == SelectedAction.DAY_SELECTED) {
                chooserData2.hidePopup();
            }
        });
    }
    
    private void maxMaPhieu() {
        txtMaphieu.setEditable(false);
        txtMaphieu.setText(phieuCamDao.generateNewMaphieu());
    }
    
    private void setPhantramLS() {
        double phantramdb = laisuatDao.getPhantramLS();
        int phantramint = (int) phantramdb;
        txtPhantram.setText(String.valueOf(phantramint));
    }
    
    private void setDate() {
        txtDate1.setText(XDate.curentDate());
        txtDate2.setText(dateToOneMonth());
    }
    
    private String dateToOneMonth() {
        Calendar calendar = Calendar.getInstance();
        
        calendar.add(Calendar.MONTH, 1);
        Date nextMonthDate = calendar.getTime();
        
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        String formattedNextMonthDate = sdf.format(nextMonthDate);
        return formattedNextMonthDate;
    }
    
    private void refeshForm() {
        txtFullname.setText("");
        txtPhonenumber.setText("");
        txtBienso.setText("");
        txtSotien.setText("");
        txtDate1.setText(XDate.curentDate());
        txtDate2.setText(dateToOneMonth());
    }
    
    private boolean check() {
        String fullname = txtFullname.getText();
        String phone = txtPhonenumber.getText();
        String bienso = txtBienso.getText();
        String sotien = txtSotien.getText();
        String ngaycam = txtDate1.getText();
        String ngaychuoc = txtDate2.getText();
        String phantram = txtPhantram.getText();
        String tongtien = txtTongtienthang.getText();
        
        if (fullname.isEmpty() || phone.isEmpty() || bienso.isEmpty()
                || sotien.isEmpty() || ngaycam == null || ngaychuoc == null
                || phantram.isEmpty() || tongtien.isEmpty()) {
            MsgBox.alert(this, "Vui lòng điền đầy đủ thông tin !");
            return false;
        }

        // Kiểm tra họ tên người Việt Nam bằng biểu thức chính quy
        String fullnameRegex = "^[\\p{L} '-]+$";
        if (!fullname.matches(fullnameRegex)) {
            MsgBox.alert(this, "Họ tên không hợp lệ !");
            return false;
        }

        // Kiểm tra số điện thoại người Việt Nam bằng biểu thức chính quy
        String phoneRegex = "^(\\+?84|0)(3[2-9]|5[689]|7[06-9]|8[1-9]|9[0-46-9])[0-9]{7}$";
        if (!phone.matches(phoneRegex)) {
            MsgBox.alert(this, "Số điện thoại không không hợp lệ !");
            return false;
        }

        // Kiểm tra biển số xe Việt Nam bằng biểu thức chính quy
        String biensoRegex = "^[0-9]{2}[A-HJ-NP-Za-hj-np-z0-9]{2}-[0-9]{4,5}$";
        if (!bienso.matches(biensoRegex)) {
            MsgBox.alert(this, "Biển số xe không đúng định dạng !");
            return false;
        }
        
        return true;
    }
    
    private void fillTable() {
        int i = 1;
        
        DefaultTableModel model = (DefaultTableModel) tblDanhsach.getModel();
        model.setRowCount(0);
        
        List<Phieucam> phieucam = phieuCamDao.findAll();
        
        for (Phieucam pc : phieucam) {
            Object[] row = {
                String.valueOf(i++),
                pc.getMaphieu(),
                pc.getCustomer().getFullname(),
                pc.getCustomer().getPhonenumber(),
                pc.getBienso(),
                XMoney.formatMoney(pc.getTiengoc()),
                XMoney.formatMoney(pc.getTienlai()),
                XDate.toString(pc.getNgayvao(), "dd-MM-yyyy"),
                XDate.toString(pc.getNgayra(), "dd-MM-yyyy"),
                pc.getStatus()
            };
            model.addRow(row);
        }
    }
    
    private void addPhieu() {
        String maphieu = txtMaphieu.getText();
        String fullname = txtFullname.getText();
        String phone = txtPhonenumber.getText();
        String bienso = txtBienso.getText();
        String sotien = txtSotien.getText();
        String ngaycam = txtDate1.getText();
        String ngaychuoc = txtDate2.getText();
        String phantramls = txtPhantram.getText();
        String tienlai = txtTongtienthang.getText();
        
        String numberString1 = sotien.replaceAll("[^0-9]", "");
        int sotiencam = Integer.parseInt(numberString1);
        
        String numberString2 = tienlai.replaceAll("[^0-9]", "");
        int sotienlai = Integer.parseInt(numberString2);
        
        String numberPart = phantramls.replace("%", "");
        int phantram = Integer.parseInt(numberPart);
        
        if (!maphieu.isEmpty() || !fullname.isEmpty() || !phone.isEmpty() || !bienso.isEmpty()
                || !sotien.isEmpty() || ngaycam != null || ngaychuoc != null
                || !tienlai.isEmpty()) {
            
            Phantramlai ls = laisuatDao.findById();
            
            Customer cus = new Customer();
            cus.setFullname(fullname);
            cus.setPhonenumber(phone);
            Customer customer = customerDao.addCustomer(cus);
            
            Phieucam pc = new Phieucam();
            
            pc.setMaphieu(maphieu);
            pc.setCustomer(customer);
            pc.setTiengoc(sotiencam);
            pc.setTienlai(sotienlai);
            pc.setBienso(bienso);
            pc.setNgayvao(XDate.toDate(ngaycam, "dd-MM-yyyy"));
            pc.setNgayra(XDate.toDate(ngaychuoc, "dd-MM-yyyy"));
            pc.setStatus("Đang cầm");
            pc.setPhantram(phantram);
            pc.setUser(SessionManager.getCurrentUser());
            pc.setPhantramlai(ls);
            pc.setIsActive(Boolean.TRUE);
            
            if (MsgBox.comfirm(this, "Bạn chắc chắn các thông tin sau là chính xác ?")) {
                Phieucam phieucam = phieuCamDao.addPhieu(pc);
                if (phieucam != null) {
                    MsgBox.alert(this, "Thêm biên lai thành công !");
                    fillTable();
                    MainFrame.generalTotal();
                    historyDao.addHistory(SessionManager.getCurrentUser(), "Thêm biên lai");
                    dispose();
                }
            }
        }
    }
    
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        chooserData1 = new com.raven.datechooser.DateChooser();
        chooserData2 = new com.raven.datechooser.DateChooser();
        jPanel1 = new javax.swing.JPanel();
        jPanel2 = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        txtFullname = new javax.swing.JTextField();
        jLabel3 = new javax.swing.JLabel();
        txtPhonenumber = new javax.swing.JTextField();
        jPanel3 = new javax.swing.JPanel();
        jLabel4 = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        txtBienso = new javax.swing.JTextField();
        jPanel4 = new javax.swing.JPanel();
        jLabel6 = new javax.swing.JLabel();
        jLabel7 = new javax.swing.JLabel();
        txtMaphieu = new javax.swing.JTextField();
        jLabel9 = new javax.swing.JLabel();
        jLabel10 = new javax.swing.JLabel();
        txtSotien = new javax.swing.JTextField();
        jLabel11 = new javax.swing.JLabel();
        jPanel5 = new javax.swing.JPanel();
        jPanel6 = new javax.swing.JPanel();
        txtPhantram = new javax.swing.JTextField();
        jLabel12 = new javax.swing.JLabel();
        txtTongtienthang = new javax.swing.JTextField();
        jLabel13 = new javax.swing.JLabel();
        txtDate1 = new javax.swing.JTextField();
        txtDate2 = new javax.swing.JTextField();
        btnShowDate1 = new javax.swing.JButton();
        btnShowDate2 = new javax.swing.JButton();
        jPanel7 = new javax.swing.JPanel();
        btnAdd = new javax.swing.JButton();
        btnExit = new javax.swing.JButton();
        btnEditAndPrint = new javax.swing.JButton();
        btnAdd1 = new javax.swing.JButton();

        chooserData1.setTextRefernce(txtDate1);

        chooserData2.setTextRefernce(txtDate2);

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setTitle("Thêm Biên Lai Cầm Xe");

        jPanel1.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Thông tin biên lai cầm xe", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Segoe UI", 0, 14))); // NOI18N

        jLabel1.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        jLabel1.setText("KHÁCH HÀNG");

        jLabel2.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel2.setText("Tên khách hàng");

        txtFullname.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N

        jLabel3.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel3.setText("Số điện thoại");

        txtPhonenumber.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(jLabel1)
                        .addGap(0, 0, Short.MAX_VALUE))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(6, 6, 6)
                        .addComponent(jLabel2)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(txtFullname, javax.swing.GroupLayout.PREFERRED_SIZE, 240, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(52, 52, 52)
                        .addComponent(jLabel3)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(txtPhonenumber)))
                .addContainerGap())
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel1)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                        .addComponent(txtFullname)
                        .addComponent(jLabel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                    .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(txtPhonenumber, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(18, Short.MAX_VALUE))
        );

        jLabel4.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        jLabel4.setText("THÔNG TIN TÀI SẢN");

        jLabel5.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel5.setText("Biển số xe ");

        txtBienso.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N

        javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel4)
                    .addGroup(jPanel3Layout.createSequentialGroup()
                        .addGap(6, 6, 6)
                        .addComponent(jLabel5)
                        .addGap(44, 44, 44)
                        .addComponent(txtBienso, javax.swing.GroupLayout.PREFERRED_SIZE, 239, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(387, Short.MAX_VALUE))
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel4)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel5, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(txtBienso))
                .addContainerGap(18, Short.MAX_VALUE))
        );

        jLabel6.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        jLabel6.setText("THÔNG TIN CẦM CỐ");

        jLabel7.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel7.setText("Mã biên lai");

        txtMaphieu.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N

        jLabel9.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel9.setText("Tính từ ngày");

        jLabel10.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel10.setText("Số tiền");

        txtSotien.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        txtSotien.addFocusListener(new java.awt.event.FocusAdapter() {
            public void focusLost(java.awt.event.FocusEvent evt) {
                txtSotienFocusLost(evt);
            }
        });
        txtSotien.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                txtSotienKeyReleased(evt);
            }
        });

        jLabel11.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel11.setText("Đến ngày");

        jPanel5.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Tính lãi suất", javax.swing.border.TitledBorder.CENTER, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Segoe UI", 1, 14))); // NOI18N

        txtPhantram.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N

        jLabel12.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel12.setText("Lãi xuất (%) tháng");

        txtTongtienthang.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N

        jLabel13.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        jLabel13.setText("%");

        javax.swing.GroupLayout jPanel6Layout = new javax.swing.GroupLayout(jPanel6);
        jPanel6.setLayout(jPanel6Layout);
        jPanel6Layout.setHorizontalGroup(
            jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel6Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel12)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(txtPhantram, javax.swing.GroupLayout.PREFERRED_SIZE, 110, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(7, 7, 7)
                .addComponent(jLabel13)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(txtTongtienthang, javax.swing.GroupLayout.PREFERRED_SIZE, 127, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel6Layout.setVerticalGroup(
            jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel6Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel12, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(txtPhantram)
                    .addComponent(txtTongtienthang)
                    .addComponent(jLabel13, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(50, 50, 50))
        );

        javax.swing.GroupLayout jPanel5Layout = new javax.swing.GroupLayout(jPanel5);
        jPanel5.setLayout(jPanel5Layout);
        jPanel5Layout.setHorizontalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel6, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );
        jPanel5Layout.setVerticalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel5Layout.createSequentialGroup()
                .addComponent(jPanel6, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        txtDate1.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N

        txtDate2.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N

        btnShowDate1.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnShowDate1.setText("...");
        btnShowDate1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnShowDate1ActionPerformed(evt);
            }
        });

        btnShowDate2.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnShowDate2.setText("...");
        btnShowDate2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnShowDate2ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGap(6, 6, 6)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel10, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(jLabel7, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(jLabel11, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(jLabel9, javax.swing.GroupLayout.Alignment.TRAILING))
                        .addGap(31, 31, 31)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(txtSotien, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, 215, Short.MAX_VALUE)
                            .addComponent(txtMaphieu, javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(javax.swing.GroupLayout.Alignment.LEADING, jPanel4Layout.createSequentialGroup()
                                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(txtDate1)
                                    .addComponent(txtDate2))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(btnShowDate1)
                                    .addComponent(btnShowDate2))))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jPanel5, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addComponent(jLabel6)
                        .addGap(0, 0, Short.MAX_VALUE)))
                .addContainerGap())
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel6)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel7, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(txtMaphieu))
                        .addGap(10, 10, 10)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel10, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(txtSotien))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel9, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(txtDate1)
                            .addComponent(btnShowDate1))
                        .addGap(9, 9, 9)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel11, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(txtDate2)
                            .addComponent(btnShowDate2)))
                    .addComponent(jPanel5, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(11, 11, 11))
        );

        btnAdd.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnAdd.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icon/Add.png"))); // NOI18N
        btnAdd.setText("Thêm mới");
        btnAdd.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnAddActionPerformed(evt);
            }
        });

        btnExit.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnExit.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icon/Delete.png"))); // NOI18N
        btnExit.setText("Thoát");
        btnExit.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnExitActionPerformed(evt);
            }
        });

        btnEditAndPrint.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnEditAndPrint.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icon/Save as.png"))); // NOI18N
        btnEditAndPrint.setText("Thêm và in");
        btnEditAndPrint.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnEditAndPrintActionPerformed(evt);
            }
        });

        btnAdd1.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnAdd1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icon/Refresh.png"))); // NOI18N
        btnAdd1.setText("Mặc định");
        btnAdd1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnAdd1ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel7Layout = new javax.swing.GroupLayout(jPanel7);
        jPanel7.setLayout(jPanel7Layout);
        jPanel7Layout.setHorizontalGroup(
            jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel7Layout.createSequentialGroup()
                .addGap(121, 121, 121)
                .addComponent(btnAdd)
                .addGap(18, 18, 18)
                .addComponent(btnEditAndPrint)
                .addGap(18, 18, 18)
                .addComponent(btnAdd1)
                .addGap(18, 18, 18)
                .addComponent(btnExit)
                .addContainerGap(120, Short.MAX_VALUE))
        );
        jPanel7Layout.setVerticalGroup(
            jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel7Layout.createSequentialGroup()
                .addContainerGap(23, Short.MAX_VALUE)
                .addGroup(jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btnExit)
                    .addComponent(btnAdd)
                    .addComponent(btnEditAndPrint)
                    .addComponent(btnAdd1))
                .addGap(18, 18, 18))
        );

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel3, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(jPanel4, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(jPanel7, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(9, 9, 9)
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 0, Short.MAX_VALUE)
                .addComponent(jPanel7, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );

        pack();
        setLocationRelativeTo(null);
    }// </editor-fold>//GEN-END:initComponents

    private void btnAddActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnAddActionPerformed
        if (check()) {
            addPhieu();
        }
    }//GEN-LAST:event_btnAddActionPerformed

    private void btnExitActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnExitActionPerformed
        dispose();
    }//GEN-LAST:event_btnExitActionPerformed

    private void btnEditAndPrintActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnEditAndPrintActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_btnEditAndPrintActionPerformed

    private void txtSotienFocusLost(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_txtSotienFocusLost
        XMoney.formatCurrency(txtSotien);
    }//GEN-LAST:event_txtSotienFocusLost

    private void txtSotienKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_txtSotienKeyReleased
        XMoney.formatCurrency(txtSotien);
    }//GEN-LAST:event_txtSotienKeyReleased

    private void btnShowDate2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnShowDate2ActionPerformed
        chooserData2.showPopup();
    }//GEN-LAST:event_btnShowDate2ActionPerformed

    private void btnShowDate1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnShowDate1ActionPerformed
        chooserData1.showPopup();
    }//GEN-LAST:event_btnShowDate1ActionPerformed

    private void btnAdd1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnAdd1ActionPerformed
        refeshForm();
    }//GEN-LAST:event_btnAdd1ActionPerformed
    
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Windows".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(AddTaiSan.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(AddTaiSan.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(AddTaiSan.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(AddTaiSan.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the dialog */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                AddTaiSan dialog = new AddTaiSan(new javax.swing.JFrame(), true);
                dialog.addWindowListener(new java.awt.event.WindowAdapter() {
                    @Override
                    public void windowClosing(java.awt.event.WindowEvent e) {
                        System.exit(0);
                    }
                });
                dialog.setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnAdd;
    private javax.swing.JButton btnAdd1;
    private javax.swing.JButton btnEditAndPrint;
    private javax.swing.JButton btnExit;
    private javax.swing.JButton btnShowDate1;
    private javax.swing.JButton btnShowDate2;
    private com.raven.datechooser.DateChooser chooserData1;
    private com.raven.datechooser.DateChooser chooserData2;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel13;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JPanel jPanel6;
    private javax.swing.JPanel jPanel7;
    private javax.swing.JTextField txtBienso;
    private javax.swing.JTextField txtDate1;
    private javax.swing.JTextField txtDate2;
    private javax.swing.JTextField txtFullname;
    private javax.swing.JTextField txtMaphieu;
    private javax.swing.JTextField txtPhantram;
    private javax.swing.JTextField txtPhonenumber;
    private javax.swing.JTextField txtSotien;
    private javax.swing.JTextField txtTongtienthang;
    // End of variables declaration//GEN-END:variables
}
