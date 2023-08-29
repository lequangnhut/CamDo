package Frame;

import DAO.HistoryDao;
import DAO.PhantramlaiDao;
import DAO.PhieuCamDao;
import DAO.UserDao;
import Entity.Phantramlai;
import Entity.Phieucam;
import Entity.User;
import Utils.Clock;
import Utils.MsgBox;
import Utils.SessionManager;
import Utils.UtilsFrame;
import Utils.XDate;
import Utils.XMoney;
import com.raven.datechooser.SelectedAction;
import com.raven.datechooser.SelectedDate;
import java.awt.Toolkit;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.swing.JFrame;
import javax.swing.table.DefaultTableModel;

/**
 * @author NHUTLQ
 */
public class MainFrame extends JFrame {

    public static final PhieuCamDao phieuCamDao = new PhieuCamDao();
    private final PhantramlaiDao laisuatDao = new PhantramlaiDao();
    private final UserDao userDao = new UserDao();
    private final HistoryDao historyDao = new HistoryDao();

    private int row = -1;

    public MainFrame() {
        initComponents();
        init();
    }

    private void init() {
        initClock();
        initDate();
        fillTable();
        generalTotal();
        security();
        showDataChooser();

        UtilsFrame.scrollEndTable(tblDanhsach);
        UtilsFrame.boldTableHeader(tblDanhsach);
        UtilsFrame.applyStripedRowRendering(tblDanhsach);

        setIconImage(Toolkit.getDefaultToolkit().getImage(MainFrame.class.getResource("/Icon/logo.png")));
    }

    private void initClock() {
        Clock th = new Clock(lblClock);
        th = new Clock(lblClock);
        th.start();
    }

    private void initDate() {
        LocalDate date = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        String formattedDate = date.format(formatter);
        String str = "| " + formattedDate;
        lblDate.setText(str);
    }

    private User user() {
        User user = userDao.findUserByUsername(LoginForm.txtUser.getText());
        return user;
    }

    private void showDataChooser() {
        chooseDataByDateStrart.addEventDateChooser((SelectedAction action, SelectedDate date) -> {
            if (action.getAction() == SelectedAction.DAY_SELECTED) {
                chooseDataByDateStrart.hidePopup();
            }
        });

        chooseDataByDateEnd.addEventDateChooser((SelectedAction action, SelectedDate date) -> {
            if (action.getAction() == SelectedAction.DAY_SELECTED) {
                chooseDataByDateEnd.hidePopup();
            }
        });
    }

    private void security() {
        if (user().getIsAdmin()) {
            btnBaoCao.setVisible(true);
            btnBaoCao1.setVisible(true);
        } else {
            btnBaoCao.setVisible(false);
            btnBaoCao1.setVisible(false);
        }
    }

    private void fillTable() {
        int i = 1;

        DefaultTableModel model = (DefaultTableModel) tblDanhsach.getModel();
        model.setRowCount(0);

        UtilsFrame.scrollEndTable(tblDanhsach);
        UtilsFrame.checkAndUpdateStatus();

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

    private void findPhieucam() {
        int i = 1;

        DefaultTableModel model = (DefaultTableModel) tblDanhsach.getModel();
        model.setRowCount(0);

        String keywork = txtFind.getText();
        List<Phieucam> phieucam = phieuCamDao.findPhieucam(keywork, keywork, keywork, keywork);

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

    private void refeshTable() {
        txtFind.setText("");
        fillTable();
    }

    private void updatePhantramLS() {
        String phantramLS = cboPhantramls.getSelectedItem().toString();
        String numberPart = phantramLS.replace("%", "");
        int number = Integer.parseInt(numberPart);

        Phantramlai ls = laisuatDao.update(number);
        if (ls != null) {
            MsgBox.alert(this, "Thay đổi phần trăm lãi suất thành công !");
        }
    }

    private void fillFormMain() {
        String maphieu = (String) tblDanhsach.getValueAt(this.row, 1);
        String date1 = (String) tblDanhsach.getValueAt(this.row, 7);
        String date2 = (String) tblDanhsach.getValueAt(this.row, 8);
        String trangthai = (String) tblDanhsach.getValueAt(this.row, 9);

        txtFind.setText(maphieu);
        txtFindDate1.setText(date1);
        txtFindDate2.setText(date2);
        cboTrangThai.setSelectedItem(trangthai);
    }

    private void checkUpEdit() {
        int a = tblDanhsach.getSelectedRow();
        if (a < 0) {
            MsgBox.alert(this, "Vui lòng chọn một biên lai để sửa !");
        } else {
            new EditTaiSan(this, true).setVisible(true);
        }
    }

    private void checkUpDelete() {
        int a = tblDanhsach.getSelectedRow();
        if (a < 0) {
            MsgBox.alert(this, "Vui lòng chọn một biên lai để xoá !");
        } else {
            deletePhieu();
        }
    }

    private void checkUpDonglai() {
        int a = tblDanhsach.getSelectedRow();
        if (a < 0) {
            MsgBox.alert(this, "Vui lòng chọn một biên lai để đóng lãi !");
        } else {
            new DongLaiFrame(this, true).setVisible(true);
        }
    }

    private void deletePhieu() {
        String maphieu = (String) tblDanhsach.getValueAt(this.row, 1);

        if (MsgBox.comfirm(this, "Bạn có chắc chắn muốn xoá mã phiếu " + maphieu + " không ?")) {
            Phieucam pc = phieuCamDao.deletePhieu(maphieu);
            if (pc != null) {
                MsgBox.alert(this, "Xoá mã phiếu " + maphieu + " thành công !");
                fillTable();
                generalTotal();
                historyDao.addHistory(user(), "Xoá biên lai");
            }
        }
    }

    public static void generalTotal() {
        LocalDate currentDate = LocalDate.now();
        int currentMonth = currentDate.getMonthValue();
        int dayOfMonth = currentDate.getDayOfMonth();

        lblTongPhieuNgay.setText(String.valueOf(phieuCamDao.findTotalPhieuTrongNgay()) + " Lai / Ngày " + dayOfMonth);
        lblTongLaiNgay.setText(XMoney.formatMoney(phieuCamDao.findTotalTienLaiTrongNgay()) + " / Ngày " + dayOfMonth);

        lblTongPhieuThang.setText(String.valueOf(phieuCamDao.findTotalPhieuTrongThang()) + " Lai / Tháng " + currentMonth);
        lblTongLaiThang.setText(XMoney.formatMoney(phieuCamDao.findTotalTienLaiTrongThang()) + " / Tháng " + currentMonth);

    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        chooseDataByDateStrart = new com.raven.datechooser.DateChooser();
        chooseDataByDateEnd = new com.raven.datechooser.DateChooser();
        jPanel1 = new javax.swing.JPanel();
        jPanel2 = new javax.swing.JPanel();
        jLabel2 = new javax.swing.JLabel();
        txtFind = new javax.swing.JTextField();
        jLabel10 = new javax.swing.JLabel();
        jLabel11 = new javax.swing.JLabel();
        cboTrangThai = new javax.swing.JComboBox<>();
        btnFind = new javax.swing.JButton();
        jLabel12 = new javax.swing.JLabel();
        txtFindDate1 = new javax.swing.JTextField();
        btnStrat = new javax.swing.JButton();
        txtFindDate2 = new javax.swing.JTextField();
        btnEnd = new javax.swing.JButton();
        jPanel3 = new javax.swing.JPanel();
        jPanel4 = new javax.swing.JPanel();
        btnEditTaiSan = new javax.swing.JButton();
        btnDonglai = new javax.swing.JButton();
        btnAddTaiSan = new javax.swing.JButton();
        btnChuocxe = new javax.swing.JButton();
        btnXoaPhieu = new javax.swing.JButton();
        btnBaoCao = new javax.swing.JButton();
        btnThoat = new javax.swing.JButton();
        btnBaoCao1 = new javax.swing.JButton();
        btnLammoi = new javax.swing.JButton();
        cboPhantramls = new javax.swing.JComboBox<>();
        jSeparator1 = new javax.swing.JSeparator();
        jScrollPane1 = new javax.swing.JScrollPane();
        tblDanhsach = new javax.swing.JTable();
        jPanel5 = new javax.swing.JPanel();
        jLabel9 = new javax.swing.JLabel();
        jLabel13 = new javax.swing.JLabel();
        jLabel14 = new javax.swing.JLabel();
        jLabel16 = new javax.swing.JLabel();
        lblTongPhieuThang = new javax.swing.JLabel();
        lblPhieudunghan = new javax.swing.JLabel();
        lblPhieutrehan = new javax.swing.JLabel();
        lblTongLaiThang = new javax.swing.JLabel();
        jLabel17 = new javax.swing.JLabel();
        jLabel15 = new javax.swing.JLabel();
        lblTongPhieuNgay = new javax.swing.JLabel();
        lblTongLaiNgay = new javax.swing.JLabel();
        lblDate = new javax.swing.JLabel();
        lblClock = new javax.swing.JLabel();
        jLabel29 = new javax.swing.JLabel();

        chooseDataByDateStrart.setTextRefernce(txtFindDate1);

        chooseDataByDateEnd.setTextRefernce(txtFindDate2);

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Quản Lý Cầm Xe");

        jPanel2.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Tìm kiếm nâng cao", javax.swing.border.TitledBorder.CENTER, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Segoe UI", 1, 14))); // NOI18N

        jLabel2.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel2.setText("Họ tên/Mã biên lai/Biển số/SĐT");

        txtFind.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        txtFind.setPreferredSize(new java.awt.Dimension(64, 31));

        jLabel10.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel10.setText("Đến ngày");

        jLabel11.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel11.setText("Trạng thái");

        cboTrangThai.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        cboTrangThai.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Đang cầm", "Đã chuộc" }));
        cboTrangThai.setPreferredSize(new java.awt.Dimension(100, 31));

        btnFind.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnFind.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icon/Search.png"))); // NOI18N
        btnFind.setText("Tìm Lai Cầm ");
        btnFind.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnFindActionPerformed(evt);
            }
        });

        jLabel12.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel12.setText("Tính từ ngày");

        txtFindDate1.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N

        btnStrat.setText("...");
        btnStrat.setPreferredSize(new java.awt.Dimension(50, 23));
        btnStrat.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnStratActionPerformed(evt);
            }
        });

        txtFindDate2.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N

        btnEnd.setText("...");
        btnEnd.setPreferredSize(new java.awt.Dimension(50, 23));
        btnEnd.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnEndActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGap(6, 6, 6)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel2)
                    .addComponent(txtFind, javax.swing.GroupLayout.PREFERRED_SIZE, 229, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(20, 20, 20)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(txtFindDate1, javax.swing.GroupLayout.PREFERRED_SIZE, 160, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(btnStrat, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jLabel12))
                .addGap(20, 20, 20)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(txtFindDate2, javax.swing.GroupLayout.PREFERRED_SIZE, 160, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(btnEnd, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jLabel10))
                .addGap(20, 20, 20)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel11)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(cboTrangThai, javax.swing.GroupLayout.PREFERRED_SIZE, 160, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(20, 20, 20)
                        .addComponent(btnFind)))
                .addContainerGap(214, Short.MAX_VALUE))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGap(6, 6, 6)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(6, 6, 6)
                        .addComponent(txtFind, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel11, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                                .addComponent(jLabel12, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addComponent(jLabel10, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(txtFindDate1)
                            .addComponent(btnStrat, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(txtFindDate2)
                            .addComponent(btnEnd, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                                .addComponent(cboTrangThai, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(btnFind)))))
                .addContainerGap(9, Short.MAX_VALUE))
        );

        jPanel3.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Danh sách phiếu cầm đồ", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Segoe UI", 1, 14))); // NOI18N

        btnEditTaiSan.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnEditTaiSan.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icon/Actions-document-edit-icon-16.png"))); // NOI18N
        btnEditTaiSan.setText("Chỉnh Sửa Lai");
        btnEditTaiSan.setPreferredSize(new java.awt.Dimension(133, 31));
        btnEditTaiSan.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnEditTaiSanActionPerformed(evt);
            }
        });

        btnDonglai.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnDonglai.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icon/open-file-icon-16.png"))); // NOI18N
        btnDonglai.setText("Đóng Lãi");
        btnDonglai.setPreferredSize(new java.awt.Dimension(105, 31));
        btnDonglai.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnDonglaiActionPerformed(evt);
            }
        });

        btnAddTaiSan.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnAddTaiSan.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icon/Add.png"))); // NOI18N
        btnAddTaiSan.setText("Thêm Biên Lai");
        btnAddTaiSan.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnAddTaiSanActionPerformed(evt);
            }
        });

        btnChuocxe.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnChuocxe.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icon/logout-icon-16.png"))); // NOI18N
        btnChuocxe.setText("Chuộc Xe");
        btnChuocxe.setPreferredSize(new java.awt.Dimension(108, 31));
        btnChuocxe.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnChuocxeActionPerformed(evt);
            }
        });

        btnXoaPhieu.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnXoaPhieu.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icon/Delete.png"))); // NOI18N
        btnXoaPhieu.setText("Xoá Biên Lai");
        btnXoaPhieu.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnXoaPhieuActionPerformed(evt);
            }
        });

        btnBaoCao.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnBaoCao.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icon/Actions-view-choose-icon-24.png"))); // NOI18N
        btnBaoCao.setText("Báo Cáo, Thống kê");
        btnBaoCao.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnBaoCaoActionPerformed(evt);
            }
        });

        btnThoat.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnThoat.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icon/Button-Close-icon-16.png"))); // NOI18N
        btnThoat.setText("Đăng Xuất");
        btnThoat.setMaximumSize(new java.awt.Dimension(115, 31));
        btnThoat.setMinimumSize(new java.awt.Dimension(115, 31));
        btnThoat.setPreferredSize(new java.awt.Dimension(115, 31));
        btnThoat.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnThoatActionPerformed(evt);
            }
        });

        btnBaoCao1.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnBaoCao1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icon/Help.png"))); // NOI18N
        btnBaoCao1.setText("Lịch Sử Hoạt Động");
        btnBaoCao1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnBaoCao1ActionPerformed(evt);
            }
        });

        btnLammoi.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnLammoi.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icon/Refresh.png"))); // NOI18N
        btnLammoi.setText("Làm mới");
        btnLammoi.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnLammoiActionPerformed(evt);
            }
        });

        cboPhantramls.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        cboPhantramls.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "5%", "6%", "7%", "8%", "9%", "10%" }));
        cboPhantramls.setToolTipText("Chọn phần trăm lãi suất");
        cboPhantramls.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cboPhantramlsActionPerformed(evt);
            }
        });

        jSeparator1.setForeground(new java.awt.Color(0, 0, 0));
        jSeparator1.setOrientation(javax.swing.SwingConstants.VERTICAL);

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(btnAddTaiSan, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(btnDonglai, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(20, 20, 20)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(btnChuocxe, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(btnEditTaiSan, javax.swing.GroupLayout.DEFAULT_SIZE, 143, Short.MAX_VALUE))
                .addGap(18, 18, 18)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(btnXoaPhieu, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(btnLammoi, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(20, 20, 20)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(btnThoat, javax.swing.GroupLayout.DEFAULT_SIZE, 123, Short.MAX_VALUE)
                    .addComponent(cboPhantramls, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(20, 20, 20)
                .addComponent(jSeparator1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(btnBaoCao1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(btnBaoCao))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE, false)
                            .addComponent(btnAddTaiSan, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(btnEditTaiSan, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(btnXoaPhieu, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(btnThoat, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                        .addGap(7, 7, 7)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(btnLammoi, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(btnDonglai, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(btnChuocxe, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(cboPhantramls, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addContainerGap())
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGap(1, 1, 1)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                                .addComponent(btnBaoCao)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(btnBaoCao1))
                            .addComponent(jSeparator1))
                        .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))))
        );

        tblDanhsach.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        tblDanhsach.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null, null, null, null, null, null, null},
                {null, null, null, null, null, null, null, null, null, null},
                {null, null, null, null, null, null, null, null, null, null},
                {null, null, null, null, null, null, null, null, null, null}
            },
            new String [] {
                "STT", "Mã biên lai", "Khách hàng", "Điện thoại", "Biển số", "Số tiền", "Tiền lãi", "Ngày cầm", "Ngày hết hạn", "Trạng thái"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, false, false, false, false, false, false, false, false, false
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        tblDanhsach.setRowHeight(30);
        tblDanhsach.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                tblDanhsachMouseClicked(evt);
            }
        });
        jScrollPane1.setViewportView(tblDanhsach);

        jPanel5.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "THÔNG TIN TỔNG QUÁT", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Segoe UI", 1, 14))); // NOI18N

        jLabel9.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel9.setText("Tổng số lai / Tháng:");

        jLabel13.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel13.setText("Số lai đúng hạn:");

        jLabel14.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel14.setText("Số lai trễ hạn:");

        jLabel16.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel16.setText("Tổng số tiền cầm / Tháng:");

        lblTongPhieuThang.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        lblTongPhieuThang.setForeground(new java.awt.Color(255, 51, 51));
        lblTongPhieuThang.setText("0");

        lblPhieudunghan.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        lblPhieudunghan.setForeground(new java.awt.Color(255, 51, 51));
        lblPhieudunghan.setText("0");

        lblPhieutrehan.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        lblPhieutrehan.setForeground(new java.awt.Color(255, 51, 51));
        lblPhieutrehan.setText("0");

        lblTongLaiThang.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        lblTongLaiThang.setForeground(new java.awt.Color(255, 51, 51));
        lblTongLaiThang.setText("0");

        jLabel17.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel17.setText("Tổng số tiền cầm / Ngày:");

        jLabel15.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel15.setText("Tổng số lai / Ngày:");

        lblTongPhieuNgay.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        lblTongPhieuNgay.setForeground(new java.awt.Color(255, 51, 51));
        lblTongPhieuNgay.setText("0");

        lblTongLaiNgay.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        lblTongLaiNgay.setForeground(new java.awt.Color(255, 51, 51));
        lblTongLaiNgay.setText("0");

        lblDate.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        lblDate.setText("10-10-2023");

        lblClock.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        lblClock.setText("23:23:23 PM");

        jLabel29.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel29.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icon/Date.png"))); // NOI18N

        javax.swing.GroupLayout jPanel5Layout = new javax.swing.GroupLayout(jPanel5);
        jPanel5.setLayout(jPanel5Layout);
        jPanel5Layout.setHorizontalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel5Layout.createSequentialGroup()
                .addGap(15, 15, 15)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jLabel15)
                    .addComponent(jLabel17))
                .addGap(20, 20, 20)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(lblTongPhieuNgay, javax.swing.GroupLayout.DEFAULT_SIZE, 150, Short.MAX_VALUE)
                    .addComponent(lblTongLaiNgay, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(50, 50, 50)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jLabel9)
                    .addComponent(jLabel16))
                .addGap(20, 20, 20)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(lblTongLaiThang, javax.swing.GroupLayout.DEFAULT_SIZE, 150, Short.MAX_VALUE)
                    .addComponent(lblTongPhieuThang, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(50, 50, 50)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jLabel13)
                    .addComponent(jLabel14))
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel5Layout.createSequentialGroup()
                        .addGap(20, 20, 20)
                        .addComponent(lblPhieutrehan, javax.swing.GroupLayout.DEFAULT_SIZE, 77, Short.MAX_VALUE)
                        .addGap(31, 31, 31)
                        .addComponent(jLabel29)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(lblClock)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(lblDate))
                    .addGroup(jPanel5Layout.createSequentialGroup()
                        .addGap(18, 18, 18)
                        .addComponent(lblPhieudunghan, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addContainerGap())
        );
        jPanel5Layout.setVerticalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel5Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(jPanel5Layout.createSequentialGroup()
                        .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(lblTongPhieuNgay, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel15, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(10, 10, 10)
                        .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(lblTongLaiNgay, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel17, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(jPanel5Layout.createSequentialGroup()
                        .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel13, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(lblPhieudunghan, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(36, 36, 36))
                    .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addComponent(jLabel29, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(lblPhieutrehan, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel14, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(lblDate, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(lblClock, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(jPanel5Layout.createSequentialGroup()
                        .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(lblTongPhieuThang, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel9, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(10, 10, 10)
                        .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(lblTongLaiThang, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel16, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE))))
                .addContainerGap(12, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addGap(6, 6, 6)
                .addComponent(jPanel4, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
            .addComponent(jPanel5, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(jScrollPane1)
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 471, Short.MAX_VALUE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel5, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
        );

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(jPanel3, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel3, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
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
    }// </editor-fold>//GEN-END:initComponents

    private void btnAddTaiSanActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnAddTaiSanActionPerformed
        new AddTaiSan(this, true).setVisible(true);
    }//GEN-LAST:event_btnAddTaiSanActionPerformed

    private void btnEditTaiSanActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnEditTaiSanActionPerformed
        checkUpEdit();
    }//GEN-LAST:event_btnEditTaiSanActionPerformed

    private void btnDonglaiActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnDonglaiActionPerformed
        checkUpDonglai();
    }//GEN-LAST:event_btnDonglaiActionPerformed

    private void btnXoaPhieuActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnXoaPhieuActionPerformed
        checkUpDelete();
    }//GEN-LAST:event_btnXoaPhieuActionPerformed

    private void btnBaoCaoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnBaoCaoActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_btnBaoCaoActionPerformed

    private void btnThoatActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnThoatActionPerformed
        if (MsgBox.comfirm(this, "Bạn có chắc chắn muốn đăng xuất không ?")) {
            new LoginForm().setVisible(true);
            SessionManager.logout();
            historyDao.addHistory(user(), "Đăng xuất");
            dispose();
        }
    }//GEN-LAST:event_btnThoatActionPerformed

    private void cboPhantramlsActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cboPhantramlsActionPerformed
        updatePhantramLS();
    }//GEN-LAST:event_cboPhantramlsActionPerformed

    private void tblDanhsachMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_tblDanhsachMouseClicked
        this.row = tblDanhsach.getSelectedRow();
        fillFormMain();
    }//GEN-LAST:event_tblDanhsachMouseClicked

    private void btnBaoCao1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnBaoCao1ActionPerformed
        new HistoryFrame(this, true).setVisible(true);
        historyDao.addHistory(user(), "Truy cập vào lịch sử hoạt động");
    }//GEN-LAST:event_btnBaoCao1ActionPerformed

    private void btnStratActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnStratActionPerformed
        chooseDataByDateStrart.showPopup();
    }//GEN-LAST:event_btnStratActionPerformed

    private void btnEndActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnEndActionPerformed
        chooseDataByDateEnd.showPopup();
    }//GEN-LAST:event_btnEndActionPerformed

    private void btnChuocxeActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnChuocxeActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_btnChuocxeActionPerformed

    private void btnLammoiActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnLammoiActionPerformed
        refeshTable();
    }//GEN-LAST:event_btnLammoiActionPerformed

    private void btnFindActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnFindActionPerformed
        findPhieucam();
    }//GEN-LAST:event_btnFindActionPerformed

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
            java.util.logging.Logger.getLogger(MainFrame.class
                    .getName()).log(java.util.logging.Level.SEVERE, null, ex);

        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(MainFrame.class
                    .getName()).log(java.util.logging.Level.SEVERE, null, ex);

        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(MainFrame.class
                    .getName()).log(java.util.logging.Level.SEVERE, null, ex);

        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(MainFrame.class
                    .getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new MainFrame().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnAddTaiSan;
    private javax.swing.JButton btnBaoCao;
    private javax.swing.JButton btnBaoCao1;
    private javax.swing.JButton btnChuocxe;
    private javax.swing.JButton btnDonglai;
    private javax.swing.JButton btnEditTaiSan;
    private javax.swing.JButton btnEnd;
    private javax.swing.JButton btnFind;
    private javax.swing.JButton btnLammoi;
    private javax.swing.JButton btnStrat;
    private javax.swing.JButton btnThoat;
    private javax.swing.JButton btnXoaPhieu;
    private javax.swing.JComboBox<String> cboPhantramls;
    private javax.swing.JComboBox<String> cboTrangThai;
    private com.raven.datechooser.DateChooser chooseDataByDateEnd;
    private com.raven.datechooser.DateChooser chooseDataByDateStrart;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel13;
    private javax.swing.JLabel jLabel14;
    private javax.swing.JLabel jLabel15;
    private javax.swing.JLabel jLabel16;
    private javax.swing.JLabel jLabel17;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel29;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JSeparator jSeparator1;
    private javax.swing.JLabel lblClock;
    private javax.swing.JLabel lblDate;
    public static javax.swing.JLabel lblPhieudunghan;
    public static javax.swing.JLabel lblPhieutrehan;
    public static javax.swing.JLabel lblTongLaiNgay;
    public static javax.swing.JLabel lblTongLaiThang;
    public static javax.swing.JLabel lblTongPhieuNgay;
    public static javax.swing.JLabel lblTongPhieuThang;
    public static javax.swing.JTable tblDanhsach;
    private javax.swing.JTextField txtFind;
    private javax.swing.JTextField txtFindDate1;
    private javax.swing.JTextField txtFindDate2;
    // End of variables declaration//GEN-END:variables
}
