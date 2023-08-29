package Entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;

/**
 * The persistent class for the Customer database table.
 *
 */
@Entity
@NamedQuery(name = "Customer.findAll", query = "SELECT c FROM Customer c")
public class Customer implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String fullname;

    private String phonenumber;

    // bi-directional many-to-one association to Donglai
    @OneToMany(mappedBy = "customer")
    private List<Donglai> donglais;

    // bi-directional many-to-one association to Phieucam
    @OneToMany(mappedBy = "customer")
    private List<Phieucam> phieucams;

    public Customer() {
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

    public String getPhonenumber() {
        return this.phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    public List<Donglai> getDonglais() {
        return this.donglais;
    }

    public void setDonglais(List<Donglai> donglais) {
        this.donglais = donglais;
    }

    public Donglai addDonglai(Donglai donglai) {
        getDonglais().add(donglai);
        donglai.setCustomer(this);

        return donglai;
    }

    public Donglai removeDonglai(Donglai donglai) {
        getDonglais().remove(donglai);
        donglai.setCustomer(null);

        return donglai;
    }

    public List<Phieucam> getPhieucams() {
        return this.phieucams;
    }

    public void setPhieucams(List<Phieucam> phieucams) {
        this.phieucams = phieucams;
    }

    public Phieucam addPhieucam(Phieucam phieucam) {
        getPhieucams().add(phieucam);
        phieucam.setCustomer(this);

        return phieucam;
    }

    public Phieucam removePhieucam(Phieucam phieucam) {
        getPhieucams().remove(phieucam);
        phieucam.setCustomer(null);

        return phieucam;
    }

}
