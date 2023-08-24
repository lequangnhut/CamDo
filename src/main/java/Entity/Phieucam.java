package Entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Phieucam")
public class Phieucam {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String fullname;

    private int giacamco;

    private String maphieu;

    private Date ngaycam;

    private Date ngayhethan;

    private String phonenumber;

    private String status;

    private int tienlai;

    private String bienso;

    private int songaydonglai;

    private boolean isActive;

    @ManyToOne
    private Laisuat laisuat;

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

    public String getFullname() {
        return this.fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public int getGiacamco() {
        return this.giacamco;
    }

    public void setGiacamco(int giacamco) {
        this.giacamco = giacamco;
    }

    public String getMaphieu() {
        return this.maphieu;
    }

    public void setMaphieu(String maphieu) {
        this.maphieu = maphieu;
    }

    public Date getNgaycam() {
        return this.ngaycam;
    }

    public void setNgaycam(Date ngaycam) {
        this.ngaycam = ngaycam;
    }

    public Date getNgayhethan() {
        return this.ngayhethan;
    }

    public void setNgayhethan(Date ngayhethan) {
        this.ngayhethan = ngayhethan;
    }

    public String getPhonenumber() {
        return this.phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    public String getStatus() {
        return this.status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getTienlai() {
        return this.tienlai;
    }

    public void setTienlai(int tienlai) {
        this.tienlai = tienlai;
    }

    public Laisuat getLaisuat() {
        return this.laisuat;
    }

    public void setLaisuat(Laisuat laisuat) {
        this.laisuat = laisuat;
    }

    public String getBienso() {
        return bienso;
    }

    public void setBienso(String bienso) {
        this.bienso = bienso;
    }

    public int getSongaydonglai() {
        return songaydonglai;
    }

    public void setSongaydonglai(int songaydonglai) {
        this.songaydonglai = songaydonglai;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public User getUser() {
        return this.user;
    }

    public void setUser(User user) {
        this.user = user;
    }

}
