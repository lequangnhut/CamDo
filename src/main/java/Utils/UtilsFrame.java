package Utils;

import DAO.PhieuCamDao;
import Entity.Phieucam;
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

/**
 *
 * @author NHUTLQ
 */
public class UtilsFrame {

    public static final PhieuCamDao phieuCamDao = new PhieuCamDao();

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
            public Component getTableCellRendererComponent(JTable table, Object value,
                    boolean isSelected, boolean hasFocus,
                    int row, int column) {
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

    public static void checkAndUpdateStatus() {
        List<Phieucam> phieucam = phieuCamDao.findAll();
        LocalDate currentDate = LocalDate.now();

        for (Phieucam pc : phieucam) {
            Instant instant = pc.getNgayhethan().toInstant();
            LocalDate ngayHetHanLocalDate = instant.atZone(ZoneId.systemDefault()).toLocalDate();

            long daysUntilExpiration = ChronoUnit.DAYS.between(currentDate, ngayHetHanLocalDate);
            if (daysUntilExpiration < 0) {
                pc.setStatus("Đã quá hạn " + Math.abs(daysUntilExpiration) + " ngày");
                phieuCamDao.update(pc);
            }
        }
    }

}
