package Entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;

/**
 * The persistent class for the Phieucam database table.
 *
 */
@Entity
@NamedQuery(name = "Phieucam.findAll", query = "SELECT p FROM Phieucam p")
public class Phieucam implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String bienso;

    private boolean isActive;

    private String maphieu;

    private Date ngayra;

    private Date ngayvao;

    private int phantram;

    private String status;

    private int tiengoc;

    private int tienlai;

    //bi-directional many-to-one association to Donglai
    @OneToMany(mappedBy = "phieucam")
    private List<Donglai> donglais;

    //bi-directional many-to-one association to Customer
    @ManyToOne
    @JoinColumn(name = "makh_id")
    private Customer customer;

    //bi-directional many-to-one association to Phantramlai
    @ManyToOne
    private Phantramlai phantramlai;

    //bi-directional many-to-one association to User
    @ManyToOne
    private User user;

    public Phieucam() {
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBienso() {
        return this.bienso;
    }

    public void setBienso(String bienso) {
        this.bienso = bienso;
    }

    public boolean getIsActive() {
        return this.isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public String getMaphieu() {
        return this.maphieu;
    }

    public void setMaphieu(String maphieu) {
        this.maphieu = maphieu;
    }

    public Date getNgayra() {
        return this.ngayra;
    }

    public void setNgayra(Date ngayra) {
        this.ngayra = ngayra;
    }

    public Date getNgayvao() {
        return this.ngayvao;
    }

    public void setNgayvao(Date ngayvao) {
        this.ngayvao = ngayvao;
    }

    public int getPhantram() {
        return this.phantram;
    }

    public void setPhantram(int phantram) {
        this.phantram = phantram;
    }

    public String getStatus() {
        return this.status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getTiengoc() {
        return this.tiengoc;
    }

    public void setTiengoc(int tiengoc) {
        this.tiengoc = tiengoc;
    }

    public int getTienlai() {
        return this.tienlai;
    }

    public void setTienlai(int tienlai) {
        this.tienlai = tienlai;
    }

    public List<Donglai> getDonglais() {
        return this.donglais;
    }

    public void setDonglais(List<Donglai> donglais) {
        this.donglais = donglais;
    }

    public Donglai addDonglai(Donglai donglai) {
        getDonglais().add(donglai);
        donglai.setPhieucam(this);

        return donglai;
    }

    public Donglai removeDonglai(Donglai donglai) {
        getDonglais().remove(donglai);
        donglai.setPhieucam(null);

        return donglai;
    }

    public Customer getCustomer() {
        return this.customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Phantramlai getPhantramlai() {
        return this.phantramlai;
    }

    public void setPhantramlai(Phantramlai phantramlai) {
        this.phantramlai = phantramlai;
    }

    public User getUser() {
        return this.user;
    }

    public void setUser(User user) {
        this.user = user;
    }

}
