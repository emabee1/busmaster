package POJOs;

import javax.persistence.*;
import java.time.LocalDate;


@Entity
@Table(name = "suspended")
public class SuspendedModel {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "suspended_id")
    private Long _suspendedId;

    @ManyToOne
    private BusModel _busModel;

    @Column(name = "startdate")
    private LocalDate _startDate;

    @Column(name = "enddate")
    private LocalDate _endDate;

    @Column(name = "cause")
    private String _cause;

    public Long getSuspendedId() {
        return _suspendedId;
    }

    public void setSuspendedId(Long suspendedId) {
        _suspendedId = suspendedId;
    }

    public BusModel getBusModel() {
        return _busModel;
    }

    public void setBusModel(BusModel busModel) {
        _busModel = busModel;
    }

    public LocalDate getStartDate() {
        return _startDate;
    }

    public void setStartDate(LocalDate startDate) {
        _startDate = startDate;
    }

    public LocalDate getEndDate() {
        return _endDate;
    }

    public void setEndDate(LocalDate endDate) {
        _endDate = endDate;
    }

    public String getCause() {
        return _cause;
    }

    public void setCause(String cause) {
        _cause = cause;
    }
}
