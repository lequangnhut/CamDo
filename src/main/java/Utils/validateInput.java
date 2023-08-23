package Utils;

import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.regex.Pattern;
import javax.swing.JTextField;
import javax.swing.text.AbstractDocument;
import javax.swing.text.AttributeSet;
import javax.swing.text.BadLocationException;
import javax.swing.text.DocumentFilter;
import javax.swing.text.PlainDocument;

/**
 *
 * @author NHUTLQ
 */
public class validateInput {

//    chỉ cho phép nhập chữ
    public static void allowOnlyText(JTextField textField) {
        AbstractDocument doc = (AbstractDocument) textField.getDocument();
        doc.setDocumentFilter(new DocumentFilter() {
            @Override
            public void replace(FilterBypass fb, int offset, int length,
                    String text, AttributeSet attrs) throws BadLocationException {
                if (!containsNumber(text)) {
                    super.replace(fb, offset, length, text, attrs);
                }
            }

            private boolean containsNumber(String text) {
                for (char c : text.toCharArray()) {
                    if (Character.isDigit(c)) {
                        return true;
                    }
                }
                return false;
            }
        });
    }

//    chỉ cho phép nhập số 
    public static void allowOnlyNumbers(JTextField textField) {
        AbstractDocument doc = (AbstractDocument) textField.getDocument();
        doc.setDocumentFilter(new DocumentFilter() {
            @Override
            public void insertString(FilterBypass fb, int offset, String string,
                    AttributeSet attr) throws BadLocationException {
                if (containsOnlyNumbers(string)) {
                    super.insertString(fb, offset, string, attr);
                }
            }

            @Override
            public void replace(FilterBypass fb, int offset, int length,
                    String text, AttributeSet attrs) throws BadLocationException {
                if (containsOnlyNumbers(text)) {
                    super.replace(fb, offset, length, text, attrs);
                }
            }

            private boolean containsOnlyNumbers(String text) {
                for (char c : text.toCharArray()) {
                    if (!Character.isDigit(c)) {
                        return false;
                    }
                }
                return true;
            }
        });
    }

    //    chỉ cho phép nhập chữ
    public static void restrictMaxLength(JTextField textField, int maxLength) {
        AbstractDocument doc = (AbstractDocument) textField.getDocument();
        doc.setDocumentFilter(new DocumentFilter() {
            @Override
            public void insertString(FilterBypass fb, int offset, String string,
                    AttributeSet attr) throws BadLocationException {
                if (fb.getDocument().getLength() + string.length() <= maxLength) {
                    super.insertString(fb, offset, string, attr);
                }
            }

            @Override
            public void replace(FilterBypass fb, int offset, int length,
                    String text, AttributeSet attrs) throws BadLocationException {
                if (fb.getDocument().getLength() - length + text.length() <= maxLength) {
                    super.replace(fb, offset, length, text, attrs);
                }
            }
        });
    }

//    tự động viết hoa
    public static void autoUpperCaseWithMaxLength(JTextField textField, int maxLength) {
        PlainDocument doc = (PlainDocument) textField.getDocument();
        doc.setDocumentFilter(new UppercaseDocumentFilterWithMaxLength(maxLength));
    }

    static class UppercaseDocumentFilterWithMaxLength extends DocumentFilter {

        private int maxLength;

        public UppercaseDocumentFilterWithMaxLength(int maxLength) {
            this.maxLength = maxLength;
        }

        @Override
        public void insertString(FilterBypass fb, int offset, String text, AttributeSet attr) throws BadLocationException {
            if (text != null) {
                text = text.toUpperCase();
                if (fb.getDocument().getLength() + text.length() <= maxLength) {
                    super.insertString(fb, offset, text, attr);
                }
            }
        }

        @Override
        public void replace(FilterBypass fb, int offset, int length, String text, AttributeSet attrs) throws BadLocationException {
            if (text != null) {
                text = text.toUpperCase();
                if (fb.getDocument().getLength() - length + text.length() <= maxLength) {
                    super.replace(fb, offset, length, text, attrs);
                }
            }
        }
    }

//    định dạng số điện thoại Việt Nam
    public static void formatPhoneNumber(JTextField textField) {
        PlainDocument doc = (PlainDocument) textField.getDocument();
        doc.setDocumentFilter(new PhoneNumberDocumentFilter());

        textField.addKeyListener(new KeyListener() {
            @Override
            public void keyTyped(KeyEvent e) {
                if (!Character.isDigit(e.getKeyChar())) {
                    e.consume();
                }
            }

            @Override
            public void keyPressed(KeyEvent e) {
            }

            @Override
            public void keyReleased(KeyEvent e) {
            }
        });
    }

    static class PhoneNumberDocumentFilter extends DocumentFilter {

        private static final Pattern PHONE_NUMBER_PATTERN = Pattern.compile("\\d{0,10}");

        @Override
        public void insertString(FilterBypass fb, int offset, String text, AttributeSet attr) throws BadLocationException {
            String newStr = fb.getDocument().getText(0, fb.getDocument().getLength()) + text;
            if (!PHONE_NUMBER_PATTERN.matcher(newStr).matches()) {
                return;
            }
            super.insertString(fb, offset, text, attr);
        }

        @Override
        public void replace(FilterBypass fb, int offset, int length, String text, AttributeSet attrs) throws BadLocationException {
            String newStr = fb.getDocument().getText(0, fb.getDocument().getLength()).substring(0, offset) + text
                    + fb.getDocument().getText(offset + length, fb.getDocument().getLength() - offset - length);
            if (!PHONE_NUMBER_PATTERN.matcher(newStr).matches()) {
                return;
            }
            super.replace(fb, offset, length, text, attrs);
        }
    }

}
