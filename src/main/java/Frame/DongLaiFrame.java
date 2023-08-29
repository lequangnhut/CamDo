package Frame;

import DAO.CustomerDao;
import DAO.DonglaiDao;
import DAO.PhieuCamDao;
import Entity.Customer;
import Entity.Donglai;
import Entity.Phieucam;
import Utils.UtilsFrame;
import static Frame.MainFrame.tblDanhsach;
import Utils.MsgBox;
import Utils.XDate;
import Utils.XMoney;
import com.raven.datechooser.SelectedAction;
import com.raven.datechooser.SelectedDate;
import java.sql.Timestamp;
import java.util.List;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author NHUTLQ
 */
public final class DongLaiFrame extends javax.swing.JDialog {
    
    private final PhieuCamDao phieuCamDao = new PhieuCamDao();
    private final CustomerDao customerDao = new CustomerDao();
    private final DonglaiDao donglaiDao = new DonglaiDao();
    
    private int row;
    
    public DongLaiFrame(java.awt.Frame parent, boolean modal) {
        super(parent, modal);
        initComponents();
        init();
    }
    
    public void init() {
        setTitle();
        setDisableText();
        fillFormDonglai();
        showDataChooser();
        
        UtilsFrame.boldTableHeader(tblDonglai);
        UtilsFrame.applyStripedRowRendering(tblDonglai);
    }
    
    private void setTitle() {
        int a = tblDanhsach.getSelectedRow();
        String fullname = (String) tblDanhsach.getValueAt(a, 2);
        
        setTitle("Đóng lãi & gia hạn khách hàng - " + fullname);
    }
    
    private void setDisableText() {
        txtMalai.setEditable(false);
        txtFullname.setEditable(false);
        txtShowDate2.setEditable(false);
        txtShowDate1.setEditable(false);
        txtTungay.setEditable(false);
        txtTiendonglai.setEditable(false);
    }
    
    private void showDataChooser() {
        chooserDate1.addEventDateChooser((SelectedAction action, SelectedDate date) -> {
            if (action.getAction() == SelectedAction.DAY_SELECTED) {
                chooserDate1.hidePopup();
            }
        });
        
        chooseDate3.addEventDateChooser((SelectedAction action, SelectedDate date) -> {
            if (action.getAction() == SelectedAction.DAY_SELECTED) {
                chooseDate3.hidePopup();
            }
        });
    }
    
    private void fillFormDonglai() {
        int a = tblDanhsach.getSelectedRow();
        if (a < 0) {
            return;
        }
        
        String maphieu = (String) tblDanhsach.getValueAt(a, 1);
        Phieucam pc = phieuCamDao.findByMaPhieu(maphieu);
        
        if (pc != null) {
            txtMalai.setText(pc.getMaphieu());
            txtFullname.setText(pc.getCustomer().getFullname());
            txtShowDate1.setText(XDate.curentDate());
            txtTiendonglai.setText(XMoney.formatMoney(pc.getTienlai()));
            txtTungay.setText(XDate.toString(pc.getNgayvao(), "dd-MM-yyyy"));
            txtShowDate2.setText(XDate.toString(pc.getNgayra(), "dd-MM-yyyy"));
//          -------------------
            lblBienso.setText(pc.getBienso());
            lblStatus.setText(pc.getStatus());
            lblDatestart.setText(XDate.toString(pc.getNgayvao(), "dd-MM-yyyy"));
            lblDateend.setText(XDate.toString(pc.getNgayra(), "dd-MM-yyyy"));
            lblTiengoc.setText(XMoney.formatMoney(pc.getTiengoc()));
            lblTonglai.setText(XMoney.formatMoney(pc.getTienlai()));
            lblPhantram.setText(String.valueOf(pc.getPhantram()) + "%");
            
            fillTableDongLai();
        }
    }
    
    private void fillTableDongLai() {
        int i = 1;
        
        DefaultTableModel model = (DefaultTableModel) tblDonglai.getModel();
        model.setRowCount(0);
        
        UtilsFrame.scrollEndTable(tblDonglai);
        
        String fullname = txtFullname.getText();
        Customer cus = customerDao.findByFullname(fullname);
        
        List<Donglai> donglai = donglaiDao.findByMaKHId(cus.getId());
        
        if (donglai != null) {
            for (Donglai dl : donglai) {
                Object[] row = {
                    String.valueOf(i++),
                    XDate.toString(dl.getNgaydonglai(), "dd-MM-yyyy HH:mm:ss"),
                    XMoney.formatMoney(dl.getTiendonglai()),
                    XDate.toString(dl.getPhieucam().getNgayvao(), "dd-MM-yyyy"),
                    XDate.toString(dl.getPhieucam().getNgayra(), "dd-MM-yyyy"),
                    dl.getStatus()
                };
                model.addRow(row);
            }
        }
    }
    
    private void addDonglai() {
        int a = tblDanhsach.getSelectedRow();
        
        String originalPrice = txtTiendonglai.getText();
        String cleanedString = originalPrice.replaceAll("[^0-9.]", "");
        cleanedString = cleanedString.replace(".", ""); // Loại bỏ dấu "."
        int parsedPrice = Integer.parseInt(cleanedString);
        
        String maphieu = txtMalai.getText();
        String fullname = (String) tblDanhsach.getValueAt(a, 2);
        
        Phieucam pc = phieuCamDao.findByMaPhieu(maphieu);
        Customer cus = customerDao.findByFullname(fullname);
        
        if (pc != null && cus != null) {
            Donglai dl = new Donglai();
            dl.setCustomer(cus);
            dl.setPhieucam(pc);
            dl.setNgaydonglai(new Timestamp(System.currentTimeMillis()));
            dl.setTiendonglai(parsedPrice);
            dl.setStatus(lblStatus.getText());
            dl.setIsActive(Boolean.TRUE);
            
            Donglai dlai = donglaiDao.createdl(dl);
            if (dlai != null) {
                fillTableDongLai();
                MsgBox.alert(this, "Đóng lãi " + originalPrice + " cho khách hàng " + fullname + " thành công !");
            }
        }
    }
    
    private void delDonglai(){
        
    }
    
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        chooserDate1 = new com.raven.datechooser.DateChooser();
        chooseDate3 = new com.raven.datechooser.DateChooser();
        jPanel1 = new javax.swing.JPanel();
        jPanel2 = new javax.swing.JPanel();
        jLabel2 = new javax.swing.JLabel();
        txtMalai = new javax.swing.JTextField();
        jLabel3 = new javax.swing.JLabel();
        txtShowDate1 = new javax.swing.JTextField();
        jLabel4 = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        txtTiendonglai = new javax.swing.JTextField();
        txtTungay = new javax.swing.JTextField();
        txtShowDate2 = new javax.swing.JTextField();
        btnShow1 = new javax.swing.JButton();
        jLabel8 = new javax.swing.JLabel();
        txtFullname = new javax.swing.JTextField();
        jPanel3 = new javax.swing.JPanel();
        jLabel10 = new javax.swing.JLabel();
        lblBienso = new javax.swing.JLabel();
        jLabel12 = new javax.swing.JLabel();
        lblStatus = new javax.swing.JLabel();
        jLabel14 = new javax.swing.JLabel();
        lblDatestart = new javax.swing.JLabel();
        jLabel16 = new javax.swing.JLabel();
        lblTiengoc = new javax.swing.JLabel();
        lblPhantram = new javax.swing.JLabel();
        lblTonglai = new javax.swing.JLabel();
        jLabel22 = new javax.swing.JLabel();
        lblDateend = new javax.swing.JLabel();
        jLabel23 = new javax.swing.JLabel();
        jSeparator1 = new javax.swing.JSeparator();
        jLabel24 = new javax.swing.JLabel();
        jScrollPane1 = new javax.swing.JScrollPane();
        tblDonglai = new javax.swing.JTable();
        jPanel4 = new javax.swing.JPanel();
        btnAdd = new javax.swing.JButton();
        btnExit = new javax.swing.JButton();
        jButton1 = new javax.swing.JButton();

        chooserDate1.setTextRefernce(txtShowDate1);

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setTitle("Thông tin đóng lãi ");

        jPanel2.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Thông tin người đóng lãi", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Segoe UI", 1, 12))); // NOI18N

        jLabel2.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel2.setText("Mã biên lai:");

        txtMalai.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N

        jLabel3.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel3.setText("Ngày đóng lãi:");

        txtShowDate1.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N

        jLabel4.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel4.setText("Số tiền đóng lãi:");

        jLabel5.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel5.setText("Từ ngày:");

        jLabel6.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel6.setText("Đến ngày:");

        txtTiendonglai.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N

        txtTungay.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N

        txtShowDate2.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N

        btnShow1.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnShow1.setText("...");
        btnShow1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnShow1ActionPerformed(evt);
            }
        });

        jLabel8.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel8.setText("Họ và tên:");

        txtFullname.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel2)
                    .addComponent(jLabel3)
                    .addComponent(jLabel4)
                    .addComponent(jLabel5)
                    .addComponent(jLabel6)
                    .addComponent(jLabel8))
                .addGap(50, 50, 50)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(txtFullname)
                    .addComponent(txtTungay)
                    .addComponent(txtTiendonglai, javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                        .addComponent(txtShowDate1, javax.swing.GroupLayout.DEFAULT_SIZE, 279, Short.MAX_VALUE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(btnShow1))
                    .addComponent(txtMalai, javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(txtShowDate2))
                .addContainerGap())
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGap(12, 12, 12)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(txtMalai)
                    .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(txtFullname)
                    .addComponent(jLabel8, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel5, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(txtTungay))
                .addGap(6, 6, 6)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel6, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(txtShowDate2))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(txtShowDate1)
                    .addComponent(btnShow1))
                .addGap(5, 5, 5)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel4, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(txtTiendonglai))
                .addGap(20, 20, 20))
        );

        jPanel3.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Thông tin cầm đồ", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Segoe UI", 1, 12))); // NOI18N
        jPanel3.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jLabel10.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel10.setText("Tài sản cầm:");
        jPanel3.add(jLabel10, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 30, 80, 30));

        lblBienso.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        lblBienso.setText("Biển số ");
        jPanel3.add(lblBienso, new org.netbeans.lib.awtextra.AbsoluteConstraints(90, 30, 100, 30));

        jLabel12.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel12.setText("Trạng thái:");
        jPanel3.add(jLabel12, new org.netbeans.lib.awtextra.AbsoluteConstraints(270, 30, 70, 30));

        lblStatus.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        lblStatus.setForeground(new java.awt.Color(0, 0, 204));
        lblStatus.setText("Quá hạn 30 ngày");
        jPanel3.add(lblStatus, new org.netbeans.lib.awtextra.AbsoluteConstraints(340, 30, 150, 30));

        jLabel14.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel14.setText("Ngày cầm:");
        jPanel3.add(jLabel14, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 70, 70, 30));

        lblDatestart.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        lblDatestart.setText("05/10/2017");
        jPanel3.add(lblDatestart, new org.netbeans.lib.awtextra.AbsoluteConstraints(90, 70, 80, 30));

        jLabel16.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel16.setText("Tiền gốc:");
        jPanel3.add(jLabel16, new org.netbeans.lib.awtextra.AbsoluteConstraints(270, 70, 70, 30));

        lblTiengoc.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        lblTiengoc.setForeground(new java.awt.Color(204, 0, 51));
        lblTiengoc.setText("2.500.000 VNĐ");
        jPanel3.add(lblTiengoc, new org.netbeans.lib.awtextra.AbsoluteConstraints(340, 70, 160, 30));

        lblPhantram.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        lblPhantram.setForeground(new java.awt.Color(204, 0, 51));
        lblPhantram.setText("6%");
        jPanel3.add(lblPhantram, new org.netbeans.lib.awtextra.AbsoluteConstraints(410, 110, 50, 30));

        lblTonglai.setFont(new java.awt.Font("Segoe UI", 1, 24)); // NOI18N
        lblTonglai.setForeground(new java.awt.Color(204, 0, 51));
        lblTonglai.setText("23.000.000 VNĐ");
        jPanel3.add(lblTonglai, new org.netbeans.lib.awtextra.AbsoluteConstraints(270, 160, 220, 30));

        jLabel22.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel22.setText("Hết hạn:");
        jPanel3.add(jLabel22, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 110, 70, 30));

        lblDateend.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        lblDateend.setText("05/10/2017");
        jPanel3.add(lblDateend, new org.netbeans.lib.awtextra.AbsoluteConstraints(90, 110, 80, 30));

        jLabel23.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel23.setText("Phần Trăm Lãi suất:");
        jPanel3.add(jLabel23, new org.netbeans.lib.awtextra.AbsoluteConstraints(270, 110, 130, 30));

        jSeparator1.setForeground(new java.awt.Color(0, 0, 0));
        jPanel3.add(jSeparator1, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 150, 480, 10));

        jLabel24.setFont(new java.awt.Font("Segoe UI", 1, 24)); // NOI18N
        jLabel24.setText("Tổng Lãi Suất:");
        jPanel3.add(jLabel24, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 160, 170, 30));

        tblDonglai.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        tblDonglai.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null, null, null},
                {null, null, null, null, null, null},
                {null, null, null, null, null, null},
                {null, null, null, null, null, null}
            },
            new String [] {
                "STT", "Ngày đóng tiền", "Số tiền", "Từ ngày", "Đến ngày (hết hạn)", "Trạng thái"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, false, false, false, false, true
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        tblDonglai.setRowHeight(30);
        tblDonglai.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                tblDonglaiMouseClicked(evt);
            }
        });
        jScrollPane1.setViewportView(tblDonglai);

        jPanel4.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Thao tác", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Segoe UI", 1, 12))); // NOI18N

        btnAdd.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnAdd.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icon/Add.png"))); // NOI18N
        btnAdd.setText("Thêm mới");
        btnAdd.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnAddActionPerformed(evt);
            }
        });

        btnExit.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnExit.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icon/Stop.png"))); // NOI18N
        btnExit.setText("Thoát");
        btnExit.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnExitActionPerformed(evt);
            }
        });

        jButton1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icon/Delete.png"))); // NOI18N
        jButton1.setText("Xoá");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                .addContainerGap(71, Short.MAX_VALUE)
                .addComponent(btnAdd)
                .addGap(20, 20, 20)
                .addComponent(jButton1)
                .addGap(20, 20, 20)
                .addComponent(btnExit)
                .addGap(71, 71, 71))
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(btnExit)
                .addContainerGap())
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(btnAdd, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jButton1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jScrollPane1)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jPanel4, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jPanel3, javax.swing.GroupLayout.PREFERRED_SIZE, 500, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap())
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jPanel3, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 205, Short.MAX_VALUE)
                .addContainerGap())
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGap(0, 0, 0))
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

    private void btnShow1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnShow1ActionPerformed
        chooserDate1.showPopup();
    }//GEN-LAST:event_btnShow1ActionPerformed

    private void btnAddActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnAddActionPerformed
        addDonglai();
    }//GEN-LAST:event_btnAddActionPerformed

    private void tblDonglaiMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_tblDonglaiMouseClicked
        this.row = tblDonglai.getSelectedRow();
    }//GEN-LAST:event_tblDonglaiMouseClicked

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        delDonglai();
    }//GEN-LAST:event_jButton1ActionPerformed
    
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
            java.util.logging.Logger.getLogger(DongLaiFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(DongLaiFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(DongLaiFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(DongLaiFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the dialog */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                DongLaiFrame dialog = new DongLaiFrame(new javax.swing.JFrame(), true);
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
    private javax.swing.JButton btnExit;
    private javax.swing.JButton btnShow1;
    private com.raven.datechooser.DateChooser chooseDate3;
    private com.raven.datechooser.DateChooser chooserDate1;
    private javax.swing.JButton jButton1;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel14;
    private javax.swing.JLabel jLabel16;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel22;
    private javax.swing.JLabel jLabel23;
    private javax.swing.JLabel jLabel24;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JSeparator jSeparator1;
    private javax.swing.JLabel lblBienso;
    private javax.swing.JLabel lblDateend;
    private javax.swing.JLabel lblDatestart;
    private javax.swing.JLabel lblPhantram;
    private javax.swing.JLabel lblStatus;
    private javax.swing.JLabel lblTiengoc;
    private javax.swing.JLabel lblTonglai;
    private javax.swing.JTable tblDonglai;
    public static javax.swing.JTextField txtFullname;
    public static javax.swing.JTextField txtMalai;
    public static javax.swing.JTextField txtShowDate1;
    public static javax.swing.JTextField txtShowDate2;
    public static javax.swing.JTextField txtTiendonglai;
    public static javax.swing.JTextField txtTungay;
    // End of variables declaration//GEN-END:variables
}
