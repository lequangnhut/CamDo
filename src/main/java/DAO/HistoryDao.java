package DAO;

import Entity.History;
import Entity.User;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * @author NHUTLQ
 */
public class HistoryDao extends AbstactDao<History> {

    public List<History> findAll(Date date) {
        String jpql = "SELECT h FROM History h WHERE FUNCTION('CONVERT', VARCHAR(10), h.thoiGianTruyCap, 23) = ?0";
        return super.findMany(History.class, jpql, date);
    }

    public History addHistory(User user, String hanhdong) {
        History his = new History();
        his.setUser(user);
        his.setThoiGianTruyCap(new Timestamp(System.currentTimeMillis()));
        his.setHanhdong(hanhdong);
        return super.create(his);
    }
}
