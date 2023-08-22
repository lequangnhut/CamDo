package Utils;

import Entity.User;

/**
 * @author NHUTLQ
 */
public class Auth {

    public static User user = null;

    public static void clear() {
        Auth.user = null;
    }

    public static boolean isLogin() {
        return Auth.user != null;
    }

    public static boolean isManager() {
        return Auth.isLogin();
    }

}
