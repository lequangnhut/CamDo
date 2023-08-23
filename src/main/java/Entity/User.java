package Entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "Users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    private String fullname;

    private String password;

    private String username;

    private boolean isAdmin;

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
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public boolean isAdmin() {
		return isAdmin;
	}

	public void setAdmin(boolean isAdmin) {
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

    public List<Phieucam> getPhieucams() {
        return this.phieucams;
    }

    public boolean isIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
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
