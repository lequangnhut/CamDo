package Utils;

import java.text.NumberFormat;
import java.text.ParseException;
import java.util.Locale;
import javax.swing.JTextField;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;

public class XMoney {

    public static String formatMoney(int amount) {
        Locale vietnamLocale = new Locale("vi", "VN");
        NumberFormat formatter = NumberFormat.getCurrencyInstance(vietnamLocale);

        String formattedAmount = formatter.format(amount);
        formattedAmount = formattedAmount.trim();

        return formattedAmount;
    }

    public static void formatCurrency(JTextField textField) {
        String input = textField.getText().replaceAll("[^0-9]", ""); // Lấy chỉ số số từ chuỗi
        if (!input.isEmpty()) {
            long number = Long.parseLong(input);
            String formattedCurrency = NumberFormat.getCurrencyInstance(new Locale("vi", "VN")).format(number);
            textField.setText(formattedCurrency);
        }
    }

    public static String formatMoneyVIFormDB(int money) {
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        String formattedAmount = currencyFormat.format(money);
        return formattedAmount;
    }

    public static void caculatorLaixuat(JTextField txtSotien, JTextField txtTongtienthang) {
        txtSotien.getDocument().addDocumentListener(new DocumentListener() {
            @Override
            public void insertUpdate(DocumentEvent e) {
                calculateInterest(txtSotien, txtTongtienthang);
            }

            @Override
            public void removeUpdate(DocumentEvent e) {
                calculateInterest(txtSotien, txtTongtienthang);
            }

            @Override
            public void changedUpdate(DocumentEvent e) {
                calculateInterest(txtSotien, txtTongtienthang);
            }
        });
    }

    public static void calculateInterest(JTextField txtSotien, JTextField txtTongtienthang) {
        try {
            NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            double amount = currencyFormat.parse(txtSotien.getText()).doubleValue();
            double interestRate = 0.06; // Phần trăm lãi suất trong ví dụ này
            double interest = amount * interestRate;
            txtTongtienthang.setText(currencyFormat.format(interest));
        } catch (ParseException ex) {
            txtTongtienthang.setText("Trống");
        }
    }
}
