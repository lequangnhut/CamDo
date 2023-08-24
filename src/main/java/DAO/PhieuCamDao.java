package DAO;

import Entity.Phieucam;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import SQL.JPAUtil;
import java.time.LocalDate;

/**
 * @author NHUTLQ
 */
public class PhieuCamDao extends AbstactDao<Phieucam> {

    public List<Phieucam> findAll() {
        return super.findAll(Phieucam.class, true);
    }

    public Phieucam findByMaPhieu(String maphieu) {
        String jpql = "SELECT o FROM Phieucam o WHERE o.maphieu = ?0";
        return super.findOne(Phieucam.class, jpql, maphieu);
    }
    
//    tìm lai trong tháng
    public int findTotalPhieuTrongThang() {
        EntityManager entityManager = JPAUtil.getEntityManager();

        LocalDate currentDate = LocalDate.now();
        int currentMonth = currentDate.getMonthValue();

        String jpql = "SELECT COUNT(o) FROM Phieucam o WHERE MONTH(o.ngaycam) = ?0";
        Query query = entityManager.createQuery(jpql);
        query.setParameter(0, currentMonth);

        Long totalCount = (Long) query.getSingleResult();
        return totalCount.intValue();
    }

    public int findTotalTienLaiTrongThang() {
        EntityManager entityManager = JPAUtil.getEntityManager();

        LocalDate currentDate = LocalDate.now();
        int currentMonth = currentDate.getMonthValue();

        String jpql = "SELECT SUM(o.giacamco) FROM Phieucam o WHERE MONTH(o.ngaycam) = ?0";
        Query query = entityManager.createQuery(jpql);
        query.setParameter(0, currentMonth);

        Long totalMoney = (Long) query.getSingleResult();
        if (totalMoney != null) {
            return totalMoney.intValue();
        } else {
            return 0;
        }
    }

//    tìm lai trong ngày
    public int findTotalPhieuTrongNgay() {
        EntityManager entityManager = JPAUtil.getEntityManager();

        LocalDate currentDate = LocalDate.now();
        int dayOfMonth = currentDate.getDayOfMonth();

        String jpql = "SELECT COUNT(o) FROM Phieucam o WHERE DAY(o.ngaycam) = ?0 AND isActive = 1";
        Query query = entityManager.createQuery(jpql);
        query.setParameter(0, dayOfMonth);

        Long totalCount = (Long) query.getSingleResult();
        return totalCount.intValue();
    }

    public int findTotalTienLaiTrongNgay() {
        EntityManager entityManager = JPAUtil.getEntityManager();

        LocalDate currentDate = LocalDate.now();
        int dayOfMonth = currentDate.getDayOfMonth();

        String jpql = "SELECT SUM(o.giacamco) FROM Phieucam o WHERE DAY(o.ngaycam) = ?0 AND isActive = 1";
        Query query = entityManager.createQuery(jpql);
        query.setParameter(0, dayOfMonth);

        Long totalMoney = (Long) query.getSingleResult();
        if (totalMoney != null) {
            return totalMoney.intValue();
        } else {
            return 0;
        }
    }

//    thêm thông tin lai
    public Phieucam addPhieu(Phieucam entity) {
        return super.create(entity);
    }

    public Phieucam editPhieu(Phieucam entity) {
        return super.update(entity);
    }

    public Phieucam deletePhieu(String maphieu) {
        Phieucam pc = findByMaPhieu(maphieu);
        if (pc != null) {
            pc.setIsActive(Boolean.FALSE);
            super.update(pc);
        }
        return pc;
    }

    public String generateNewMaphieu() {
        EntityManager entityManager = JPAUtil.getEntityManager();
        String maphieu = "";
        String jpql = "SELECT MAX(o.maphieu) FROM Phieucam o";

        TypedQuery<String> query = entityManager.createQuery(jpql, String.class);
        String maxMaphieu = query.getSingleResult();

        if (maxMaphieu == null) {
            maphieu = "0001";
        } else {
            String numPart = maxMaphieu.substring(1).trim().replaceAll("[^\\d]", "");
            int num = Integer.parseInt(numPart) + 1;
            maphieu = String.format("%04d", num);
        }

        return maphieu;
    }

}
