package Utils;

import Entity.User;

public class SessionManager {

    private static boolean loggedIn = false;
    private static User currentUser;

    public static void login(User user) {
        loggedIn = true;
        currentUser = user;
    }

    public static void logout() {
        loggedIn = false;
        currentUser = null;
    }

    public static boolean isLoggedIn() {
        return loggedIn;
    }

    public static User getCurrentUser() {
        return currentUser;
    }
}
