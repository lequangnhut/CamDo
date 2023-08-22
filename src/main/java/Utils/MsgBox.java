package Utils;

import java.awt.Component;
import javax.swing.JOptionPane;

/**
 * @author NHUTLQ
 */
public class MsgBox {

    public static void alert(Component parent, String message) {
        JOptionPane.showMessageDialog(parent, message, "Thông Báo", JOptionPane.DEFAULT_OPTION);
    }

    public static boolean comfirm(Component parent, String message) {
        int result = JOptionPane.showConfirmDialog(parent, message, "Thông Báo", JOptionPane.YES_NO_OPTION, JOptionPane.DEFAULT_OPTION);
        return result == JOptionPane.YES_OPTION;
    }

    public static String prompt(Component parent, String message) {
        return JOptionPane.showInputDialog(parent, message, "Thông Báo", JOptionPane.DEFAULT_OPTION);
    }
}
