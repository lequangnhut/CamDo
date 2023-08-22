package Entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "Users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String password;

    private String username;

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
