package Entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;

/**
 * The persistent class for the Users database table.
 *
 */
@Entity
@Table(name = "Users")
@NamedQuery(name = "User.findAll", query = "SELECT u FROM User u")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String fullname;

    private boolean isAdmin;

    private String password;

    private String username;

    //bi-directional many-to-one association to History
    @OneToMany(mappedBy = "user")
    private List<History> historys;

    //bi-directional many-to-one association to Phieucam
    @OneToMany(mappedBy = "user")
    private List<Phieucam> phieucams;

    public User() {
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullname() {
        return this.fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public boolean getIsAdmin() {
        return this.isAdmin;
    }

    public void setIsAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return this.username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public List<History> getHistorys() {
        return this.historys;
    }

    public void setHistorys(List<History> historys) {
        this.historys = historys;
    }

    public History addHistory(History history) {
        getHistorys().add(history);
        history.setUser(this);

        return history;
    }

    public History removeHistory(History history) {
        getHistorys().remove(history);
        history.setUser(null);

        return history;
    }

    public List<Phieucam> getPhieucams() {
        return this.phieucams;
    }

    public void setPhieucams(List<Phieucam> phieucams) {
        this.phieucams = phieucams;
    }

    public Phieucam addPhieucam(Phieucam phieucam) {
        getPhieucams().add(phieucam);
        phieucam.setUser(this);

        return phieucam;
    }

    public Phieucam removePhieucam(Phieucam phieucam) {
        getPhieucams().remove(phieucam);
        phieucam.setUser(null);

        return phieucam;
    }

}
