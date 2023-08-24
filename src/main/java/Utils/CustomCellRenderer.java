package Utils;

import javax.swing.*;
import javax.swing.table.DefaultTableCellRenderer;
import java.awt.*;

public class CustomCellRenderer extends DefaultTableCellRenderer {

    @Override
    public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
        Component component = super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);

        String status = (String) table.getValueAt(row, 9); // Lấy giá trị cột "Trạng thái" tại dòng hiện tại

        if (status.contains("Đã quá hạn")) {
            component.setBackground(Color.RED); // Tô màu đỏ cho toàn bộ dòng có trạng thái bắt đầu bằng "Đã quá hạn"
            component.setFont(component.getFont().deriveFont(Font.BOLD)); // Đặt font chữ in đậm
        } else {
            component.setBackground(table.getBackground()); // Sử dụng màu nền mặc định cho các dòng khác
            component.setFont(component.getFont().deriveFont(Font.PLAIN)); // Đặt font chữ bình thường
        }

        return component;
    }
}
