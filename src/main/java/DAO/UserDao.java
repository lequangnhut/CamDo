package DAO;

import Entity.User;

/**
 * @author NHUTLQ
 */
public class UserDao extends AbstactDao<User> {

    public User login(String username, String password) {
        String jpql = "SELECT o FROM User o WHERE o.username = ?0 AND o.password = ?1";
        return super.findOne(User.class, jpql, username, password);
    }

    public User findUserByUsername(String username) {
        String jpql = "SELECT o FROM User o WHERE o.username = ?0";
        return super.findOne(User.class, jpql, username);
    }

}
