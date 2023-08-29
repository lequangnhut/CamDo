package Utils;

import java.awt.Color;
import java.awt.Component;
import java.awt.Font;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.font.TextAttribute;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.JTableHeader;

import DAO.PhieuCamDao;
import Entity.Phieucam;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JComboBox;
import javax.swing.SwingUtilities;

/**
 *
 * @author NHUTLQ
 */
public class UtilsFrame {

    public static final PhieuCamDao phieuCamDao = new PhieuCamDao();

//  in đậm header table
    public static void boldTableHeader(JTable table) {
        JTableHeader header = table.getTableHeader();
        DefaultTableCellRenderer headerRenderer = (DefaultTableCellRenderer) header.getDefaultRenderer();
        headerRenderer.setHorizontalAlignment(JLabel.CENTER);

        Font originalFont = header.getFont();
        Map<TextAttribute, Object> attributes = new HashMap<>(originalFont.getAttributes());
        attributes.put(TextAttribute.WEIGHT, TextAttribute.WEIGHT_BOLD);
        attributes.put(TextAttribute.SIZE, 14);
        Font boldFont = new Font(attributes);
        header.setFont(boldFont);
    }

//  hover và kẻ sọc của bảng
    public static void setHoverAndStripedEffects(JTable table) {
        JTableHeader header = table.getTableHeader();
        header.setReorderingAllowed(false);

        table.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseEntered(MouseEvent e) {
                int row = table.rowAtPoint(e.getPoint());
                table.setRowSelectionInterval(row, row);
            }

            @Override
            public void mouseExited(MouseEvent e) {
                table.clearSelection();
            }
        });
    }

    public static void applyStripedRowRendering(JTable table) {
        DefaultTableCellRenderer renderer = new DefaultTableCellRenderer() {
            @Override
            public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected,
                    boolean hasFocus, int row, int column) {
                Component c = super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);

                if (!isSelected) {
                    if (row % 2 == 0) {
                        c.setBackground(Color.WHITE);
                    } else {
                        c.setBackground(new Color(240, 240, 240));
                    }
                }

                return c;
            }
        };

        for (int i = 0; i < table.getColumnCount(); i++) {
            table.getColumnModel().getColumn(i).setCellRenderer(renderer);
        }
    }

//  update trạng thái khi truy cập theo ngày
    public static void checkAndUpdateStatus() {
        List<Phieucam> phieucam = phieuCamDao.findAll();
        LocalDate currentDate = LocalDate.now();

        for (Phieucam pc : phieucam) {
            Instant instant = pc.getNgayra().toInstant();
            LocalDate ngayHetHanLocalDate = instant.atZone(ZoneId.systemDefault()).toLocalDate();

            long daysUntilExpiration = ChronoUnit.DAYS.between(currentDate, ngayHetHanLocalDate);
            System.out.println(daysUntilExpiration);
            if (daysUntilExpiration < 0) {
                pc.setStatus("Quá hạn " + Math.abs(daysUntilExpiration) + " ngày");
                phieuCamDao.update(pc);
            } else {
                pc.setStatus("Đang cầm");
                phieuCamDao.update(pc);
            }
        }
    }

//  fill cbobox theo tháng năm hiện tại
    public static void fillGetMothYearToCbo(JComboBox<String> comboBox) {
        Calendar calendar = Calendar.getInstance();
        int currentYear = calendar.get(Calendar.YEAR);
        int currentMonth = calendar.get(Calendar.MONTH);

        SimpleDateFormat dateFormat = new SimpleDateFormat("MM-yyyy");

        List<String> monthYearList = new ArrayList<>();
        for (int month = 0; month < 12; month++) {
            calendar.set(currentYear, month, 1);
            String formattedDate = dateFormat.format(calendar.getTime());
            monthYearList.add(formattedDate);
        }

        DefaultComboBoxModel<String> comboBoxModel = new DefaultComboBoxModel<>();
        for (String date : monthYearList) {
            comboBoxModel.addElement(date);
        }

        comboBox.setModel(comboBoxModel);
        comboBox.setSelectedIndex(currentMonth);
    }

//  scroll cuối dòng bảng
    public static void scrollEndTable(JTable table) {
        SwingUtilities.invokeLater(() -> {
            int rowCount = table.getRowCount();
            if (rowCount > 0) {
                table.scrollRectToVisible(table.getCellRect(rowCount - 1, 0, true));
            }
        });
    }

}
