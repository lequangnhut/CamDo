package DAO;

import Entity.Phantramlai;

/**
 *
 * @author NHUTLQ
 */
public class PhantramlaiDao extends AbstactDao<Phantramlai> {
    
    public Phantramlai findById() {
        String jpql = "SELECT o FROM Phantramlai o WHERE o.id = 1";
        return super.findOne(Phantramlai.class, jpql);
    }
    
    public Phantramlai update(int phantram) {
        Phantramlai ls = findById();
        if (ls != null) {
            ls.setPhantram(phantram);
            super.update(ls);
        }
        return ls;
    }
    
    public Double getPhantramLS() {
        Phantramlai ls = findById(); // Giả sử bạn có một phương thức tương tự findById() để tìm đối tượng Phantramlai
        if (ls != null) {
            String phantram = String.valueOf(ls.getPhantram());
            try {
                double phantramValue = Double.parseDouble(phantram);
                return phantramValue;
            } catch (NumberFormatException e) {
                // Xử lý nếu không thể chuyển đổi thành số
                e.printStackTrace();
            }
        }
        return null; // Trả về null nếu có lỗi hoặc không có đối tượng Phantramlai
    }
    
}
