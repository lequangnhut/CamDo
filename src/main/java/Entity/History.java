package Entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;

/**
 * The persistent class for the Historys database table.
 *
 */
@Entity
@Table(name = "Historys")
@NamedQuery(name = "History.findAll", query = "SELECT h FROM History h")
public class History implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "Hanhdong")
    private String hanhdong;

    @Column(name = "ThoiGianTruyCap")
    private Timestamp thoiGianTruyCap;

    //bi-directional many-to-one association to User
    @ManyToOne
    @JoinColumn(name = "userid")
    private User user;

    public History() {
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getHanhdong() {
        return this.hanhdong;
    }

    public void setHanhdong(String hanhdong) {
        this.hanhdong = hanhdong;
    }

    public Timestamp getThoiGianTruyCap() {
        return this.thoiGianTruyCap;
    }

    public void setThoiGianTruyCap(Timestamp thoiGianTruyCap) {
        this.thoiGianTruyCap = thoiGianTruyCap;
    }

    public User getUser() {
        return this.user;
    }

    public void setUser(User user) {
        this.user = user;
    }

}
