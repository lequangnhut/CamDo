package DAO;

import Entity.Laisuat;

/**
 *
 * @author NHUTLQ
 */
public class LaisuatDao extends AbstactDao<Laisuat> {

    public Laisuat findById() {
        String jpql = "SELECT o FROM Laisuat o WHERE o.id = 1";
        return super.findOne(Laisuat.class, jpql);
    }

    public Laisuat update(int phantram) {
        Laisuat ls = findById();
        if (ls != null) {
            ls.setPhantram(phantram);
            super.update(ls);
        }
        return ls;
    }

    public String getPhantramLS() {
        Laisuat ls = findById();
        String phantram = ls.getPhantram() + "%";
        return phantram;
    }

}
