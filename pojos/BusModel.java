package POJOs;


import javax.persistence.*;

@Entity
@Table(name = "bus")
public class BusModel {
    @Id
    @Column(name = "bus_id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long _busId;

    @Column(name = "capacity")
    private int _capacity;

    @Column(name = "seats")
    private int _seats;

    @Column(name = "operational_area")
    private String _operationalArea;

    @Column(name = "current_km")
    private int _currentKm;

    public Long getBusId() {
        return _busId;
    }

    public void setBusId(Long busId) {
        _busId = busId;
    }

    public int getCapacity() {
        return _capacity;
    }

    public void setCapacity(int capacity) {
        _capacity = capacity;
    }

    public int getSeats() {
        return _seats;
    }

    public void setSeats(int seats) {
        _seats = seats;
    }

    public String getOperationalArea() {
        return _operationalArea;
    }

    public void setOperationalArea(String operationalArea) {
        _operationalArea = operationalArea;
    }

    public int getCurrentKm() {
        return _currentKm;
    }

    public void setCurrentKm(int currentKm) {
        _currentKm = currentKm;
    }

}
