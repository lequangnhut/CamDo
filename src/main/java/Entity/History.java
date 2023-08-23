package Entity;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "Historys")
public class History {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "Hanhdong")
    private String hanhdong;

    @Column(name = "ThoiGianTruyCap")
    private Timestamp thoiGianTruyCap;

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
