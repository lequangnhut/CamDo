package Frame;

import DAO.HistoryDao;
import DAO.LaisuatDao;
import DAO.PhieuCamDao;
import Entity.Laisuat;
import Entity.Phieucam;
import static Frame.MainFrame.tblDanhsach;
import Utils.MsgBox;
import Utils.SessionManager;
import Utils.XDate;
import Utils.XMoney;
import Utils.validateInput;
import java.awt.Toolkit;
import java.util.Date;
import java.util.List;
import javax.swing.table.DefaultTableModel;

/**
 * @author NHUTLQ
 */
public final class EditTaiSan extends javax.swing.JDialog {

    private final PhieuCamDao phieuCamDao = new PhieuCamDao();
    private final LaisuatDao laisuatDao = new LaisuatDao();
    private final HistoryDao historyDao = new HistoryDao();

    public EditTaiSan(java.awt.Frame parent, boolean modal) {
        super(parent, modal);
        initComponents();
        init();
    }

    public void init() {
        txtMaphieu.setEditable(false);
        txtFullname.setEditable(false);
        txtPhantram.setEditable(false);
        txtTongtienthang.setEditable(false);
        txtDate1.setEnabled(false);
        txtDate2.setEnabled(false);

        fillFormEdit();

        validateInput.allowOnlyText(txtFullname);
        validateInput.formatPhoneNumber(txtPhonenumber);
        validateInput.autoUpperCaseWithMaxLength(txtBienso, 11);

        XMoney.caculatorLaixuat(txtSotien, txtTongtienthang);
        setIconImage(Toolkit.getDefaultToolkit().getImage(MainFrame.class.getResource("/Icon/windowbar.png")));
    }

    public boolean check() {
        String fullname = txtFullname.getText();
        String phone = txtPhonenumber.getText();
        String bienso = txtBienso.getText();
        String sotien = txtSotien.getText();
        Date ngaycam = txtDate1.getDate();
        Date ngaychuoc = txtDate2.getDate();
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
        String biensoRegex = "^[0-9]{2}[A-HJ-NP-Za-hj-np-z0-9]{2}-[0-9]{3,4}(\\.[0-9]{2})?$";
        if (!bienso.matches(biensoRegex)) {
            MsgBox.alert(this, "Biển số xe không đúng định dạng !");
            return false;
        }

        return true;
    }

    public void fillFormEdit() {
        int a = tblDanhsach.getSelectedRow();
        if (a < 0) {
            return;
        }
        String maphieu = (String) tblDanhsach.getValueAt(a, 1);
        Phieucam pc = phieuCamDao.findByMaPhieu(maphieu);

        txtPhantram.setText(String.valueOf(pc.getLaisuat().getPhantram()));
        txtFullname.setText(pc.getFullname());
        txtPhonenumber.setText(String.valueOf(pc.getPhonenumber()));
        txtBienso.setText(pc.getBienso());
        txtMaphieu.setText(pc.getMaphieu());
        txtSotien.setText(String.valueOf(XMoney.formatMoneyVIFormDB(pc.getGiacamco())));
        txtDate1.setDate(pc.getNgaycam());
        txtDate2.setDate(pc.getNgayhethan());
        txtTongtienthang.setText(String.valueOf(XMoney.formatMoneyVIFormDB(pc.getTienlai())));
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
                pc.getFullname(),
                pc.getPhonenumber(),
                pc.getBienso(),
                XMoney.formatMoney(pc.getGiacamco()),
                XMoney.formatMoney(pc.getTienlai()),
                XDate.toString(pc.getNgaycam(), "dd-MM-yyyy"),
                XDate.toString(pc.getNgayhethan(), "dd-MM-yyyy"),
                pc.getStatus()
            };
            model.addRow(row);
        }
    }

    public void editPhieu() {
        String maphieu = txtMaphieu.getText();
        String fullname = txtFullname.getText();
        String phone = txtPhonenumber.getText();
        String bienso = txtBienso.getText();
        String sotien = txtSotien.getText();
        Date ngaycam = txtDate1.getDate();
        Date ngaychuoc = txtDate2.getDate();
        String phantram = txtPhantram.getText();
        String tienlai = txtTongtienthang.getText();

        String numberString = sotien.replaceAll("[^0-9]", "");
        int sotiencam = Integer.parseInt(numberString);

        String numberString2 = tienlai.replaceAll("[^0-9]", "");
        int sotienlai = Integer.parseInt(numberString2);

        if (!maphieu.isEmpty() || !fullname.isEmpty() || !phone.isEmpty() || !bienso.isEmpty()
                || !sotien.isEmpty() || ngaycam != null || ngaychuoc != null
                || !phantram.isEmpty() || !tienlai.isEmpty()) {

            java.sql.Timestamp ngayCamTimestamp = new java.sql.Timestamp(ngaycam.getTime());
            java.sql.Timestamp ngayChuocTimestamp = new java.sql.Timestamp(ngaychuoc.getTime());

            Laisuat ls = laisuatDao.findById();
            Phieucam pc = phieuCamDao.findByMaPhieu(maphieu);

            if (pc != null) {
                pc.setMaphieu(maphieu);
                pc.setFullname(fullname);
                pc.setPhonenumber(phone);
                pc.setGiacamco(sotiencam);
                pc.setTienlai(sotienlai);
                pc.setBienso(bienso);
                pc.setNgaycam(ngayCamTimestamp);
                pc.setNgayhethan(ngayChuocTimestamp);
                pc.setStatus("Đang cầm");
                pc.setUser(SessionManager.getCurrentUser());
                pc.setLaisuat(ls);
                pc.setIsActive(Boolean.TRUE);
            }

            if (MsgBox.comfirm(this, "Bạn có chắc muốn cập nhật mã phiếu " + maphieu + " không ?")) {
                Phieucam phieucam = phieuCamDao.editPhieu(pc);
                if (phieucam != null) {
                    MsgBox.alert(this, "Cập nhật phiếu cầm thành công !");
                    fillTable();
                    MainFrame.generalTotal();
                    dispose();
                    historyDao.addHistory(SessionManager.getCurrentUser(), "Cập nhật biên lai");
                }
            }
        }
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

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
        txtDate1 = new com.toedter.calendar.JDateChooser();
        txtDate2 = new com.toedter.calendar.JDateChooser();
        jPanel5 = new javax.swing.JPanel();
        jPanel6 = new javax.swing.JPanel();
        txtPhantram = new javax.swing.JTextField();
        jLabel12 = new javax.swing.JLabel();
        txtTongtienthang = new javax.swing.JTextField();
        jLabel13 = new javax.swing.JLabel();
        jPanel7 = new javax.swing.JPanel();
        btnExit = new javax.swing.JButton();
        btnSave = new javax.swing.JButton();
        btnSaveAndPrint = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setTitle("Sửa Biên Lai Cầm Xe");

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
                    .addComponent(jLabel1)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(6, 6, 6)
                        .addComponent(jLabel2)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(txtFullname, javax.swing.GroupLayout.PREFERRED_SIZE, 190, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(jLabel3)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(txtPhonenumber, javax.swing.GroupLayout.PREFERRED_SIZE, 190, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
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
                    .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                        .addComponent(txtPhonenumber)
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
                        .addComponent(txtBienso, javax.swing.GroupLayout.PREFERRED_SIZE, 190, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
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
        jLabel9.setText(" Tính từ ngày");

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

        txtDate1.setDateFormatString("dd/MM/yyyy");
        txtDate1.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        txtDate1.setPreferredSize(new java.awt.Dimension(88, 26));

        txtDate2.setDateFormatString("dd/MM/yyyy");
        txtDate2.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        txtDate2.setPreferredSize(new java.awt.Dimension(88, 26));

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
                .addContainerGap())
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
                .addGap(30, 30, 30))
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
                .addGap(0, 0, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGap(12, 12, 12)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(jLabel10)
                            .addComponent(jLabel7)
                            .addComponent(jLabel11)
                            .addComponent(jLabel9))
                        .addGap(31, 31, 31)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                            .addComponent(txtDate2, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, 130, Short.MAX_VALUE)
                            .addComponent(txtDate1, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(txtSotien, javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(txtMaphieu, javax.swing.GroupLayout.Alignment.LEADING))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jPanel5, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jLabel6))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
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
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel9, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(txtDate1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(10, 10, 10)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel11, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(txtDate2, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addComponent(jPanel5, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(144, 144, 144))
        );

        btnExit.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnExit.setText("Thoát");
        btnExit.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnExitActionPerformed(evt);
            }
        });

        btnSave.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnSave.setText("Chỉnh sửa");
        btnSave.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnSaveActionPerformed(evt);
            }
        });

        btnSaveAndPrint.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnSaveAndPrint.setText("Lưu và in");
        btnSaveAndPrint.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnSaveAndPrintActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel7Layout = new javax.swing.GroupLayout(jPanel7);
        jPanel7.setLayout(jPanel7Layout);
        jPanel7Layout.setHorizontalGroup(
            jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel7Layout.createSequentialGroup()
                .addGap(193, 193, 193)
                .addComponent(btnSave)
                .addGap(18, 18, 18)
                .addComponent(btnSaveAndPrint)
                .addGap(18, 18, 18)
                .addComponent(btnExit, javax.swing.GroupLayout.PREFERRED_SIZE, 87, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel7Layout.setVerticalGroup(
            jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel7Layout.createSequentialGroup()
                .addContainerGap(23, Short.MAX_VALUE)
                .addGroup(jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btnExit)
                    .addComponent(btnSave)
                    .addComponent(btnSaveAndPrint))
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
                .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, 210, javax.swing.GroupLayout.PREFERRED_SIZE)
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

    private void btnExitActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnExitActionPerformed
        dispose();
    }//GEN-LAST:event_btnExitActionPerformed

    private void btnSaveActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnSaveActionPerformed
        if (check()) {
            editPhieu();
        }
    }//GEN-LAST:event_btnSaveActionPerformed

    private void btnSaveAndPrintActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnSaveAndPrintActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_btnSaveAndPrintActionPerformed

    private void txtSotienFocusLost(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_txtSotienFocusLost
        XMoney.formatCurrency(txtSotien);
    }//GEN-LAST:event_txtSotienFocusLost

    private void txtSotienKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_txtSotienKeyReleased
        XMoney.formatCurrency(txtSotien);
    }//GEN-LAST:event_txtSotienKeyReleased

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
            java.util.logging.Logger.getLogger(EditTaiSan.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(EditTaiSan.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(EditTaiSan.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(EditTaiSan.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the dialog */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                EditTaiSan dialog = new EditTaiSan(new javax.swing.JFrame(), true);
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
    private javax.swing.JButton btnExit;
    private javax.swing.JButton btnSave;
    private javax.swing.JButton btnSaveAndPrint;
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
    public static javax.swing.JTextField txtBienso;
    public static com.toedter.calendar.JDateChooser txtDate1;
    public static com.toedter.calendar.JDateChooser txtDate2;
    public static javax.swing.JTextField txtFullname;
    public static javax.swing.JTextField txtMaphieu;
    public static javax.swing.JTextField txtPhantram;
    public static javax.swing.JTextField txtPhonenumber;
    public static javax.swing.JTextField txtSotien;
    public static javax.swing.JTextField txtTongtienthang;
    // End of variables declaration//GEN-END:variables
}
