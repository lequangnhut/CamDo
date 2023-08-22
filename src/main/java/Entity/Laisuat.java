package Entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "Laisuat")
public class Laisuat {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private int phantram;

    @OneToMany(mappedBy = "laisuat")
    private List<Phieucam> phieucams;

    public Laisuat() {
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPhantram() {
        return this.phantram;
    }

    public void setPhantram(int phantram) {
        this.phantram = phantram;
    }

    public List<Phieucam> getPhieucams() {
        return this.phieucams;
    }

    public void setPhieucams(List<Phieucam> phieucams) {
        this.phieucams = phieucams;
    }

    public Phieucam addPhieucam(Phieucam phieucam) {
        getPhieucams().add(phieucam);
        phieucam.setLaisuat(this);

        return phieucam;
    }

    public Phieucam removePhieucam(Phieucam phieucam) {
        getPhieucams().remove(phieucam);
        phieucam.setLaisuat(null);

        return phieucam;
    }

}
