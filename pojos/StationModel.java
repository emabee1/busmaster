package at.fhv.tf.model;

import javax.persistence.*;

/**
 * @author Lukas Bals
 */
@Entity
@Table(name = "station")
public class StationModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "station_id", updatable = false, nullable = false)
    private String _stationId;
    @Column(name = "name")
    private String _name;
    @Column(name = "location_description")
    private String _locationDescription;

    public String getStationId() {
        return _stationId;
    }

    public void setStationId(String stationId) {
        this._stationId = stationId;
    }

    public String getName() {
        return _name;
    }

    public void setName(String name) {
        this._name = name;
    }

    public String getLocationDescription() {
        return _locationDescription;
    }

    public void setLocationDescription(String locationDescription) {
        this._locationDescription = locationDescription;
    }

    @Override
    public String toString() {
        return getName();
    }
}

