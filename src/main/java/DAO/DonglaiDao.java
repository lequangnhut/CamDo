package DAO;

import Entity.Donglai;
import java.util.List;

/**
 *
 * @author NHUTLQ
 */
public class DonglaiDao extends AbstactDao<Donglai> {

    public List<Donglai> findByMaKHId(int makh_id) {
        String jpql = "SELECT o FROM Donglai o WHERE o.customer.id = ?0";
        return super.findMany(Donglai.class, jpql, makh_id);
    }

    public Donglai findById(int id) {
        return super.findById(Donglai.class, id);
    }

    public Donglai createdl(Donglai entity) {
        return super.create(entity);
    }

    public Donglai deletedl(Donglai entity, int id) {
        entity = findById(id);
        if (entity != null) {
            return super.update(entity);
        }
        return entity;
    }
}
