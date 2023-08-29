package Entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;

@Entity
public class Donglai implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private Timestamp ngaydonglai;

    private String status;

    private int tiendonglai;

    private boolean isActive;

    @ManyToOne
    @JoinColumn(name = "makh_id")
    private Customer customer;

    @ManyToOne
    private Phieucam phieucam;

    public Donglai() {
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Timestamp getNgaydonglai() {
        return this.ngaydonglai;
    }

    public void setNgaydonglai(Timestamp ngaydonglai) {
        this.ngaydonglai = ngaydonglai;
    }

    public String getStatus() {
        return this.status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getTiendonglai() {
        return this.tiendonglai;
    }

    public void setTiendonglai(int tiendonglai) {
        this.tiendonglai = tiendonglai;
    }

    public Customer getCustomer() {
        return this.customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Phieucam getPhieucam() {
        return this.phieucam;
    }

    public void setPhieucam(Phieucam phieucam) {
        this.phieucam = phieucam;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

}
