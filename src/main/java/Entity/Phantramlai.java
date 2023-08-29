package Entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;

/**
 * The persistent class for the Phantramlai database table.
 *
 */
@Entity
@NamedQuery(name = "Phantramlai.findAll", query = "SELECT p FROM Phantramlai p")
public class Phantramlai implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private int phantram;

    //bi-directional many-to-one association to Phieucam
    @OneToMany(mappedBy = "phantramlai")
    private List<Phieucam> phieucams;

    public Phantramlai() {
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
        phieucam.setPhantramlai(this);

        return phieucam;
    }

    public Phieucam removePhieucam(Phieucam phieucam) {
        getPhieucams().remove(phieucam);
        phieucam.setPhantramlai(null);

        return phieucam;
    }

}
