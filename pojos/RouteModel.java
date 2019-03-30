package POJOs;

import javax.persistence.*;

@Entity
@Table(name = "route")
public class RouteModel {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "route_id")
    private Long _routeId;

    @Column(name = "timetable")
    @ManyToOne
    private TimetableModel _timetableModel;

    //soll dia "number" an string si oder a int??
    @Column(name = "number")
    private String _number;

    @Column(name = "variation")
    private String _variation;

    public Long getRouteId() {
        return _routeId;
    }

    public void setRouteId(Long routeId) {
        _routeId = routeId;
    }

    public TimetableModel getTimetableModel() {
        return _timetableModel;
    }

    public void setTimetableModel(TimetableModel timetableModel) {
        _timetableModel = timetableModel;
    }

    public String getNumber() {
        return _number;
    }

    public void setNumber(String number) {
        _number = number;
    }

    public String getVariation() {
        return _variation;
    }

    public void setVariation(String variation) {
        _variation = variation;
    }
}
