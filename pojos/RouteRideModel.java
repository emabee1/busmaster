package POJOs;

import javax.persistence.*;

@Entity
@Table(name = "route_ride")
public class RouteRideModel {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "route_ride_id")
    private Long _routeRideId;

    @Column(name = "shift_day_id")
    @ManyToOne
    private ShiftDayModel _shiftDayModel;

    @Column(name = "starttime_id")
    @ManyToOne
    private StartTimeModel _startTimeModel;

    @Column(name = "path_id")
    @ManyToOne
    private PathModel _pathModel;

    public Long getRouteRideId() {
        return _routeRideId;
    }

    public void setRouteRideId(Long routeRideId) {
        _routeRideId = routeRideId;
    }

    public ShiftDayModel getShiftDayModel() {
        return _shiftDayModel;
    }

    public void setShiftDayModel(ShiftDayModel shiftDayModel) {
        _shiftDayModel = shiftDayModel;
    }

    public StartTimeModel getStartTimeModel() {
        return _startTimeModel;
    }

    public void setStartTimeModel(StartTimeModel startTimeModel) {
        _startTimeModel = startTimeModel;
    }

    public PathModel getPathModel() {
        return _pathModel;
    }

    public void setPathModel(PathModel pathModel) {
        _pathModel = pathModel;
    }
}
