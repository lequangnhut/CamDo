package DAO;

import Entity.Phieucam;
import SQL.JPAUtil;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

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
